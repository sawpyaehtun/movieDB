//
//  HomeViewController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    let viewModel = HomeViewModel()
    
    var popularMovieList : [MovieVO] = []
    var upcomingMovieList : [MovieVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func fetchData() {
        super.fetchData()
        if self.popularMovieList.isEmpty && self.upcomingMovieList.isEmpty{
            viewModel.getMovieList()
        } else {
            viewModel.fetchPopularMovieList()
            viewModel.fetchUpComingMovieList()
        }
    }
    
    override func setupUI() {
        super.setupUI()
        title = "Home"
    }
    
    override func setupTableView() {
        super.setupTableView()
        tableView.registerForCells(cells: MovieListTableViewCell.self)
        tableView.isHidden = true
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
    }
    
    override func bindData() {
        super.bindData()
        
        viewModel.upComingMovieListBehaviorRelay.skip(1).bind{
            self.upcomingMovieList = $0
            self.tableViewReloadData()
        }.disposed(by: disposableBag)
        
        viewModel.popularMovieListBehaviorRelay.skip(1).bind{
            self.popularMovieList = $0
            self.tableViewReloadData()
        }.disposed(by: disposableBag)
        
        viewModel.isNoDataPublishRelay.bind{
            
            if self.popularMovieList.isEmpty && self.upcomingMovieList.isEmpty{
                self.tableView.isHidden = true
                self.isShowNoDataAndInternet(isShow: true)
            } else {
                self.showToast(message: "No data")
            }
            
        }.disposed(by: disposableBag)
        
        viewModel.isSeverErrorPublishRelay.bind{
            if self.popularMovieList.isEmpty && self.upcomingMovieList.isEmpty{
                self.tableView.isHidden = true
                self.isShowNoDataAndInternet(isShow: true, isServerError: true)
            } else {
                self.showToast(message: "Sever error!")
            }
        }.disposed(by: disposableBag)
        
        viewModel.isNoInternetPublishRelay.bind{
            if self.popularMovieList.isEmpty && self.upcomingMovieList.isEmpty{
                self.tableView.isHidden = true
                self.isShowNoDataAndInternet(isShow: true, isServerError: false)
            } else {
                self.showToast(message: "No internet connectoin!")
            }
        }.disposed(by: disposableBag)
        
    }
    
    private func tableViewReloadData(){
        tableView.isHidden = false
        tableView.reloadData()
    }
    
}

//MARK:- tableView Delegate and Datasource
extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return movieListCell(indexPath: indexPath)
    }
}

//MARK:- cells for tableView
extension HomeViewController {
    private func movieListCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReuseCell(type: MovieListTableViewCell.self, indexPath: indexPath)
        switch indexPath.row {
        case 0:
            cell.lblCategoryTitle.text = "Popular"
            cell.movieList = popularMovieList
        case 1:
            cell.lblCategoryTitle.text = "Upcoming"
            cell.movieList = upcomingMovieList
        default:
            break
        }
        return cell
    }
}
