//
//  SearchActorCreditsResult.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 02/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

struct SearchActorCreditsResult: Decodable {
    let id:Int
    let cast: [Movie]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
}
