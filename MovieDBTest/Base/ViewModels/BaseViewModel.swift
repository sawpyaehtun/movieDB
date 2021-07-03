//
//  BaseViewModel.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation
import RxSwift
import RxCocoa


class BaseViewModel {
    let disposableBag = DisposeBag()
        
    var viewController : BaseViewController?
    let errorPublishRelay = PublishRelay<Error>()
    
    let showErrorMessagePublishRelay = BehaviorRelay<String?>(value: nil)
    let loadingPublishRelay = BehaviorRelay<Bool>(value: false)
    let isNoDataPublishRelay = PublishRelay<Void>()
    let isNoInternetPublishRelay = PublishRelay<Void>()
    let isSeverErrorPublishRelay = PublishRelay<Void>()

    var isShowNoDataPageForUnKnownError: Bool = true
        
    init() {
        
    }
    deinit {
        debugPrint("Deinit \(type(of: self))")
    }
    func bindViewModel(in viewController: BaseViewController? = nil) {
        self.viewController = viewController
        
        loadingPublishRelay.bind { (result) in
            if result {
                viewController?.showLoading()
            } else {
                viewController?.hideLoading()
                if let vc = viewController as? BaseTableViewController{
                    vc.hidePullToRefreshAnimationViewPublishRelay.accept(true)
                    vc.hideFooterLoadingViewPublishRealy.accept(true)
                }
            }
        
        }.disposed(by: disposableBag)
        
        errorPublishRelay.bind { (error) in
            viewController?.hideLoading()
            
            if let vc = viewController as? BaseTableViewController{
                vc.hidePullToRefreshAnimationViewPublishRelay.accept(true)
                vc.hideFooterLoadingViewPublishRealy.accept(true)
            }
            
            if let error = error as? ErrorType {
                switch error {
                case .NoInterntError:
                    self.isNoInternetPublishRelay.accept(Void())
                case .KnownError(let message):
                    viewController?.showToast(message: message)
                case .UnKnownError:
                    if self.isShowNoDataPageForUnKnownError {
                        self.isSeverErrorPublishRelay.accept(Void())
                    }else {
                        viewController?.showToast(message: "Something went wrong!")
                    }
                case .TokenExpireError:
                    print("Token expired")
                default:
                    self.isSeverErrorPublishRelay.accept(Void())
                }
            } else {
                self.isSeverErrorPublishRelay.accept(Void())
            }
        }.disposed(by: disposableBag)
        
        showErrorMessagePublishRelay.bind { (errorMessage) in
            if let message = errorMessage {
                viewController?.showToast(message: message, isShowing: {
                    self.viewController?.view.isUserInteractionEnabled = false
                }, completion: {
                    self.viewController?.view.isUserInteractionEnabled = true
                })
            }
        }.disposed(by: disposableBag)
    }
    
    
    func regularErrorHandling(){
                
        isNoDataPublishRelay.bind{
            self.viewController?.isShowNoDataAndInternet(isShow: true)
        }.disposed(by: disposableBag)
        
        isNoInternetPublishRelay.bind{
            self.viewController?.isShowNoDataAndInternet(isShow: true)
        }.disposed(by: disposableBag)
        
        isSeverErrorPublishRelay.bind{
            self.viewController?.isShowNoDataAndInternet(isShow: true, isServerError: true)
        }.disposed(by: disposableBag)
    }
    
}

