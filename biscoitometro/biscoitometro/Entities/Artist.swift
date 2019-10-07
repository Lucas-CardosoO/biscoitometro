//
//  Artist.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//
//
//import Foundation
//import CoreData
//
//class Artist: NSManagedObject, Decodable, Encodable {
//    @NSManaged var name: String
//    @NSManaged var id: Int
//    @NSManaged var profilePath: String?
//    
//    private enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case id = "id"
//        case profilePath = "profile_path"
//    }
//    
//    required convenience init(from decoder: Decoder) throws {
//        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
//            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
//            let entity = NSEntityDescription.entity(forEntityName: "Artist", in: managedObjectContext) else {
//            fatalError("Failed to decode Artist")
//        }
//        
//        self.init(entity: entity, insertInto: managedObjectContext)
//        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try (container.decodeIfPresent(Int.self, forKey: .id) ?? 12)
//        self.name = try (container.decodeIfPresent(String.self, forKey: .name) ?? "Name Error")
//        
//        self.profilePath = try (container.decodeIfPresent(String.self, forKey: .profilePath) ?? "Profile Error")
//    }
//    
//    // MARK: - Encodable
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(profilePath, forKey: .profilePath)
//    }
//}
