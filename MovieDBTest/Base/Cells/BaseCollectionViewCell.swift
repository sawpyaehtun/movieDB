//
//  BaseCollectionViewCell.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import RxSwift
import RxCocoa

class BaseCollectionViewCell: UICollectionViewCell {
    
    var disposableBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupLanguage()
        setupTest()
        bindData()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposableBag = DisposeBag()
    }
    
    func setupUI(){
        
    }
    
    func setupLanguage(){
        
    }
    
    func setupTest(){
        
    }
    
    func bindData(){
        
    }
    
}
