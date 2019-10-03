//
//  Movie.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import CoreData

class Movie: NSManagedObject, Decodable, Encodable {
    
    @NSManaged var id: Int
    @NSManaged var title: String
    @NSManaged var overview: String
    @NSManaged var posterPath: String?
    @NSManaged var backdropPath: String?
    
    static let posterAspectRatio: Double = 1.5
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    required convenience init(from decoder: Decoder) throws {

        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
            fatalError("Failed to decode Movie")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try (container.decodeIfPresent(Int.self, forKey: .id) ?? 12)
        self.title = try (container.decodeIfPresent(String.self, forKey: .title) ?? "Title Error")
        self.overview = try (container.decodeIfPresent(String.self, forKey: .overview) ?? "Overview Error")
        self.posterPath = try (container.decodeIfPresent(String.self, forKey: .posterPath) ?? "Posterpath Error")
        self.backdropPath = try (container.decodeIfPresent(String.self, forKey: .backdropPath) ?? "Backdrop Error")
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(backdropPath, forKey: .backdropPath)
    }
}

// MARK: - Computed Properties

//extension Movie {
//
////    var genreName: String {
////        guard let genre = getGenre() else {
////            return Constants.emptyGenreTitle
////        }
////        return genre.name
////    }
//
//    var posterURL: URL? {
//        guard let posterPath = posterPath else { return nil }
//        return URL(string: URLConfiguration.mediaPath + posterPath)
//    }
//
//    var backdropURL: URL? {
//        guard let backdropPath = backdropPath else { return nil }
//        return URL(string: URLConfiguration.mediaBackdropPath + backdropPath)
//    }
//
//}

// MARK: - Private

//extension Movie {
//
//    private func getGenre() -> Genre? {
//        // If the movie have genres assigned
//        if let genres = genres, let genre = genres.first {
//            return genre
//        }
//        // If the movie only have the genre ids assigned
//        guard let genreIds = genreIds, let genre = genreIds.first else {
//            return nil
//        }
//        return PersistenceManager.shared.findGenre(with: genre)
//    }
//
//}

// MARK: - Constants

//extension Movie {
//    
//    struct Constants {
//        static let emptyGenreTitle = "-"
//    }
//    
//}

// MARK: - Test mockups
//
//extension Movie {
//
//    static func with(id: Int = 1, title: String = "Movie 1",
//                     genres: [Genre] = [], genreIds: [Int] = [],
//                     overview: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
//                     posterPath: String = "/pEFRzXtLmxYNjGd0XqJDHPDFKB2.jpg",
//                     backdropPath: String = "path2", releaseDate: String = "02-21-2019",
//                     voteAverage: Double = 5.0) -> Movie {
//        return Movie(id: id, title: title,
//                     genres: genres, genreIds: genreIds,
//                     overview: overview, posterPath: posterPath,
//                     backdropPath: backdropPath, releaseDate: releaseDate,
//                     voteAverage: voteAverage)
//    }
//    
//}

