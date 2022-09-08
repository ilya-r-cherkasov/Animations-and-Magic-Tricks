//
//  PointViewModel.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics
import UIKit

struct PointViewModel {

    var radius: CGFloat?
    var color: UIColor?

    init(radius: CGFloat, color: UIColor) {
        self.radius = radius
        self.color = color
    }

}
