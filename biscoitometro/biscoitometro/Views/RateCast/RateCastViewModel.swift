//
//  RateCastViewModel.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class RateCastViewModel: ObservableObject, Identifiable {
    private var artist: ArtistProtocol
    private var network: Network
    @Published var artistName = "Loading Artist Name"
    @Published var artistImage = UIImage()
    
    init(fetcher: Network, artist: ArtistProtocol) {
        self.artist = artist
        self.network = fetcher
        self.artistName = artist.name
        self.fetchImage(artist: artist)
    }
    
    func fetchImage(artist: ArtistProtocol) {
        if let path = artist.profilePath {
            network.getImage(from: path, completion: { (data) in
                self.artistImage = UIImage(data: data) ?? UIImage()
            })
        }
    }
}
