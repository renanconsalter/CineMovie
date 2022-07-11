//
//  SearchMoviesViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 04/07/22.
//

import UIKit

final class SearchMoviesViewController: UIViewController {
    
    // MARK: - ViewModel, Views & SearchController
    private let viewModel: SearchMoviesViewModel!
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: Constants.Identifiers.searchMoviesTableViewIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emptyStateImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: Constants.Icons.appLogo)
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = Constants.Search.emptyStateWelcomeText
        return label
    }()
    
    // MARK: - Init Methods
    init(viewModel: SearchMoviesViewModel) {
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
        configureConstraints()
        configureDelegates()
        configureSearchController()
    }

    private func configureViews() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        emptyStateView.addSubview(emptyStateImageView)
        emptyStateView.addSubview(emptyStateLabel)
    }
    
    private func configureConstraints() {
        let imageSize: CGFloat = 200
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyStateView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            emptyStateView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyStateImageView.widthAnchor.constraint(equalToConstant: imageSize),
            emptyStateImageView.heightAnchor.constraint(equalToConstant: imageSize),
            emptyStateImageView.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyStateImageView.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emptyStateLabel.centerXAnchor.constraint(equalTo: emptyStateImageView.centerXAnchor),
            emptyStateLabel.topAnchor.constraint(equalTo: emptyStateImageView.bottomAnchor, constant: padding)
        ])
    }
    
    private func configureDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = Constants.Search.placeholder
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDelegate/DataSource Methods
extension SearchMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.Identifiers.searchMoviesTableViewIdentifier,
            for: indexPath
        )
        
        let movie = viewModel.getMovie(at: indexPath)
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)

    }
}

// MARK: - UISearchResultsUpdating Methods
extension SearchMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputTextByUser = searchController.searchBar.text else { return }
        if !inputTextByUser.isEmpty {
            tableView.tableHeaderView = createSpinner()
        }
        viewModel.searchMovies(with: inputTextByUser)
    }
    
    private func createSpinner() -> UIView {
        let spinnerView = UIView(
            frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100)
        )
        
        let spinner = UIActivityIndicatorView()
        spinner.center = spinnerView.center
        spinner.startAnimating()
        
        spinnerView.addSubview(spinner)
        
        return spinnerView
    }
}

// MARK: - SearchMoviesViewModelDelegate Methods
extension SearchMoviesViewController: SearchMoviesViewModelDelegate {
    func didSelectMovie(movie: Movie) {
        let detailsVC = MovieDetailsViewController(
            viewModel: MovieDetailsViewModel(movie: movie)
        )
        present(detailsVC, animated: true)
    }
    
    func showNoResultsState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableHeaderView = nil
            self?.emptyStateLabel.text = Constants.Search.emptyStateNoResultsText
            self?.emptyStateView.isHidden = false
            self?.emptyStateImageView.image = UIImage(named: Constants.Search.noResultsImage)
        }
    }
    
    func showEmptyState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.emptyStateLabel.text = Constants.Search.emptyStateWelcomeText
            self?.emptyStateView.isHidden = false
            self?.emptyStateImageView.image = UIImage(named: Constants.Icons.appLogo)
        }
    }
    
    func didFindMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableHeaderView = nil
            self?.emptyStateView.isHidden = true
        }
    }
    
    func didFail(error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.tableHeaderView = nil
            self?.showAlert(message: error.customMessage)
        }
    }
}
