//
//  Requests.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

enum Requests {
    case searchMovie
    case movieCredits(id: Int)
    case searchArtist
    case artistCredits(id: Int)
    case trending
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        case .movieCredits(let id):
            return "/movie/\(id)/credits"
        case .searchArtist:
            return "/search/person"
        case .artistCredits(let id):
            return "/person/\(id)/movie_credits"
        case .trending:
            return "/trending/movie/day"
//        default:
//            return "Request Error"
        }
        
    }
}
