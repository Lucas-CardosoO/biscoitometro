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
                case .failure:
                    self.dataSource = "Error"
                case .finished:
                    break
                }
                }, receiveValue: { [weak self] movieResult in
                    guard let self = self else { return }
                    self.dataSource = movieResult.title
            })
        .store(in: &disposables)
    }
}
