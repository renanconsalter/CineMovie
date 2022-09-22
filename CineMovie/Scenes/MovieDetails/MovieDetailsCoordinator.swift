//
//  MovieDetailsCoordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 18/07/22.
//

import UIKit

protocol MovieDetailsCoordinatorProtocol: AnyObject {
    func dismissMovieDetails()
}

final class MovieDetailsCoordinator: Coordinator {
    // MARK: Properties

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []

    private let movie: Movie
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    // MARK: Methods

    private func makeViewController() -> MovieDetailsViewController {
        let viewModel = MovieDetailsViewModel(movie: self.movie)
        viewModel.coordinator = self
        return MovieDetailsViewController(viewModel: viewModel)
    }

    func start() {
        navigationController.present(self.makeViewController(), animated: true)
    }
}

// MARK: MovieDetailsCoordinatorProtocol Methods

extension MovieDetailsCoordinator: MovieDetailsCoordinatorProtocol {
    func dismissMovieDetails() {
        navigationController.dismiss(animated: true)
        finish()
    }
}
