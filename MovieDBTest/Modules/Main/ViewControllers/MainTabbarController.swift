//
//  MainTabbarController.swift
//  MovieDBTest
//
//  Created by Tamron iMac 001 on 7/3/21.
//

import Foundation

import UIKit

class MainTabbarController:  UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUpUI()
    }
    
    func setUpUI() {
        
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .white
        tabBar.barTintColor = #colorLiteral(red: 0.3960784314, green: 0.4392156863, blue: 0.568627451, alpha: 1)
        
        let homeVC = HomeViewController.init(nibName: String(describing: BaseTableViewController.self), bundle: nil)
        let homeWithNav = UINavigationController(rootViewController: homeVC)
        
        let favouriteVC = FavouriteViewController.init()
        let favouriteWithNav = UINavigationController(rootViewController: favouriteVC)

        
        /* Create TabBar items */
        
        let homeItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        let favouriteItem = UITabBarItem(title: "Favourite", image: UIImage(named: "favourite"), tag: 1)
        
        homeWithNav.tabBarItem = homeItem
        favouriteWithNav.tabBarItem = favouriteItem
                  
        let tabBarList = [
            homeWithNav ,
            favouriteWithNav
        ]
        
        /* Adding ViewControllers to TabBarViewController */
        viewControllers = tabBarList
        
        
    }
}
