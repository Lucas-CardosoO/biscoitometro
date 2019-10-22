//
//  MovieDetailViewModel.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 17/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject, Identifiable {
    private let network: Network
    private var disposables = Set<AnyCancellable>()
    var currMovie: MovieProtocol?
    @Published var moviePresentationViewModel: MoviePresentationViewModel
    @Published var castDataSource: [RateCastViewModel] = []
    @Published var textMessage = "Loading"
    
    init(fetcher: Network, movie: MovieProtocol?) {
        
        self.network = fetcher
        self.currMovie = movie
        if let movie = currMovie {
            self.moviePresentationViewModel = MoviePresentationViewModel(movie: movie, network: fetcher)
            self.fetchCast()
        } else {
            self.moviePresentationViewModel = MoviePresentationViewModel(network: network)
        }
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
                            
                            for artist in creditsResult.cast {
                                print(artist.name)
                                newRateCastViewModel.append(RateCastViewModel(fetcher: self.network, artist: artist))
                            }
                            
                            self.castDataSource = newRateCastViewModel
                        } else {
                            self.textMessage = "Cast Not Found"
                        }
                    })
                .store(in: &disposables)
        }
    }
    
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
}
