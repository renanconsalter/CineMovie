//
//  ListTopRatedMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

protocol ListTopRatedMoviesCoordinatorProtocol: AnyObject {
    func goToMovieDetails(with movie: Movie)
}

final class ListTopRatedMoviesCoordinator: Coordinator {
    
    // MARK: Properties
    
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
    
    // MARK: Methods
    
    private func makeViewController() -> ListTopRatedMoviesViewController {
        let viewModel = ListTopRatedMoviesViewModel()
        viewModel.coordinator = self
        return ListTopRatedMoviesViewController(viewModel: viewModel)
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

// MARK: ListTopRatedMoviesCoordinatorProtocol Methods

extension ListTopRatedMoviesCoordinator: ListTopRatedMoviesCoordinatorProtocol {
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
