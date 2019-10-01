//
//  SearchMovieViewModel.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI
import Combine

class SearchMovieViewModel: ObservableObject, Identifiable {
    @Published var movie: String = ""
    @Published var dataSource: String = ""
    
    private let network: Network
    private var disposables = Set<AnyCancellable>()
    
    init(network: Network, scheduler: DispatchQueue = DispatchQueue(label: "SearchMovieViewModel")) {
        self.network = network
        
        _ = $movie
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchMovie(movie:))
    }
    
    func fetchMovie(movie: String) {
        network.searchMovie(search: movie)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure(.networkProblem):
                    self.dataSource = NetworkError.networkProblem.description
                case .finished:
                    break
                case .failure(.notAuthenticated):
                    self.dataSource = NetworkError.notAuthenticated.description
                case .failure(.notFound):
                    self.dataSource = NetworkError.notFound.description
                case .failure(.badRequest):
                    self.dataSource = NetworkError.badRequest.description
                case .failure(.requestFailed):
                    self.dataSource = NetworkError.requestFailed.description
                case .failure(.invalidData):
                    self.dataSource = NetworkError.invalidData.description
                case .failure(.unknown(_)):
                    self.dataSource = "Unknown Error"
                    }
                }, receiveValue: { [weak self] movieResult in
                    guard let self = self else { return }
                    if (movieResult.results.count > 0) {
                        self.dataSource = movieResult.results[0].title
                        print(self.dataSource)
                    } else {
                        self.dataSource = "Movie Not Found"
                    }
            })
        .store(in: &disposables)
    }
}
