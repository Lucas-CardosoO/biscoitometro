//
//  MovieStorable.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 07/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import CoreData

class MovieStorable: NSManagedObject, MovieProtocol {
    var id: Int = 12
    var title: String = "Error ao criar Storable"
    var overview: String = "Error ao criar Storable"
    var posterPath: String?
    var backdropPath: String?

}
