//
//  TopRatedMoviesCell.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

final class TopRatedMoviesCell: UITableViewCell {
    
    // MARK: - Views
    private let movieImage: DownloadImageView = {
        let imageView = DownloadImageView()
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
        imageView.image = UIImage(systemName: Constants.Icons.star)
        imageView.tintColor = UIColor(named: Constants.Colors.starYellow)
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    // MARK: - Init Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        ratingLabel.text = nil
        super.prepareForReuse()
    }
    
    // MARK: - Configuration/Setup Methods
    private func configureViews() {
        contentView.addSubview(movieImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(starImgView)
        contentView.addSubview(ratingLabel)
    }
    
    private func configureConstraints() {
        let imageSize: CGFloat = 120
        let padding: CGFloat = 12
        let labelSize: CGFloat = contentView.frame.size.width - (imageSize / 2) - 10
        
        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: imageSize),
            movieImage.widthAnchor.constraint(equalToConstant: imageSize),
            movieImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.widthAnchor.constraint(equalToConstant: labelSize),
            titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: movieImage.topAnchor),
            
            subtitleLabel.widthAnchor.constraint(equalToConstant: labelSize),
            subtitleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            
            starImgView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            starImgView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: padding),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImgView.trailingAnchor, constant: 3),
            ratingLabel.centerYAnchor.constraint(equalTo: starImgView.centerYAnchor)
        ])
    }
    
    func configure(viewModel: TopRatedMoviesCellViewModel) {
        movieImage.loadImage(from: URL(string: viewModel.imageURL))
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        ratingLabel.text = viewModel.rating
    }
}
