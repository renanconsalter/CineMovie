//
//  TopRatedMoviesCell.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

final class TopRatedMoviesCell: UITableViewCell {
    
    // MARK: Properties
    
    private let movieImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let starImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: Constants.Icons.starFill)
        imageView.tintColor = UIColor(named: Constants.Colors.starYellow)
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: Initializaton
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configuration/Setup
    
    private func configureViews() {
        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(starImgView)
        contentView.addSubview(ratingLabel)
    }
    
    private func configureConstraints() {
        let heightImageSize: CGFloat = 120
        // A movie poster has 3:2 dimension, so aspect ratio is 1.5
        let aspectRatio: CGFloat = 3 / 2
        let widthImageSize: CGFloat = heightImageSize / aspectRatio
        let padding: CGFloat = 12
        let starRatingSpacing: CGFloat = 3
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            movieImage.widthAnchor.constraint(equalToConstant: widthImageSize),
            movieImage.heightAnchor.constraint(equalToConstant: heightImageSize),
            
            titleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            starImgView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: padding),
            starImgView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImgView.trailingAnchor, constant: starRatingSpacing),
            ratingLabel.centerYAnchor.constraint(equalTo: starImgView.centerYAnchor),
        ])
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        ratingLabel.text = nil
        super.prepareForReuse()
    }
    
    func setup(with viewModel: TopRatedMoviesCellViewModel) {
        movieImage.loadImage(
            from: viewModel.posterImageURL,
            placeholder: UIImage(named: Constants.Images.posterPlaceholder)
        )
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        ratingLabel.text = viewModel.rating
    }
}
