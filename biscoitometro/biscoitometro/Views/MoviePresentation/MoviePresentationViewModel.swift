//
//  MoviePresentationViewModel.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 08/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Combine
import SwiftUI

class MoviePresentationViewModel: ObservableObject, Identifiable {
    private var movie: MovieProtocol
    @Published var title: String
    private let network: Network
    @Published var imageSource = UIImage()
    
    init(movie: MovieProtocol, network: Network) {
        self.movie = movie
        self.title = movie.title
        self.network = network
        self.fetchImage(movie: movie)
    }
    
    init(network: Network) {
        self.movie = defaultMovie
        self.title = movie.title
        self.network = network
    }
    
    func setMovie(movie: MovieProtocol) {
        self.movie = movie
        self.title = movie.title
        self.fetchImage(movie: movie)
    }
    
    func fetchImage(movie: MovieProtocol) {
        if let path = movie.posterPath {
            network.getImage(from: path, completion: { (data) in
                self.imageSource = UIImage(data: data) ?? UIImage()
            })
        }
    }
    
    func getNextViewModel() -> MovieDetailViewModel {
        return MovieDetailViewModel(fetcher: self.network, movie: self.movie)
    }
}
