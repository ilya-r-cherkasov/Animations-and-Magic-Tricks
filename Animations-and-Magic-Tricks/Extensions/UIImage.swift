//
//  UIImage.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 09.09.2022.
//

import UIKit

extension UIImageView {

    func applyCutMask(image: UIImage, cutMask: UIImage) {
        let size = cutMask.size.applying(.init(scaleX: 0.3, y: 0.3))
        let rect =  CGRect(origin: CGPoint(x:0,y:0), size: size)
        UIGraphicsBeginImageContext(size)
        image.draw(in: rect)
        cutMask.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = newImage
    }
    
}
