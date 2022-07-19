//
//  MoviesDetailsCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 18/07/22.
//

import UIKit

final class MovieDetailsCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    private let movie: Movie
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }
    
    private func makeViewController() -> MovieDetailsViewController {
        let viewController = MovieDetailsViewController()
        let viewModel = MovieDetailsViewModel(movie: self.movie)
        viewModel.coordinator = self
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    func start() {
        navigationController.present(self.makeViewController(), animated: true)
    }
}

extension MovieDetailsCoordinator {
    func dismissMovieDetails() {
        parentCoordinator?.childDidFinish(self)
    }
}
