//
//  MovieDetailView.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 17/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel
    
    var body: some View {
        VStack(){
            MoviePresentationView(viewModel: viewModel.moviePresentationViewModel).scaleEffect(4/5).frame(width: 200, height: 250, alignment: .center)
//            Text("Rate the artists")
            List {
                if viewModel.castDataSource.isEmpty {
                    emptySection
                } else {
                    artistsSection
                }
            }
        }
    .navigationBarHidden(true)
    }
    
    var emptySection: some View {
        Section (header: Text("Rate the artist")) {
            Text(viewModel.textMessage)
                .foregroundColor(.gray)
        }
    }
    
    var artistsSection: some View {
        Section(header: Text("Rate the artist")) {
            ForEach(viewModel.castDataSource, content: RateCastView.init(viewModel:))
        }
    }
}


struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(fetcher: Network(), movie: defaultMovie))
    }
}
