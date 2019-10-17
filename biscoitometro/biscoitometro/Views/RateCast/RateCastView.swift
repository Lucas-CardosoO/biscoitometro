//
//  RateCastView.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 14/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI

struct RateCastView: View {
    @ObservedObject var viewModel: RateCastViewModel
    
    init(viewModel: RateCastViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            Spacer()
            Image(uiImage: viewModel.artistImage)
//                .scaleEffect(1/8, anchor: .center)
                .frame(width: artistDimension*2/3, height: artistDimension, alignment: .center)
                .clipped()
                .padding()
            Spacer()
            VStack{
                Text(viewModel.artistName)
                .padding()
                Text("Biscoitometro")
                .padding()
            }
        .padding()
            Spacer()
        }
    }
}

struct RateCastView_Previews: PreviewProvider {
    static var previews: some View {
        RateCastView(viewModel: RateCastViewModel(fetcher: Network(), artist: artistTest))
        .previewLayout(.fixed(width: 400, height: 150))
    }
}
