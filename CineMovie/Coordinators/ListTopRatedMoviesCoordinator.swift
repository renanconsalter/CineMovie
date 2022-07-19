//
//  ListTopRatedMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

final class ListTopRatedMoviesCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController = .init()
    
    var rootViewController: UIViewController {
        navigationController.tabBarItem = UITabBarItem(
            title: Constants.Menus.topRated,
            image: UIImage(systemName: Constants.Icons.star),
            selectedImage: UIImage(systemName: Constants.Icons.starFill)
        )
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func makeViewController() -> ListTopRatedMoviesViewController {
        let viewController = ListTopRatedMoviesViewController()
        let viewModel = ListTopRatedMoviesViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.title = Constants.Menus.topRated
        
        return viewController
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

extension ListTopRatedMoviesCoordinator {
    func goToMovieDetails(with movie: Movie) {
        let movieDetailsCoordinator = MovieDetailsCoordinator(
            navigationController: navigationController,
            movie: movie
        )
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.parentCoordinator = self
        movieDetailsCoordinator.start()
    }
}
