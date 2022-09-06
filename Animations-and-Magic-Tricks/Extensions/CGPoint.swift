//
//  CGPoint.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

extension CGPoint {

    func midpoint(to point: CGPoint) -> CGPoint {
        return CGPoint(
            x: (point.x + self.x) / 2,
            y: (point.y + self.y) / 2
        )
    }

}
