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
}

extension Coordinator {
    func childDidFinish(_ coordinator : Coordinator){
        for (index, child) in childCoordinators.enumerated() {
            if child === coordinator {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
