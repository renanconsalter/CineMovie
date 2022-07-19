//
//  PopularMoviesCell.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

final class PopularMoviesCell: UICollectionViewCell {
    
    // MARK: - View
    private let movieImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration/Setup Methods
    override func layoutSubviews() {
        movieImage.frame = contentView.frame
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
        super.prepareForReuse()
    }

    func configure(viewModel: PopularMoviesCellViewModel) {
        movieImage.loadImage(from: viewModel.imageURL)
    }
}
