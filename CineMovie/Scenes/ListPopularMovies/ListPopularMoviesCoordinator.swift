//
//  ListPopularMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

protocol ListPopularMoviesCoordinatorProtocol: AnyObject {
    func goToMovieDetails(with movie: Movie)
}

final class ListPopularMoviesCoordinator: Coordinator {
    
    // MARK: Properties
    
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
    
    // MARK: Methods
    
    private func makeViewController() -> ListPopularMoviesViewController {
        let viewModel = ListPopularMoviesViewModel()
        viewModel.coordinator = self
        return ListPopularMoviesViewController(viewModel: viewModel)
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

// MARK: ListPopularMoviesCoordinatorProtocol Methods

extension ListPopularMoviesCoordinator: ListPopularMoviesCoordinatorProtocol {
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
