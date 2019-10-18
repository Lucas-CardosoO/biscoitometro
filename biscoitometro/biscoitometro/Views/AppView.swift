//
//  AppView.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 17/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var movieRateView: MovieRateView
    var searchView: SearchView
    
    
    var body: some View {
        TabView {
            movieRateView.tabItem {
                Image(systemName: "1.circle")
                Text("Rate")
            }
            searchView.tabItem {
                Image(systemName: "2.circle")
                Text("Ranking")
            }
            
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView(movieRateView: MovieRateView(viewModel: MovieRateViewModel(fetcher: Network(), movie: nil)), searchView: SearchView(viewModel: SearchViewModel(fetcher: Network())))
    }
}
