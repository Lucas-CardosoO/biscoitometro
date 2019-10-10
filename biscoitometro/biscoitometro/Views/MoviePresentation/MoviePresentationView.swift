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
                .scaledToFill()
            ZStack{

                VStack {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(width: 250, height: 100, alignment: .bottom)
                            .blur(radius: 40)
                        VStack {
//                            Text("Thor")
                            Text(viewModel.title)
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .fontWeight(.black)
                            Text("biscoitometro")
                            .font(.largeTitle)
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
