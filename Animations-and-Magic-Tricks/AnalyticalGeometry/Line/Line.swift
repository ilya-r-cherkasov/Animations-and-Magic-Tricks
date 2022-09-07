//
//  Line.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

struct Line {

    // MARK: - Properties

    // Coefficients of common line equation
    // Ax + By + C = 0
    let A: CGFloat
    let B: CGFloat
    let C: CGFloat

    var coefficients: (A: CGFloat, B: CGFloat, C: CGFloat) {
        (A, B, C)
    }

    // MARK: - Initialization

    init(A: CGFloat, B: CGFloat, C: CGFloat) {
        self.A = A
        self.B = B
        self.C = C
    }

    init(_ A: CGFloat, _ B: CGFloat, _ C: CGFloat) {
        self.init(A: A, B: B, C: C)
    }

}

// MARK: - Methods

extension Line {

    func parallel(to line: Line) -> Bool {
        self.A * line.B  == self.B * line.A
    }

}

// MARK: - Equatable

extension Line: Equatable {

    static func == (lhs: Line, rhs: Line) -> Bool {
        lhs.A * rhs.B  == lhs.B * rhs.A
        && lhs.B * rhs.C == lhs.C * rhs.B
    }

}
