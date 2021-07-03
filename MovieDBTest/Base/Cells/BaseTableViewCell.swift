//
//  BaseTableViewCell.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import RxCocoa
import RxSwift

class BaseTableViewCell: UITableViewCell {
    
    let leadingMultiplyConstant = CGFloat(0.04)
    var disposableBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUIs()
        setupLanguage()
        setupTest()
        bindData()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUIs(){
        selectionStyle = .none
    }
    
    func setupLanguage(){
        
    }

    override func prepareForReuse() {
        applyTheme()
        disposableBag = DisposeBag()
        bindData()
    }
    
    func applyTheme(){
        selectionStyle = .none
    }
    
    func setupTest() {
        
    }
    
    func bindData() {
        
    }
}
