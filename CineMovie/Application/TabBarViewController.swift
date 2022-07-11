//
//  TabBarViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let topRatedMoviesViewModel = ListTopRatedMoviesViewModel()
        let popularMoviesViewModel = ListPopularMoviesViewModel()
        
        let topRatedVC = createNavigationController(
            for: ListTopRatedMoviesViewController(viewModel: topRatedMoviesViewModel),
            title: Constants.Menus.topRated,
            image: UIImage(systemName: Constants.Icons.star)
        )
        
        let popularMoviesVC = createNavigationController(
            for: ListPopularMoviesViewController(viewModel: popularMoviesViewModel),
            title: Constants.Menus.popular,
            image: UIImage(systemName: Constants.Icons.film)
        )
        
        viewControllers = [topRatedVC, popularMoviesVC]
    }
    
    private func createNavigationController(for rootViewController: UIViewController,
                                            title: String,
                                            image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationItem.largeTitleDisplayMode = .always
        
        rootViewController.navigationItem.title = title
        
        return navController
      }
    
    private func setupTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = .systemBackground

        tabBar.standardAppearance = tabBarAppearance
        
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = tabBarAppearance
        }
    }
}
