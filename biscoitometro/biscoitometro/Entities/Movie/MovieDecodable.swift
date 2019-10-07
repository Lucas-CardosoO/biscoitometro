//
//  MovieDecodable.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import CoreData

import Foundation

struct MovieDecodable: MovieProtocol, Decodable {
    
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    
    static let posterAspectRatio: Double = 1.5
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
    }

}
