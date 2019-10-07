//
//  ArtistProtocol.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 07/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

protocol ArtistProtocol {
    var name: String { get }
    var id: Int { get }
    var profilePath: String? { get }
}
