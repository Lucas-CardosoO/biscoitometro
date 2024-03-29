//
//  Config.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import SwiftUI

var posterWidth:CGFloat = 200
var artistDimension: CGFloat = 150

var defaultMovie: MovieProtocol = MovieDecodable(id: 12, title: "Carregando", overview: "bad request", posterPath: nil, backdropPath: nil, releaseDate: "Nunca")
var artistTest: ArtistProtocol = ArtistDecodable(name: "Albert Brooks", id: 13, profilePath: "/4LG2bFkqOzxzR1kpnoDcwIVuQTG.jpg" )
