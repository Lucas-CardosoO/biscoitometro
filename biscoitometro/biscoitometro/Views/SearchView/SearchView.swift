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
        VStack {
            VStack (alignment: .leading) {
                Text("Ranking")
                TextField("Search for a movie...", text: $viewModel.searchTerm)
            }
            .padding()
            VStack {
                List{
                    MoviePresentationView()
                    .padding()
                }
            }
        }
    }
}

struct SearchView_Preview: PreviewProvider {
    static var previews: some View {
        let vM = SearchViewModel()
        return SearchView(viewModel: vM)
        
    }
}
