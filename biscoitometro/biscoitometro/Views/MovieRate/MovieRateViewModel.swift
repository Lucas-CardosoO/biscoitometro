//
//  MovieDetailViewModel.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class MovieRateViewModel: ObservableObject, Identifiable {
    private let network: Network
    private var disposables = Set<AnyCancellable>()
    var currMovie: MovieProtocol?
    @Published var moviePresentationViewModel: MoviePresentationViewModel
    @Published var castDataSource: [RateCastViewModel] = []
    @Published var textMessage = "Loading"
    var moviesInPage: [MovieProtocol] = []
    var currMovieIndex = 0
    var currPopularPage = 1
    
    
    init(fetcher: Network, movie: MovieProtocol?) {
        self.network = fetcher
        self.currMovie = movie
        
        if let movie = currMovie {
            self.moviePresentationViewModel = MoviePresentationViewModel(movie: movie, network: fetcher)
            self.fetchCast()
        } else {
            self.moviePresentationViewModel = MoviePresentationViewModel(network: network)
            self.fetchPopular(currPage: currPopularPage)
        }
    }
    
    func fetchPopular(currPage: Int) {
        network.getPopular(page: currPage)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: errorHandler(value:),
                receiveValue: { [weak self] movieResult in
                    guard let self = self else { return }
                    
                    self.moviesInPage = movieResult.results
                    self.currMovie = self.moviesInPage[0]
//                    self.moviePresentationViewModel.setMovie(movie: self.currMovie ?? defaultMovie)
                    self.changeMovie()
                    self.fetchCast()
            })
        .store(in: &disposables)
    }
    
    func fetchCast() {
        if let movie = currMovie {
            network.searchMovieCredits(movie: movie.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: errorHandler(value:),
                      receiveValue: { [weak self] creditsResult in
                        guard let self = self else { return }
                        if (creditsResult.cast.count > 0) {
                            
                            var newRateCastViewModel: [RateCastViewModel] = []
//                            self.castDataSource.removeAll()
                            
                            for artist in creditsResult.cast {
                                print(artist.name)
                                newRateCastViewModel.append(RateCastViewModel(fetcher: self.network, artist: artist))
//                                self.castDataSource.append(RateCastViewModel(fetcher: self.network, artist: artist))
//                                print(self.castDataSource[0].artist.name)
                            }
                            
                            self.castDataSource = newRateCastViewModel
                        } else {
                            self.textMessage = "Cast Not Found"
                        }
                    })
                .store(in: &disposables)
        }
    }
    
//    func moviePresentationViewModel() -> MoviePresentationViewModel{
//        return MoviePresentationViewModel(network: network)
//    }
    
    func errorHandler(value: Subscribers.Completion<NetworkError>) {
        switch value {
            case .failure(.networkProblem):
                self.textMessage = NetworkError.networkProblem.description
            case .finished:
                break
            case .failure(.notAuthenticated):
                self.textMessage = NetworkError.notAuthenticated.description
            case .failure(.notFound):
                self.textMessage = NetworkError.notFound.description
            case .failure(.badRequest):
                self.textMessage = NetworkError.badRequest.description
            case .failure(.requestFailed):
                self.textMessage = NetworkError.requestFailed.description
            case .failure(.invalidData):
                self.textMessage = NetworkError.invalidData.description
            case .failure(.unknown(_)):
                self.textMessage = "Unknown Error"
        }
    }
    
    fileprivate func changeMovie() {
        self.currMovie = moviesInPage[currMovieIndex]
        
        if let movie = currMovie {
            self.moviePresentationViewModel = MoviePresentationViewModel(movie: movie, network: network)
            self.fetchCast()
        }
    }
    
    func nextMovie() {
        if currMovieIndex < moviesInPage.count - 1 {
            self.currMovieIndex += 1
            changeMovie()
        } else {
            currPopularPage += 1
            if currPopularPage > 500 {
                currPopularPage = 0
            }
            fetchPopular(currPage: self.currPopularPage)
            currMovieIndex = 0
        }
    }
    
    func previousMovie() {
        if currMovieIndex > 0 {
            self.currMovieIndex -= 1
            changeMovie()
        } else {
            if currPopularPage > 1 {
                currPopularPage -= 1
                fetchPopular(currPage: self.currPopularPage)
                currMovieIndex = moviesInPage.count - 1
            }
        }
    }
    
}
