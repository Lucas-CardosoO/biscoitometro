//
//  Paginable.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

protocol Paginable {
    
    var currentPage: Int { get set }
    var totalPages: Int { get set }
    
}

extension Paginable {
    
    var hasMorePages: Bool {
        return currentPage < totalPages
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1 : currentPage
    }
    
}
