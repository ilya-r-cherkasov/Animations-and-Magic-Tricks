//
//  UIView.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 09.09.2022.
//

import UIKit

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
