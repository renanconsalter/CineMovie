//
//  ListPopularMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

final class ListPopularMoviesCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController = .init()
    
    var rootViewController: UIViewController {
        navigationController.tabBarItem = UITabBarItem(
            title: Constants.Menus.popular,
            image: UIImage(systemName: Constants.Icons.film),
            selectedImage: UIImage(systemName: Constants.Icons.filmFill)
        )
        navigationController.navigationBar.prefersLargeTitles = true
        return navigationController
    }
    
    private func makeViewController() -> ListPopularMoviesViewController {
        let viewController = ListPopularMoviesViewController()
        let viewModel = ListPopularMoviesViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.title = Constants.Menus.popular
        
        return viewController
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

extension ListPopularMoviesCoordinator {
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
