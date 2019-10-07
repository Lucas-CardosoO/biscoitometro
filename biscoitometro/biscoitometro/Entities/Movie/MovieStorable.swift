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
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var overview: String
    @NSManaged var posterPath: String?
    @NSManaged var backdropPath: String?
}
