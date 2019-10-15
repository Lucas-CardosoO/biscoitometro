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
    let movie: MovieProtocol
    let title: String
    let network: Network
    @Published var imageSource = UIImage()
    
    init(movie: MovieProtocol, network: Network) {
        self.movie = movie
        self.title = movie.title
        self.network = network
        
        self.fetchImage(movie: movie)
    }
    
    func fetchImage(movie: MovieProtocol) {
        if let _ = movie.posterPath {
            network.getPoster(from: movie, completion: { (data) in
                self.imageSource = UIImage(data: data) ?? UIImage()
            })
        }
    }
    
    func getNextViewModel() -> MovieRateViewModel {
        return MovieRateViewModel(fetcher: network)
    }
}
