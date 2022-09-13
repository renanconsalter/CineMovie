//
//  SearchMoviesCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

protocol SearchMoviesCoordinatorProtocol: AnyObject {
    func goToMovieDetails(with movie: Movie)
}

final class SearchMoviesCoordinator: Coordinator {
    
    // MARK: Properties
    
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController = .init()
    
    var rootViewController: UIViewController {
        navigationController.tabBarItem = UITabBarItem(
            title: Constants.Menus.search,
            image: UIImage(systemName: Constants.Icons.search),
            selectedImage: UIImage(systemName: Constants.Icons.searchTextFill)
        )
        return navigationController
    }
    
    // MARK: Methods
    
    private func makeViewController() -> SearchMoviesViewController {
        let viewModel = SearchMoviesViewModel()
        viewModel.coordinator = self
        return SearchMoviesViewController(viewModel: viewModel)
    }
    
    func start() {
        navigationController.pushViewController(self.makeViewController(), animated: false)
    }
}

// MARK: SearchMoviesCoordinatorProtocol Methods

extension SearchMoviesCoordinator: SearchMoviesCoordinatorProtocol {
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

