//
//  Loadable.swift
//  CineMovie
//
//  Created by Renan Consalter on 10/08/22.
//

import UIKit

protocol Loadable: UIViewController {
    func showSpinner(on view: UIView, size: UIActivityIndicatorView.Style)
    func removeSpinner(on view: UIView)
}

extension Loadable {
    func removeSpinner(on view: UIView) {
        let spinner = view.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
        spinner?.stopAnimating()
    }

    func showSpinner(on view: UIView, size: UIActivityIndicatorView.Style = .large) {
        if let spinner = view.subviews.compactMap({ $0 as? UIActivityIndicatorView }).first {
            spinner.startAnimating()
        } else {
            addSpinner(in: view, size: size)
        }
    }

    private func addSpinner(in view: UIView, size: UIActivityIndicatorView.Style) {
        let loadingView: UIActivityIndicatorView = {
            let activityIndicator = UIActivityIndicatorView()
            activityIndicator.style = size
            activityIndicator.isOpaque = true
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            return activityIndicator
        }()

        view.addSubview(loadingView)

        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        loadingView.startAnimating()
    }
}
