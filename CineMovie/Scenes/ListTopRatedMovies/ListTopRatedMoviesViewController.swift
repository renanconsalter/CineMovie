//
//  ListTopRatedMoviesViewController.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import UIKit

final class ListTopRatedMoviesViewController: UIViewController {
    
    // MARK: Properties
    
    private let viewModel: ListTopRatedMoviesViewModel
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            TopRatedMoviesCell.self,
            forCellReuseIdentifier: String(describing: TopRatedMoviesCell.self)
        )
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 144
        return tableView
    }()
    
    // MARK: Initialization
    
    init(viewModel: ListTopRatedMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        configureDelegates()
        configureTitle()
        loadData()
    }
    
    // MARK: Configuration/Setup
    
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
    
    private func configureTitle() {
        viewModel.setNavigationTitle()
    }
    
    // MARK: Data Manipulation Methods
    
    private func loadData() {
        viewModel.loadTopRatedMovies()
    }
}

// MARK: UITableViewDelegate/DataSource Methods

extension ListTopRatedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TopRatedMoviesCell.self),
            for: indexPath
        ) as? TopRatedMoviesCell
        else { return UITableViewCell() }
        
        let movie = viewModel.getMovie(at: indexPath)
        let movieCellViewModel = TopRatedMoviesCellViewModel(movie: movie)
        
        cell.selectionStyle = .none
        cell.setup(with: movieCellViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSection = tableView.numberOfSections - 1
        let lastRow = tableView.numberOfRows(inSection: lastSection) - 1
        if indexPath.section == lastSection && indexPath.row == lastRow {
            viewModel.userRequestMoreData()
        }
    }
}

// MARK: ListTopRatedMoviesViewModelDelegate Methods

extension ListTopRatedMoviesViewController: ListTopRatedMoviesViewModelDelegate, Loadable, Alertable {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showSpinner(on: self.view)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.removeSpinner(on: self.view)
            self.tableView.tableFooterView = nil
        }
    }
    
    func showPaginationLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.tableFooterView = self.createFooterSpinner(on: self.tableView)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func didFail(with error: ErrorHandler) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showActionAlert(
                message: error.customMessage,
                action: self.loadData
            )
        }
    }
    
    func setNavigationTitle(to value: String) {
        DispatchQueue.main.async { [weak self] in
            self?.title = value
        }
    }
}

// MARK: TableViewFooter Private Extension Methods

private extension ListTopRatedMoviesViewController {
    private func createFooterSpinner(on tableView: UITableView) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 100)
        return spinner
    }
}
