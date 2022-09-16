//
//  Coordinator.swift
//  CineMovie
//
//  Created by Renan Consalter on 15/07/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
