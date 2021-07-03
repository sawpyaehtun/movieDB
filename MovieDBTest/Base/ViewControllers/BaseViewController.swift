//
//  BaseViewController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView
import SnapKit

class BaseViewController: UIViewController {
    
    var disposableBag = DisposeBag()
    var errorHandlerView : ErrorHandlerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLanguage()
        setNavigationColor()
        bindViewModel()
        bindData()
        addTapGestures()
        setupTest()
        fetchData()
    }
    
    func fetchData(){
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppScreens.shared.currentVC = self
        checkViewControllerAndShowHideTabBar(vc: self)
        checkViewControllerAndAddBackBtn(vc: self)
        
    }
    
    func removeNavigationBorder(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func checkViewControllerAndShowHideTabBar(vc : UIViewController) {
        let isTop : Bool = isTopViewController(vc: vc)
        isHiddenTabBar(isHidden: !isTop)
    }
    
    func checkViewControllerAndAddBackBtn(vc : UIViewController) {
        if !isTopViewController(vc: vc){
            addBackButton()
        }
    }
    
    func addBackButton() {
        
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_button"), for: .normal)
        
        if is_iPadDevice() {
            backBtn.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        }
        else {
            backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        backBtn.addTarget(self, action: #selector(didTapBackBtn), for: .touchUpInside)
        backBtn.contentMode = .scaleAspectFit
        backBtn.tintColor = UIColor.darkGray
        let backBarBtnItem = UIBarButtonItem(customView: backBtn)
        navigationItem.leftBarButtonItem = backBarBtnItem
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func isTopViewController(vc : UIViewController) -> Bool {
        return navigationController?.children.first == vc
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI(){
        errorHandlerView?.delegate = self
        isHiddenTabBar(isHidden: !self.isTopViewController(vc: self))
    }
    
    func setupLanguage(){
        
    }
    
    func bindViewModel() {
        
    }
    
    func bindData() {
        
    }
    
    func reloadScreen() {
        setupUI()
        setNavigationColor()
        fetchData()
    }
    
    func setupTest(){
        
    }
    
    func setNavigationColor(){
        if let navigationBar = self.navigationController?.navigationBar {
            let navigationLayer = CALayer()
            var bounds = navigationBar.bounds
            bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            navigationLayer.frame = bounds
            navigationLayer.backgroundColor = #colorLiteral(red: 0.01960784314, green: 0.09803921569, blue: 0.3058823529, alpha: 1).cgColor
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return .portrait
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func isHiddenTabBar(isHidden : Bool) {
        self.tabBarController?.tabBar.isHidden = isHidden
    }
    
    func addTapGestures() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(gestureRecognizer:)))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        self.view.addGestureRecognizer(tap)
    }
    
    func removeAllPerviousControllers(controller: AnyClass) {
        navigationController?.viewControllers.removeAll(where: { (vc) -> Bool in
            return !vc.isKind(of: controller) && !vc.isKind(of: controller)
        })
    }
    
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
        willDismissKeyBoard()
    }
    
    func showNoInternetConnectionToast(){
        showToast(message:"No internet connection!")
    }
    
    func showToast(message : String ,
                   bottomConstraint : CGFloat = 0,
                   isShowing : ( () -> Void)? = nil ,
                   completion : ( () -> Void)? = nil) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 300)
        let expectedLabelSize: CGSize = toastLabel.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = toastLabel.frame
        newFrame.size.height = expectedLabelSize.height + 10
        newFrame.size.width = expectedLabelSize.width + 40
        newFrame.origin.y = UIScreen.main.bounds.height - newFrame.size.height - (UIScreen.main.bounds.height / 9) - bottomConstraint
        newFrame.origin.x = UIScreen.main.bounds.width/2 - (newFrame.size.width/2)
        toastLabel.frame = newFrame
        toastLabel.clipsToBounds  =  true
        
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            keyWindow?.addSubview(toastLabel)
        } else {
            let window = UIApplication.shared.keyWindow
            window?.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
            if let showing = isShowing {
                showing()
            }
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            if let completion = completion {
                completion()
            }
        })
        
    }
    
    func willDismissKeyBoard() {
        
    }
    
    func isShowNoDataAndInternet(isShow : Bool , isServerError : Bool = false, errorImage: UIImage? = nil, errorTitle: String? = nil, errorDesc: String? = nil) {
        errorHandlerView?.removeFromSuperview()
        errorHandlerView = ErrorHandlerView(frame: self.view.frame)
        errorHandlerView?.translatesAutoresizingMaskIntoConstraints = false
        errorHandlerView?.delegate = self
        if isShow {
            errorHandlerView?.setupView(isShow: isShow, isServerError: isServerError, errorImage: errorImage, errorTitle: errorTitle, errorDesc: errorDesc)
            self.view.addSubview(errorHandlerView!)
            errorHandlerView?.snp.makeConstraints({ (errorView) in
                errorView.left.equalToSuperview()
                errorView.right.equalToSuperview()
                errorView.centerY.equalToSuperview()
            })
            
        } else {
            errorHandlerView?.removeView()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "FCMToken"), object: nil)
    }
    
    @objc func didTapBackBtn() {
        AppScreens.shared.navigateToBack()
    }
    
}

extension BaseViewController : ErrorHandlerDelegate {
    func didTapRetry() {
        
        ApiClient.checkReachable(success: {
            self.isShowNoDataAndInternet(isShow: false)
            self.reloadScreen()
        }) {
            //not reachable
            self.showNoInternetConnectionToast()
            self.isShowNoDataAndInternet(isShow: true)
        }
        
    }
}

extension BaseViewController {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        touch.view == self.view
    }
}


extension BaseViewController : NVActivityIndicatorViewable, UIGestureRecognizerDelegate {
    func showLoading(message : String = "") {
        startAnimating(CGSize(width: 30, height: 30), message: message, type: .lineSpinFadeLoader)
    }
    
    func hideLoading() {
        stopAnimating()
    }
}
