import UIKit

private let imageCache = NSCache<NSString, UIImage>()

public class DownloadImageView: UIImageView {
    private var imageUrl: URL?

    private func getData(from url: URL,
                         completionHandler: @escaping(Data?,
                                                      URLResponse?,
                                                      Error?) -> Void) {
        URLSession
            .shared
            .dataTask(with: url,
                      completionHandler: completionHandler)
            .resume()
    }

    public func downloadImage(from url: URL?, placeHolder: UIImage? = nil) {
        guard let url = url else {
            return
        }

        imageUrl = url
        image = placeHolder

        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            image = cachedImage
            return
        }

        getData(from: url) { [weak self] (data, _, _) in
            guard let self = self else {
                return
            }

            let image: UIImage? = {
                guard let data = data,
                      let downloadedImage = UIImage(data: data) else {
                          return placeHolder
                      }

                imageCache.setObject(downloadedImage,
                                     forKey: NSString(string: url.absoluteString))
                return downloadedImage
            }()

            DispatchQueue.main.async {
                if self.imageUrl == url {
                    self.image = image
                }
            }
        }
    }
}
