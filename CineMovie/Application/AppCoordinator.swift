//
//  AppCordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

final class AppCoordinator: Coordinator {
    // MARK: Properties

    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    private let tabBarController: UITabBarController = {
        let tabBarController = UITabBarController()
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.stackedLayoutAppearance = UITabBarItemAppearance()
        tabBarAppearance.backgroundColor = .systemBackground
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        return tabBarController
    }()

    var rootViewController: UIViewController {
        return tabBarController
    }

    // MARK: Methods

    func start() {
        let listTopRatedMoviesCoordinator = ListTopRatedMoviesCoordinator()
        let listPopularMoviesCoordinator = ListPopularMoviesCoordinator()
        let searchMoviesCoordinator = SearchMoviesCoordinator()

        childCoordinators.append(listTopRatedMoviesCoordinator)
        childCoordinators.append(listPopularMoviesCoordinator)
        childCoordinators.append(searchMoviesCoordinator)

        listTopRatedMoviesCoordinator.parentCoordinator = self
        listPopularMoviesCoordinator.parentCoordinator = self
        searchMoviesCoordinator.parentCoordinator = self

        listTopRatedMoviesCoordinator.start()
        listPopularMoviesCoordinator.start()
        searchMoviesCoordinator.start()

        tabBarController.viewControllers = [
            listTopRatedMoviesCoordinator.rootViewController,
            listPopularMoviesCoordinator.rootViewController,
            searchMoviesCoordinator.rootViewController
        ]
    }
}
