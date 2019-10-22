//
//  File.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 08/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
            VStack {
                VStack (alignment: .leading) {
                    TextField("Search for a movie...", text: $viewModel.searchTerm)
                }
                    .padding()
                VStack(alignment: .center) {
                    List{
                        if viewModel.movieDataSource.isEmpty {
                            emptySection
                        } else {
                            moviePresentationSection
                        }
                    }
                }
            }
            .navigationBarTitle("Ranking")
        }
    }
    
    var emptySection: some View {
        Section {
            Text(viewModel.textMessage)
                .foregroundColor(.gray)
        }
    }
    
    var moviePresentationSection: some View {
        Section {
            ForEach(viewModel.movieDataSource) {
                (element: MoviePresentationViewModel) in
                NavigationLink(destination: MovieDetailView(viewModel: element.getNextViewModel())){
                    MoviePresentationView.init(viewModel: element)
                }
            }
            
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        let fetcher = Network()
        let vM = SearchViewModel(fetcher: fetcher)
        return SearchView(viewModel: vM)
        
    }
}
