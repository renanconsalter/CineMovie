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
    private var service = MoviesService.shared
    
    weak var delegate: MovieDetailsViewModelDelegate?
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var id: Int {
        return movie.id
    }
    
    var imageURL: String {
        return movie.backdropURL
    }
    
    var title: String {
        return movie.title
    }
    
    private var primaryGenre: String {
        guard let primaryGenre = movie.genres?.first?.name else { return Constants.notAvailable }
        return primaryGenre
    }
    
    var subtitle: String {
        guard let runtime = movie.runtime, runtime > 0 else { return Constants.notAvailable }
        guard let releaseDate = movie.releaseDate else { return Constants.notAvailable }
        
        let releaseYear = releaseDate.getYearComponentOfStringDate()
        let duration = runtime.convertMinutesToHoursAndMinutes()
        
        return "\(primaryGenre) • \(releaseYear) • \(duration)"
    }
    
    var overview: String {
        return movie.overview
    }
    
    var ratingStars: String {
        let rating = Int(movie.voteAverage)
        let ratingStars = (0 ..< rating).reduce("") { (partialResult, _) -> String in
            return partialResult + "★"
        }
        return ratingStars
    }
    
    var score: String {
        let hasScore = movie.voteAverage > 0.0
        return hasScore ? "\(movie.voteAverage)/10" : ""
    }
    
    func getMovie() {
        service.getMovie(id: movie.id) { result in
            switch result {
            case .success(let movie):
                self.movie = movie
                self.delegate?.didLoadMovieDetails()
            case .failure(let error):
                self.delegate?.didFail(error: error)
            }
        }
    }
}

private extension Int {
    func convertMinutesToHoursAndMinutes() -> String {
        let dateComponentesFormatter = DateComponentsFormatter()
        dateComponentesFormatter.unitsStyle = .full
        dateComponentesFormatter.calendar?.locale = Locale(identifier: "en-US")
        dateComponentesFormatter.allowedUnits = [.hour, .minute]
        
        if self < 0 { return Constants.notAvailable }
        
        guard let hoursAndMinutes = dateComponentesFormatter.string(from: TimeInterval(self) * 60) else {
            return Constants.notAvailable
        }
        
        return hoursAndMinutes
    }
}

private extension String {
    func getYearComponentOfStringDate() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: self)
        let yearOfRelease = Calendar.current.component(.year, from: date ?? Date())
        
        return yearOfRelease
    }
}
