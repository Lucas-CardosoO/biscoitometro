//
//  Requests.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation

enum Requests {
    case getUpcoming(page: Int)
    case getPopular(page: Int)
    case getTopRated(page: Int)
    case getByGenreId(page: Int, genreId: Int)
    case search
    case getDetail(id: Int)
    case getVideos(id: Int)
    case getReviews(page: Int, id: Int)
    case getSimilars(page:Int, id: Int)
    case getCredits(id: Int)
    case getAccountState(id: Int, sessionId: String)
    
    var path: String {
        switch self {
        case .search:
            return "/search/movie"
        default:
            return "Request Error"
        }
        
    }
    
    
//    case getUpcoming(page: Int)
//    case getPopular(page: Int)
//    case getTopRated(page: Int)
//    case getByGenreId(page: Int, genreId: Int)
//    case search(searchText: String)
//    case getDetail(id: Int)
//    case getVideos(id: Int)
//    case getReviews(page: Int, id: Int)
//    case getSimilars(page:Int, id: Int)
//    case getCredits(id: Int)
//    case getAccountState(id: Int, sessionId: String)
//
//    var path: String {
//        switch self {
//        case .getUpcoming:
//            return "/movie/upcoming"
//        case .getPopular:
//            return "/movie/popular"
//        case .getTopRated:
//            return "/movie/top_rated"
//        case .getByGenreId:
//            return "/discover/movie"
//        case .search:
//            return "/search/movie"
//        case .getDetail(let id):
//            return "/movie/\(id)"
//        case .getVideos(let id):
//            return "/movie/\(id)/videos"
//        case .getReviews(_, let id):
//            return "/movie/\(id)/reviews"
//        case .getSimilars(_, let id):
//            return "/movie/\(id)/similar"
//        case .getCredits(let id):
//            return "/movie/\(id)/credits"
//        case .getAccountState(let id, _):
//            return "/movie/\(id)/account_states"
//        }
//    }
}
