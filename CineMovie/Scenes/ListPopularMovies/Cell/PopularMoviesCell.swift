//
//  PopularMoviesCell.swift
//  CineMovie
//
//  Created by Renan Consalter on 28/06/22.
//

import UIKit

final class PopularMoviesCell: UICollectionViewCell {
    
    // MARK: Properties
    
    private let movieImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration/Setup
    
    override func layoutSubviews() {
        configureConstraints()
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
        super.prepareForReuse()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    func setup(with viewModel: PopularMoviesCellViewModel) {
        movieImage.loadImage(
            from: viewModel.posterImageURL,
            placeholder: UIImage(named: Constants.Images.posterPlaceholder)
        )
    }
}
