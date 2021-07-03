//
//  ErrorHandlerView.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation

import UIKit

protocol ErrorHandlerDelegate {
    func didTapRetry()
}

class ErrorHandlerView: BaseView {
    
    @IBOutlet weak var imgError: UIImageView!
    @IBOutlet weak var lblErrorTitle: UILabel!
    @IBOutlet weak var lblErrorDesc: UILabel!
    @IBOutlet weak var btnRetry: RoundedCornerUIButton!
    @IBOutlet weak var btnRetryHeightConstraint: NSLayoutConstraint!
    var delegate : ErrorHandlerDelegate?
    
    override func setupUI() {
        super.setupUI()
        btnRetry.setTitle("Retry", for: .normal)
        lblErrorTitle.font = .robotoBoldFont(size: 18.0)
        lblErrorDesc.font = .robotoFont(size: 16.0)
    }
    
    override func setupTest() {
        super.setupTest()
    }
    
    func setupView(isShow : Bool , isServerError : Bool = false , errorImage : UIImage? = nil , errorTitle : String? = nil , errorDesc : String? = nil) {
        
        var error_image : UIImage?
        var error_title : String?
        var error_desc : String?
        var isInternetAvailable = Bool()
        
        ApiClient.checkReachable(success: {
            isInternetAvailable = true
            if let image = errorImage,
               let title = errorTitle,
               let desc = errorDesc{
                
                error_image = image
                error_title = title
                error_desc = desc
            }else {
                error_image = #imageLiteral(resourceName: "warning")
                error_title = "No data!"
                error_desc = ""
            }
            
        }) {
            isInternetAvailable = false
            error_image = #imageLiteral(resourceName: "warning")
            error_title = "Could not connect"
            error_desc = "No internet connection"
        }
        
        if isServerError {
            error_image = #imageLiteral(resourceName: "warning")
            error_title = "Something went woring!"
            isInternetAvailable = false
            error_desc = ""
        }
        
        imgError.image = error_image
        lblErrorTitle.text = error_title
        lblErrorDesc.text = error_desc
        btnRetry.isHidden = isInternetAvailable
        btnRetryHeightConstraint.constant = isInternetAvailable ? 0.0 : 50.0
        btnRetry.isUserInteractionEnabled = true
        
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.setNeedsLayout()
    }
    
    func setupViewForOnlyDesc(isShow : Bool , errorDesc : String? = nil) {
        btnRetry.isHidden = true
        btnRetryHeightConstraint.constant = 0
        imgError.isHidden = true
        lblErrorTitle.isHidden = true
        
        lblErrorDesc.text = errorDesc
        
        self.layoutIfNeeded()
        self.layoutSubviews()
        self.setNeedsLayout()
    }
    
    func removeView() {
        self.removeFromSuperview()
        
    }
    
    override func bindData() {
        super.bindData()
        btnRetry.rx.tap.bind{
            self.removeView()
            self.delegate?.didTapRetry()
        }.disposed(by: disposableBag)
    }
    
}
