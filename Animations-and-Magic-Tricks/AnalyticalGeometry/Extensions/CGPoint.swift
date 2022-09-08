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

    private var acceptableRange: ClosedRange<CGFloat> {
        -Constants.epsilon...Constants.epsilon
    }

    // MARK: - Methods

    func midpoint(to point: CGPoint) -> CGPoint {
        return CGPoint(
            x: (point.x + self.x) / 2,
            y: (point.y + self.y) / 2
        )
    }

    func belong(to line: Line) -> Bool {
        acceptableRange.contains(line.substitute(point: self))
    }

}