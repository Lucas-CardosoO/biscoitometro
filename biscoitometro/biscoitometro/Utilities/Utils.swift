//
//  Utils.swift
//  biscoitometro
//
//  Created by Lucas Cardoso on 17/10/19.
//  Copyright © 2019 Lucas Cardoso. All rights reserved.
//

import Foundation
import SwiftUI

func resizedImageWith(image: UIImage, targetSize: CGSize) -> UIImage {

    let imageSize = image.size
//    print(imageSize)
    let newWidth  = targetSize.width  / image.size.width
    let newHeight = targetSize.height / image.size.height
    var newSize: CGSize

    if(newWidth > newHeight) {
        newSize = CGSize(width: imageSize.width * newHeight, height: imageSize.height * newHeight)
    } else {
        newSize = CGSize(width: imageSize.width * newWidth,  height: imageSize.height * newWidth)
    }

    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)

    image.draw(in: rect)

    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return newImage ?? UIImage()
}
