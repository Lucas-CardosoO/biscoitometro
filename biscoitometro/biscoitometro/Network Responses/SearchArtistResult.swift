//
//  SearchArtistResult.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 02/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

struct SearchArtistResult: Decodable, Paginable {

    let results: [Artist]
    var currentPage: Int
    var totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
        case currentPage = "page"
        case totalPages = "total_pages"
    }
    
}
