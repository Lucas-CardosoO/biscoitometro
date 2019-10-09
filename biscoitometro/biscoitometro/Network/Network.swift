//
//  Network.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 26/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import Combine

class Network {
    // MARK: - Constants
    
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    struct MovieDBAPI {
      static let scheme = "https"
      static let host = "api.themoviedb.org"
      static let path = "/3"
      static let key = "98f42e76c26e0d5d7794fdb0b2d72a8a"
    }
    
    // MARK: - API Components Request
    
    private func makeSearchMoviesComponents (searchTerm: String) -> URLComponents{
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.searchMovie.path
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBAPI.key),
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        
        return components
    }
    
    private func makeMovieCreditsComponents (movie id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.movieCredits(id: id).path
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBAPI.key)
        ]
        return components
    }
    
    private func makeSearchArtistComponents (searchTerm: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.searchArtist.path
        
        components.queryItems = [
            URLQueryItem(name: "query", value: searchTerm),
            URLQueryItem(name: "api_key", value: MovieDBAPI.key),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        return components
    }
    
    private func makeSearchArtistCreditsComponents (artist id: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = MovieDBAPI.host
        components.path = MovieDBAPI.path + Requests.artistCredits(id: id).path
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: MovieDBAPI.key)
        ]
        return components
    }
    
    private func makeImageComponents (path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieDBAPI.scheme
        components.host = "image.tmdb.org"
        components.path = "/t/p/original" + path
        
        return components
    }
    
    // MARK: - Search Request Functions
    
    func searchMovieCredits(movie id: Int) -> AnyPublisher<SearchMovieCreditsResult,NetworkError> {
        return makeRequest(with: makeMovieCreditsComponents(movie: id))
    }
    
    func searchMovie(
      search movie: String
    ) -> AnyPublisher<SearchMovieResult, NetworkError> {
        return makeRequest(with: makeSearchMoviesComponents(searchTerm: movie))
    }
    
    func searchArtist (search artist: String) -> AnyPublisher<SearchArtistResult, NetworkError>{
        return makeRequest(with: makeSearchArtistComponents(searchTerm: artist))
    }
    
    func searchArtistCredits(artist id: Int) -> AnyPublisher<SearchArtistCreditsResult, NetworkError> {
        return makeRequest(with: makeSearchArtistCreditsComponents(artist: id))
    }
    
    func getPoster(from movie: MovieProtocol, completion: @escaping (Data) -> () ) {
        getImage(from: movie.posterPath ?? "/rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg") { data, response, error in
            guard let data = data, error == nil else { return }
            print("Download Finished")
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
    
    
    // MARK: - Make Request
    
    private func makeRequest <T> (with components: URLComponents) -> AnyPublisher<T, NetworkError> where T: Decodable  {
        guard let url = components.url else {
            let error = NetworkError.requestFailed
            return Fail(error: error).eraseToAnyPublisher()
          }

          return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .networkProblem
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
    private func getImage(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: URLRequest(url: makeImageComponents(path: url).url ?? URL(fileURLWithPath: "https://image.tmdb.org/t/p/original//rzRwTcFvttcN1ZpX2xv4j3tSdJu.jpg")), completionHandler: completion).resume()
    }
    
}
