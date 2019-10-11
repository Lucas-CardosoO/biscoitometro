//
//  SearchViewModel.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 08/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject, Identifiable {
    @Published var searchTerm: String = ""
    @Published var movieDataSource: [MoviePresentationViewModel] = []
    @Published var textMessage = "No Results"
    
    
    private let network: Network
    private var disposables = Set<AnyCancellable>()
    
    init(fetcher: Network, scheduler: DispatchQueue = DispatchQueue(label: "MoviePresentationViewModel")) {
        self.network = fetcher
        _ = $searchTerm
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchMovie(movie:))
    }
    
    func fetchMovie(movie: String) {
        network.searchMovie(search: movie)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: errorHandler(value:),
                receiveValue: { [weak self] movieResult in
                    guard let self = self else { return }
                    
                    var newMovieDataSource: [MoviePresentationViewModel] = []
                    for movie in movieResult.results {
                        newMovieDataSource.append(
                            MoviePresentationViewModel.init(movie: movie, network: self.network)
                        )
                    }
                    
                    self.movieDataSource = newMovieDataSource
            })
        .store(in: &disposables)
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
