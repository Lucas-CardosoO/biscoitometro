//
//  SearchCreditsResult.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 01/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

struct SearchMovieCreditsResult: Decodable {
    var id: Int
    let cast: [Artist]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
}
