//
//  MovieDetailView.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI

struct MovieRateView: View {
    @ObservedObject var viewModel: MovieRateViewModel
    
    var body: some View {
        VStack(alignment: .center){
            Text("Genre")
            MoviePresentationView(viewModel: viewModel.moviePresentationViewModel)
            Text("Rate the artists")
            List {
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
            Text(viewModel.textMessage)
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
