//
//  Actor.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

class Actor: Decodable {
    let name: String
    let id: Int
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case profilePath = "profile_path"
    }
}
