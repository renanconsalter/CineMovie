//
//  MovieDetailsViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - ViewModel & Views
    private let viewModel: MovieDetailsViewModel!
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(named: Constants.Colors.starYellow)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: Constants.Icons.close), for: .normal)
        button.tintColor = UIColor(named: Constants.Colors.starYellow)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Init Methods
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle/Configuration/Setup Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureButton()
        configureConstraints()
        configureDelegates()
        loadData()
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(imgView)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subtitleLabel)
        scrollView.addSubview(overviewLabel)
        scrollView.addSubview(ratingLabel)
        scrollView.addSubview(scoreLabel)
    }
    
    private func configureButton() {
        closeButton.addTarget(
            self,
            action: #selector(didTapClose),
            for: .touchUpInside
        )
    }
    
    private func configureConstraints() {
        
        let aspectRatio: CGFloat = 16 / 9
        let imageWidth: CGFloat = view.frame.size.width
        let imageHeight: CGFloat = imageWidth / aspectRatio
        let iconSize: CGFloat = 25
        
        let padding: CGFloat = 12
        let labelSize = view.frame.size.width - 20
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imgView.heightAnchor.constraint(equalToConstant: imageHeight),
            imgView.widthAnchor.constraint(equalToConstant: imageWidth),
            imgView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalToConstant: iconSize),
            closeButton.widthAnchor.constraint(equalToConstant: iconSize),
            closeButton.topAnchor.constraint(equalTo: imgView.topAnchor, constant: padding),
            closeButton.trailingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: labelSize),
            titleLabel.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.widthAnchor.constraint(equalToConstant: labelSize),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])

        NSLayoutConstraint.activate([
            overviewLabel.widthAnchor.constraint(equalToConstant: labelSize),
            overviewLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: padding),
            overviewLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: padding),
            ratingLabel.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: padding),
            scoreLabel.topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -padding)
        ])
    }
    
    private func configureDelegates() {
        viewModel.delegate = self
    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation
    private func loadData() {
        showSpinner()
        viewModel.getMovie()
    }
    
    private func updateView() {
        imgView.loadImage(from: viewModel.imageURL)
        overviewLabel.text = viewModel.overview
        ratingLabel.text = viewModel.ratingStars
        scoreLabel.text = viewModel.score
        subtitleLabel.text = viewModel.subtitle
        titleLabel.text = viewModel.title
    }
}

// MARK: - MovieDetailsViewModelDelegate Methods
extension MovieDetailsViewController: MovieDetailsViewModelDelegate {
    func didLoadMovieDetails() {
        DispatchQueue.main.async { [weak self] in
            self?.hideSpinner()
            self?.updateView()
        }
    }
    
    func didFail(error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.hideSpinner()
            self?.showAlert(message: error.customMessage) { [weak self] _ in
                self?.loadData()
            }
        }
    }
}
