//
//  SearchMovieView.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 01/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import SwiftUI

struct SearchMovieView: View {
    
    @ObservedObject var viewModel: SearchMovieViewModel
    
    init(viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            List {
                TextField("Search movie", text: $viewModel.searchMovieText)
                
                if viewModel.dataSource.isEmpty {
                    Text("Nada ainda")
                } else {
//                    TextView(self.viewModel)
                    Text(viewModel.dataSource)
                    Image(uiImage: viewModel.imageSource)
                }
            }
        }
    }
    
//    var textView: some View {
//        let text = $viewModel.dataSource as
//    }
}

struct TextView: View {
    var body: some View {
        Text(viewModel.dataSource)
    }
    
    var viewModel: SearchMovieViewModel
    
    init(_ viewModel: SearchMovieViewModel) {
        self.viewModel = viewModel
    }
}
