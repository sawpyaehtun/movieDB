//
//  BaseView.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import RxCocoa
import RxSwift

class BaseView : UIView {
    
    var disposableBag = DisposeBag()
    
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTest()
        setupLanguae()
        bindData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
        setupTest()
        setupLanguae()
        bindData()
    }
    
    func setupLanguae(){
        
    }
    
    func bindData(){
        
    }
    
    func setupUI() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView! {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView ?? UIView(frame: CGRect.zero)
    }
    
    func setupTest() {
        
    }

}

