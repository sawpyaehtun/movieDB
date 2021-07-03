//
//  MovieListTableViewCell.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit

class MovieListTableViewCell: BaseTableViewCell {

    @IBOutlet weak var lblCategoryTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var heightCollectionView: NSLayoutConstraint!
    
    let numberOfItemsInRow : CGFloat = 3.0
    let spacing : CGFloat = 10
    let leadingSpace : CGFloat = 10
    let TrailingSpace : CGFloat = 10

    var movieList : [MovieVO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    override func setupUIs() {
        setupCollectionView()
        heightCollectionView.constant = UIScreen.main.bounds.height * 0.3
    }

    private func setupCollectionView(){
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerForCells(cells: MovieItemCollectionViewCell.self)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        // calculating total padding
        let totalPadding : CGFloat = (numberOfItemsInRow * spacing) + leadingSpace + TrailingSpace
        let itemWidth = (self.contentView.frame.width - totalPadding) / numberOfItemsInRow
        
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.45)
    }
    
}

extension MovieListTableViewCell : UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        HomeScreen.HomeVC.navigateToMovieDetail(movieList[indexPath.row]).show()
    }
}

extension MovieListTableViewCell : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeReuseCell(type: MovieItemCollectionViewCell.self, indexPath: indexPath)
        item.movieVO = movieList[indexPath.row]
        return item
    }
    
}



