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
        VStack(){
            Text("Genre")
            HStack {
                Button(action: self.viewModel.previousMovie, label: {
                Text("<")
                }).padding()
                Spacer()
                MoviePresentationView(viewModel: viewModel.moviePresentationViewModel)
                Spacer()
                Button(action: self.viewModel.nextMovie, label: {
                    Text(">")
                    }).padding()
            }
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
        Section (header: Text("Rate the artist")) {
            Text(viewModel.textMessage)
                .foregroundColor(.gray)
        }
    }
    
    var artistsSection: some View {
        Section (header: Text("Rate the artist")) {
            ForEach(viewModel.castDataSource, content: RateCastView.init(viewModel:))
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRateView(viewModel: <#MovieDetailViewModel#>)
//    }
//}
