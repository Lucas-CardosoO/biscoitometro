//
//  ArtistStorable.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 07/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import CoreData

class ArtistStorable: NSManagedObject, ArtistProtocol {
    @NSManaged var name: String
    @NSManaged var id: Int
    @NSManaged var profilePath: String?
}
