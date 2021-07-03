//
//  HomeViewModel.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import RxCocoa
import RxSwift

class HomeViewModel: BaseViewModel {
    
    let popularMovieListBehaviorRelay = BehaviorRelay<[MovieVO]>(value: [])
    let upComingMovieListBehaviorRelay = BehaviorRelay<[MovieVO]>(value: [])
    let provider = MovieProvider()
    
    override init() {
        super.init()
    }
}



extension HomeViewModel {
    
    func getMovieList() {
        popularMovieListBehaviorRelay.accept(provider.getMovieList(type: .PopularMovieRO))
        upComingMovieListBehaviorRelay.accept(provider.getMovieList(type: .UpComingMovieRO))
        fetchPopularMovieList()
        fetchUpComingMovieList()
    }
    
    func fetchPopularMovieList(){
        if popularMovieListBehaviorRelay.value.isEmpty && upComingMovieListBehaviorRelay.value.isEmpty{
            loadingPublishRelay.accept(true)
        }
        provider.fetchMovie(fetchMovieType: .popular).subscribe{
            self.loadingPublishRelay.accept(false)
            if $0.isEmpty {
                self.isNoDataPublishRelay.accept(Void())
            } else {
                self.provider.setMovieList(movieList: $0,type: .PopularMovieRO)
                self.popularMovieListBehaviorRelay.accept($0)
            }
        }onError: { (error) in
            self.loadingPublishRelay.accept(false)
            self.errorPublishRelay.accept(error)
        }.disposed(by: disposableBag)
    }
    
    func fetchUpComingMovieList(){
        if popularMovieListBehaviorRelay.value.isEmpty && upComingMovieListBehaviorRelay.value.isEmpty{
            loadingPublishRelay.accept(true)
        }
        provider.fetchMovie(fetchMovieType: .upcoming).subscribe{
            self.loadingPublishRelay.accept(false)
            if $0.isEmpty {
                self.isNoDataPublishRelay.accept(Void())
            } else {
                self.provider.setMovieList(movieList: $0,type: .UpComingMovieRO)
                self.upComingMovieListBehaviorRelay.accept($0)
            }
        }onError: { (error) in
            self.loadingPublishRelay.accept(false)
            self.errorPublishRelay.accept(error)
        }.disposed(by: disposableBag)
    }
    
}
