//
//  MovieProtocol.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 04/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

protocol MovieProtocol {
    var id: Int { get }
    var title: String { get }
    var overview: String { get }
    var posterPath: String? { get }
    var backdropPath: String? { get }
}
 
