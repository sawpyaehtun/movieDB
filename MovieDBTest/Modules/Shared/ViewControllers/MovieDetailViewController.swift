//
//  MovieDetailViewController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import SDWebImage

class MovieDetailViewController: BaseViewController {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var imgBackgroundPoster: UIImageView!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var btnFavourite: UIButton!
    
    var movie : MovieVO?
    
    let viewModel = MovieDetailViewModel()
    
    var isFavourite = false {
        didSet {
            setupBtnFavourite()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getFavMovieList()
    }
    
    override func setupUI() {
        super.setupUI()
        
        if let movie = movie {
            self.title = movie.title
            lblOverview.text = movie.overview
            imgBackgroundPoster.sd_setImage(with: URL(string: "\(ApiConfig.BASE_IMG_URL)\(movie.posterPath ?? "")"), placeholderImage: UIImage(systemName: "square.and.arrow.down.fill"))
            imgPoster.sd_setImage(with: URL(string: "\(ApiConfig.BASE_IMG_URL)\(movie.posterPath ?? "")"), placeholderImage: UIImage(systemName: "square.and.arrow.down.fill"))
        }
    }
    
    override func bindData() {
        super.bindData()
        btnFavourite.rx.tap.bind{
            if let movie = self.movie {
                if self.isFavourite {
                    self.viewModel.removeFromFavourite(moview: movie)
                } else {
                    self.viewModel.addToFavourite(movie: movie)
                }
                self.isFavourite.toggle()
            }
        }.disposed(by: disposableBag)
        
        viewModel.favMovieListPublishRelay.bind{ movieList in
            print("this this this")
            if let movie = self.movie {
                self.isFavourite = movieList.contains(where: { $0.id == movie.id})
            }
        }.disposed(by: disposableBag)
    }
    
    func setupBtnFavourite(){
        btnFavourite.tintColor = isFavourite ? .systemPink : .lightGray
    }

}
