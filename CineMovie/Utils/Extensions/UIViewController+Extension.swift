//
//  UIViewController+Extension.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

extension UIViewController {
    
    func showSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let activityIndicator = UIActivityIndicatorView(frame: self.view.bounds)
            activityIndicator.style = .large
            activityIndicator.hidesWhenStopped = true
            
            self.view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            for view in self.view.subviews {
                if let activityIndicator = view as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                    break
                }
            }
        }
    }
    
    func showAlert(title: String? = Constants.Alerts.defaultTitle,
                   message: String,
                   tryAgainHandler: ((UIAlertAction)-> Void)? = nil)
    {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: Constants.Alerts.defaultButtonTitle,
                                         style: .default,
                                         handler: nil)
            alert.addAction(okAction)
            
            if let tryAgainHandler = tryAgainHandler {
                let tryAgainAction = UIAlertAction(title: Constants.Alerts.tryAgainButtonTitle,
                                                   style: .default,
                                                   handler: tryAgainHandler)
                alert.addAction(tryAgainAction)
            }
            
            self?.present(alert, animated: true)
        }
    }
}
