//
//  FavouriteViewController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit

class FavouriteViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FavouriteViewModel()
    var movieList : [MovieVO] = []
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavouritMovieListFromDB()
    }

    override func setupUI() {
        super.setupUI()
        title = "Favourite"
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerForCells(cells: MovieItemCollectionViewCell.self)
        collectionView.isHidden = true
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.view.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
        
        viewModel.movieListPublishRelay.bind{
            self.movieList = $0
            self.collectionView.isHidden = $0.isEmpty
            self.collectionView.reloadData()
        }.disposed(by: disposableBag)
    }
    
    override func bindData() {
        super.bindData()
        
    }
}

//MARK:- collectionView delegate and datasource
extension FavouriteViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return movieItem(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        FavouriteScreen.FavouriteVC.navigateToMovieDetail(movieList[indexPath.row]).show()
    }
}

//MARK:- items for collectionView
extension FavouriteViewController {
    func movieItem(indexPath : IndexPath) -> UICollectionViewCell{
        let item = collectionView.dequeReuseCell(type: MovieItemCollectionViewCell.self, indexPath: indexPath)
        item.movieVO = movieList[indexPath.row]
        return item
    }
}


