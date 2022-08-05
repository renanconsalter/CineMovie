//
//  SearchMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

final class SearchMoviesCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController = .init()
    
    var rootViewController: UIViewController {
        navigationController.tabBarItem = UITabBarItem(
            title: Constants.Menus.search,
            image: UIImage(systemName: Constants.Icons.search),
            selectedImage: UIImage(systemName: Constants.Icons.search)
        )
        return navigationController
    }
    
    private func makeViewController() -> SearchMoviesViewController {
        let viewController = SearchMoviesViewController()
        let viewModel = SearchMoviesViewModel()
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        viewController.title = Constants.Menus.search
        
        return viewController
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

extension SearchMoviesCoordinator: MovieDetailsCoordinatorProtocol {
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

