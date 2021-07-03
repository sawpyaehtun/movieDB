//
//  BaseTableViewController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import UIKit
import RxCocoa
import RxSwift
import CRRefresh

class BaseTableViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
        
    let showPullToRefreshAnimationViewPublishRelay = PublishRelay<Bool>()
    let hidePullToRefreshAnimationViewPublishRelay = PublishRelay<Bool>()
    let showFooterLoadingViewPublishRealy = PublishRelay<Bool>()
    let hideFooterLoadingViewPublishRealy = PublishRelay<Bool>()
    let isNoMoreDataPublishRelay = PublishRelay<Bool>()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func bindData() {
        super.bindData()
        
        hidePullToRefreshAnimationViewPublishRelay.bind{
            if $0 {
                self.tableView.cr.endHeaderRefresh()
            }
        }.disposed(by: disposableBag)
        
        hideFooterLoadingViewPublishRealy.bind{
            if $0 {
                self.tableView.cr.endLoadingMore()
            }
        }.disposed(by: disposableBag)
        
        isNoMoreDataPublishRelay.bind {
                self.tableView.cr.footer?.isHidden = $0
        }.disposed(by: disposableBag)
    }
    
    override func setupUI() {
        super.setupUI()
        self.removeNavigationBorder()
        setupTableView()
       
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    func setupHeaderFooterLoadingAnimation(){
        setupHeaderLoadingAnimation()
        setupFooterLoadingAnimation()
    }
    
    func setupHeaderLoadingAnimation(){
        tableView.cr.addHeadRefresh(animator: NormalHeaderAnimator()) { [weak self] in
            self?.showPullToRefreshAnimationViewPublishRelay.accept(true)
        }
    }
    
    func setupFooterLoadingAnimation(){
        tableView.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
            self?.showFooterLoadingViewPublishRealy.accept(true)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get{
            return .portrait
        }
    }
    
}

//MARK:- Loading Indicator
extension BaseTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

