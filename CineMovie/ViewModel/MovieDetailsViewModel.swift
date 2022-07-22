//
//  MovieDetailsViewModel.swift
//  CineMovie
//
//  Created by Renan Consalter on 30/06/22.
//

import Foundation

protocol MovieDetailsViewModelDelegate: AnyObject {
    func didLoadMovieDetails()
    func didFail(error: ErrorHandler)
}

final class MovieDetailsViewModel {
    
    private var movie: Movie
    private var service: MoviesServiceProtocol
    
    weak var delegate: MovieDetailsViewModelDelegate?
    weak var coordinator: MovieDetailsCoordinator?
    
    init(
        service: MoviesServiceProtocol = MoviesService.shared,
        movie: Movie
    ) {
        self.service = service
        self.movie = movie
    }
    
    var id: Int {
        return movie.id
    }
    
    var backdropImageURL: String {
        guard let posterPath = movie.backdropPath else {
            return Constants.ApiImageURL.backdropPlaceholder
        }
        return Constants.ApiImageURL.highQuality + posterPath
    }
    
    var title: String {
        return movie.title
    }
    
    var primaryGenre: String {
        guard let primaryGenre = movie.genres?.first?.name else {
            return Constants.notAvailable
        }
        return primaryGenre
    }
    
    var subtitle: String {
        guard
            let runtime = movie.runtime, runtime > 0,
            let duration = convertMinutesToHoursAndMinutes(runtime: runtime),
            let releaseDate = movie.releaseDate,
            let releaseYear = getYearComponentOfDate(date: releaseDate)
        else {
            return Constants.notAvailable
        }

        return "\(primaryGenre) • \(releaseYear) • \(duration)"
    }
    
    var overview: String {
        return movie.overview
    }
    
    var ratingStars: String {
        let truncatedRating = Int(movie.voteAverage)
        let ratingStars = (0 ..< truncatedRating).reduce("") { (partialResult, _) -> String in
            return partialResult + "★"
        }
        return ratingStars
    }
    
    var score: String {
        let hasScore = movie.voteAverage > 0
        let truncatedScore = String(format: "%.1f", movie.voteAverage)
        
        return hasScore ? "\(truncatedScore)/10" : Constants.notAvailable
    }
    
    func getMovie() {
        service.getMovie(id: movie.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                self.movie = movie
                self.delegate?.didLoadMovieDetails()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
    
    func didFinishShowDetails() {
        coordinator?.dismissMovieDetails()
    }
}

extension MovieDetailsViewModel {
    func convertMinutesToHoursAndMinutes(runtime: Int) -> String? {
        let dateComponentesFormatter = DateComponentsFormatter()
        dateComponentesFormatter.unitsStyle = .full
        dateComponentesFormatter.calendar?.locale = Locale(identifier: "en-US")
        dateComponentesFormatter.allowedUnits = [.hour, .minute]
        
        let hoursAndMinutes = dateComponentesFormatter.string(
            from: TimeInterval(runtime) * 60
        )
        
        return hoursAndMinutes
    }
    
    func getYearComponentOfDate(date: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: date) else {
            return nil
        }
        formatter.dateFormat = "yyyy"
        let yearOfRelease = formatter.string(from: date)
        
        return yearOfRelease
    }
}
