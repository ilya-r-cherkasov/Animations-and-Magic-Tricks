//
//  LorenzPointsProvider.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 10.09.2022.
//

import CoreGraphics

final class LorenzPointsProvider {

    var x: CGFloat = 3.051522
    var y: CGFloat = 1.582542
    var z: CGFloat = 15.62388
    var x1: CGFloat = .zero
    var y1: CGFloat = .zero
    var z1: CGFloat = .zero
    var dt: CGFloat = 0.01
    var a: CGFloat = 5
    var b: CGFloat = 15
    var c: CGFloat = 1

    func get() -> [CGPoint] {
        var points = [CGPoint]()
        (0...10000).forEach { _ in
            x1 = x + a * (-x + y) * dt
            y1 = y + (b*x-y-z*x)*dt
            z1 = z + (-c*z+x*y)*dt
            x = x1
            y = y1
            z = z1
            points.append(
                CGPoint(
                    x: (19.3*(y - x*0.292893) + 320) * 0.7,
                    y: (-11*(z + x*0.292893) + 392) * 0.7
                )
            )
            //z = 9
        }
        return points
    }

}
