//
//  ListTopRatedMoviesViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

final class ListTopRatedMoviesViewController: UIViewController {
    
    // MARK: - ViewModel & TableView
    private let viewModel: ListTopRatedMoviesViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TopRatedMoviesCell.self, forCellReuseIdentifier: String(describing: TopRatedMoviesCell.self))
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Init Methods
    init(viewModel: ListTopRatedMoviesViewModel) {
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
        loadData()
    }

    private func configureViews() {
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
    }
    
    // MARK: - Data Manipulation
    private func loadData() {
        showSpinner()
        viewModel.loadTopRatedMovies()
    }
}

// MARK: - UITableViewDelegate/DataSource Methods
extension ListTopRatedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TopRatedMoviesCell.self), for: indexPath) as? TopRatedMoviesCell else { return UITableViewCell() }
        
        let movie = viewModel.getMovie(at: indexPath)
        let movieCellViewModel = TopRatedMoviesCellViewModel(movie: movie)
        
        cell.configure(viewModel: movieCellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
}

// MARK: - UIScrollViewDelegate Methods
extension ListTopRatedMoviesViewController: UIScrollViewDelegate {
    
    private func createSpinnerAtTableViewFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: view.frame.size.width,
                                              height: 100)
        )
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        
        footerView.addSubview(spinner)
        
        spinner.startAnimating()
        
        return footerView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = self.tableView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let remainingHeightToCallMoreData: CGFloat = 50
        
        if position > (contentHeight - scrollViewHeight - remainingHeightToCallMoreData) {
            self.tableView.tableFooterView = createSpinnerAtTableViewFooter()
            viewModel.loadTopRatedMovies()
        }
    }
}

// MARK: - ListTopRatedMoviesViewModelDelegate Methods
extension ListTopRatedMoviesViewController: ListTopRatedMoviesViewModelDelegate {
    func didSelectMovie(movie: Movie) {
        let detailsVC = MovieDetailsViewController(
            viewModel: MovieDetailsViewModel(movie: movie)
        )
        present(detailsVC, animated: true)
    }
    
    func didFindTopRatedMovies() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.tableFooterView = nil
            self?.hideSpinner()
        }
    }
    
    func didFail(error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            self?.hideSpinner()
            self?.tableView.tableFooterView = nil
            self?.showAlert(message: error.customMessage) { [weak self] _ in
                self?.loadData()
            }
        }
    }
}
