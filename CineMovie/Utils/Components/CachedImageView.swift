//
//  CachedImageView.swift
//  CineMovie
//
//  Created by Renan Consalter on 19/07/22.
//

import UIKit

private let imageCache = NSCache<NSString, UIImage>()

final class CachedImageView: UIImageView {
    private var imageURL: URL?
    private func getData(from url: URL, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completionHandler).resume()
    }

    func loadImage(from stringURL: String, placeholder: UIImage? = nil) {
        guard let url = URL(string: stringURL) else { return }

        imageURL = url
        image = placeholder

        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            image = cachedImage
            return
        }

        getData(from: url) { [weak self] data, _, _ in
            guard let self = self else { return }

            let image: UIImage? = {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    imageCache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
                    return downloadedImage
                }
                return placeholder
            }()

            DispatchQueue.main.async {
                if self.imageURL == url {
                    self.image = image
                }
            }
        }
    }
}
