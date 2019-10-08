//
//  SearchViewModel.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 08/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI
import Combine

class SearchViewModel: ObservableObject, Identifiable {
    @Published var searchTerm: String = ""
    
}
