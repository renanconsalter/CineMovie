//
//  UIImageView+Extension.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from imageURL: String, placeholder: UIImage? = nil) {
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            image = cachedImage
            return
        }

        guard let url = URL(string: imageURL) else { return }

        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, _, _) in
            let image: UIImage? = {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: imageURL))
                    return downloadedImage
                }
                return placeholder
            }()

            DispatchQueue.main.async { self?.image = image }

        }).resume()
    }
}
