//
//  MovieDetailView.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI

struct MovieRateView: View {
    var viewModel: MovieRateViewModel
    
    var body: some View {
        VStack(alignment: .center){
            Text("Genre")
            MoviePresentationView(viewModel: viewModel.moviePresentationViewModel())
            List {
                Text("Rate the artists")
                if viewModel.castDataSource.isEmpty {
                    emptySection
                } else {
                    artistsSection
                }
            }
        }
    }
    
    var emptySection: some View {
        Section {
            Text("Loading")
                .foregroundColor(.gray)
        }
    }
    
    var artistsSection: some View {
        Section {
            ForEach(viewModel.castDataSource, content: RateCastView.init(viewModel:))
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRateView(viewModel: <#MovieDetailViewModel#>)
//    }
//}
