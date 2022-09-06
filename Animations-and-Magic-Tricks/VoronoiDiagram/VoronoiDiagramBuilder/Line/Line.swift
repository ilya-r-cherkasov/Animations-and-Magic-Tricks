//
//  Line.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

struct Line {

    // Coefficients of common line equation
    // Ax + By + C = 0
    let A: CGFloat
    let B: CGFloat
    let C: CGFloat

    init(A: CGFloat, B: CGFloat, C: CGFloat) {
        self.A = A
        self.B = B
        self.C = C
    }

    init(_ A: CGFloat, _ B: CGFloat, _ C: CGFloat) {
        self.init(A: A, B: B, C: C)
    }

}

extension Line: Equatable {

    static func == (lhs: Line, rhs: Line) -> Bool {
        lhs.A / rhs.A == lhs.B / rhs.B && lhs.B / rhs.B == lhs.C / rhs.C
    }

}
