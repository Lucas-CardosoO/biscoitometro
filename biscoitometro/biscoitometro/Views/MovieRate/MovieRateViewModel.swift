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
    @Published var castDataSource: [ArtistProtocol] = [] //trocar para o artistpresentation que ainda n foi criado hehe

    
    
    init(fetcher: Network) {
        self.network = fetcher
    }
    
    func moviePresentationViewModel() -> MoviePresentationViewModel {
        return MoviePresentationViewModel(movie: currMovie!, network: network) // ATENCAAAAAAO Tirar !!!!!!
    }
    
}
