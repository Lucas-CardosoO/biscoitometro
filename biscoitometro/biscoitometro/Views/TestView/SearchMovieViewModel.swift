//
//  SearchMovieViewModel.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 30/09/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI
import Combine

class SearchMovieViewModel: ObservableObject, Identifiable {
    @Published var searchMovieText: String = ""
    @Published var dataSource: String = ""
    @Published var imageSource: UIImage = UIImage()
    
    private var currMovie: MovieDecodable?
    private var currCast: [ArtistDecodable]?
    private let network: Network
    private var disposables = Set<AnyCancellable>()
    
    init(network: Network, scheduler: DispatchQueue = DispatchQueue(label: "SearchMovieViewModel")) {
        self.network = network
        
        _ = $searchMovieText
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: fetchMovie(movie:))
    }
    
    func fetchMovie(movie: String) {
        network.searchMovie(search: movie)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: errorHandler(value:),
                receiveValue: { [weak self] movieResult in
                    guard let self = self else { return }
                    if (movieResult.results.count > 0) {
                        self.currMovie = movieResult.results[0]
                        self.dataSource = self.currMovie?.title ?? "Not a movie"
                        if let currMovie = self.currMovie {
                            self.fetchImage(movie: currMovie)
                        } else {
                            print("error - not a movie")
                        }
                        print(self.dataSource)
                    } else {
                        self.dataSource = "Movie Not Found"
                    }
            })
        .store(in: &disposables)
    }
    
    func fetchCast(movie: String) {
        self.fetchMovie(movie: movie)
        if let movie = currMovie {
            network.searchMovieCredits(movie: movie.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: errorHandler(value:),
                      receiveValue: { [weak self] creditsResult in
                        guard let self = self else { return }
                        if (creditsResult.cast.count > 0) {
                            self.currCast = creditsResult.cast
                            self.dataSource = self.currCast?[0].name ?? "Not a cast"
                            print(self.dataSource)
                        } else {
                            self.dataSource = "Cast Not Found"
                        }
                    })
                .store(in: &disposables)
        }
    }
    
    func fetchArtist(artist: String){
        network.searchArtist(search: artist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: errorHandler(value:),
                  receiveValue: { [weak self] artistResult in
                    guard let self = self else { return }
                    if (artistResult.results.count > 0) {
                        self.currCast = artistResult.results
//                        self.dataSource = self.currCast?[0].name ?? "Not a cast"
                    } else {
                        self.dataSource = "Artist not found"
                    }
                    })
            .store(in: &disposables)
        }
    
    func fetchArtistCredits(artist: String)  {
        fetchArtist(artist: artist)
        if let artist = currCast?[0] {
            network.searchArtistCredits(artist: artist.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: errorHandler(value:),
                    receiveValue: { [weak self] artistCreditsResult in
                    guard let self = self else { return }
                    if (artistCreditsResult.cast.count > 0) {
                        self.currMovie = artistCreditsResult.cast[0]
//                         print(self.currMovie)
                        self.dataSource = self.currMovie?.title ?? "Not a movie"
                    } else {
                        self.dataSource = "Artist not found"
                }
                })
                .store(in: &disposables)
        }
    }
    
    func fetchImage(movie: MovieProtocol) {
        network.getImage(from: movie.posterPath!, completion: { (data) in
            self.imageSource = UIImage(data: data) ?? UIImage()
        })
    }
    
    func errorHandler(value: Subscribers.Completion<NetworkError>) {
        switch value {
            case .failure(.networkProblem):
                self.dataSource = NetworkError.networkProblem.description
            case .finished:
                break
            case .failure(.notAuthenticated):
                self.dataSource = NetworkError.notAuthenticated.description
            case .failure(.notFound):
                self.dataSource = NetworkError.notFound.description
            case .failure(.badRequest):
                self.dataSource = NetworkError.badRequest.description
            case .failure(.requestFailed):
                self.dataSource = NetworkError.requestFailed.description
            case .failure(.invalidData):
                self.dataSource = NetworkError.invalidData.description
            case .failure(.unknown(_)):
                self.dataSource = "Unknown Error"
            }
    }
}
