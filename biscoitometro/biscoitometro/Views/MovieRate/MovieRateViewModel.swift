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
    @Published var currMovie: MovieProtocol?
    @Published var castDataSource: [RateCastViewModel] = []

    
    
    init(fetcher: Network, movie: MovieProtocol?) {
        self.network = fetcher
        self.currMovie = movie
        
        if let movie = currMovie {
            
        } else {
            
        }
    }
    
    func moviePresentationViewModel() -> MoviePresentationViewModel{
        if let currMovie = currMovie {
            return MoviePresentationViewModel(movie: currMovie, network: network)
        } else {
            return MoviePresentationViewModel(movie: currMovie!, network: network) // VAI CRASHAAAAAAR ARRUMAR!!!!
        }
    }
    
}
