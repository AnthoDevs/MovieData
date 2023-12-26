//
//  MainTabBarItem.swift
//  MovieData
//
//  Created by Anthony Santiago on 10/11/23.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabs()
    }
    
    private func configureTabs() {
        let homeViewController = HomeViewController()
        let findViewController = FindViewController()
        let discoveryViewController = DiscoveryViewController()
        
        // set Tab Images
        homeViewController.tabBarItem.image = UIImage(systemName: "star")
        findViewController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        discoveryViewController.tabBarItem.image = UIImage(systemName: "rectangle.and.text.magnifyingglass")
        
        // Set Titles
        homeViewController.tabBarItem.title = "Top"
        findViewController.tabBarItem.title = "Search"
        discoveryViewController.tabBarItem.title = "Discovery"
        
        let navHome = UINavigationController(rootViewController: homeViewController)
        let navFind = UINavigationController(rootViewController: findViewController)
        let navDiscover = UINavigationController(rootViewController: discoveryViewController)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray6
        setViewControllers( [navFind, navHome, navDiscover], animated: true)
        selectedViewController = navHome
    }
    override func loadView() {
        super.loadView()
        self.tabBar.tintColor = .blue
    }
}
