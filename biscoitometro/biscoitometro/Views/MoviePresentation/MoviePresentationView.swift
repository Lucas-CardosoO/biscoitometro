//
//  MoviePresentationView.swift
//  biscoitometro
//
//  Created by René Melo de Lucena on 08/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import SwiftUI
import Combine

struct MoviePresentationView: View {
    @ObservedObject var viewModel: MoviePresentationViewModel
    
    init(viewModel: MoviePresentationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .center){
            
            Image(uiImage: viewModel.imageSource)
                .resizable()
                .frame(width: posterWidth, height: posterWidth*40/27, alignment: .center)
            ZStack(alignment: .center){

                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(width: posterWidth, height: 0.4*posterWidth, alignment: .bottom)
                            .blur(radius: 40)
                        VStack {
                            Text(viewModel.title)
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.black)
                                .lineLimit(3)
                                .multilineTextAlignment(.center)
                                .frame(width: posterWidth, height: 0.4*posterWidth, alignment: .bottom)
                            Text("biscoitometro")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                    }
                }
                .padding(.bottom)

            }
        }
    }
    
}

//struct MoviePresentationView_Preview: PreviewProvider {
//    static var previews: some View {
//        MoviePresentationView()
//        .previewLayout(.fixed(width: 300, height: 400))
//    }
//}
