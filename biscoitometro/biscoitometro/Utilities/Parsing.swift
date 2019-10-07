//
//  Parsing.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import Combine
import CoreData
import UIKit

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, NetworkError> {
    let decoder = JSONDecoder()
//    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    decoder.dateDecodingStrategy = .secondsSince1970
//    
//    if let decoderKey = CodingUserInfoKey.managedObjectContext {
//        decoder.userInfo[decoderKey] = appDelegate?.persistentContainer.viewContext
//    }
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .invalidData
        }
        .eraseToAnyPublisher()
}
