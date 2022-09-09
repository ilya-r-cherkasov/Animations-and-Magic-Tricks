//
//  CGPoint.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

extension CGPoint {

    // MARK: - Nested types

    private enum Constants {
        static var epsilon: CGFloat = 1e-5
    }

    // MARK: - Static methods

    static func random(in rect: CGRect) -> CGPoint {
        CGPoint(
            x: CGFloat.random(in: rect.minX...rect.maxX),
            y: CGFloat.random(in: rect.minY...rect.maxY)
        )
    }

    static func randoms(in rect: CGRect, count: Int)  -> [CGPoint] {
        var randoms = [CGPoint]()
        for _ in 1...count {
            randoms.append(.random(in: rect))
        }
        return randoms
    }

    // MARK: - Methods

    func midpoint(to point: CGPoint) -> CGPoint {
        return CGPoint(
            x: (point.x + self.x) / 2,
            y: (point.y + self.y) / 2
        )
    }

    func belong(to line: Line) -> Bool {

        /*

         (-Constants.epsilon ... 0 ... Constants.epsilon)
                              |
                            result

         In all cases if result hit in range expression
         (result + Constants.epsilon) * (result - Constants.epsilon) <= 0
         */
        
        let result = line.substitute(point: self)
        return (result + Constants.epsilon) * (result - Constants.epsilon) <= 0
    }

}
