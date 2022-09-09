//
//  AnalyticalGeometry.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 07.09.2022.
//

import CoreGraphics
import UIKit

typealias AG = AnalyticalGeometry

class AnalyticalGeometry {

    // MARK: - Static roperties

    static var topEdgeLine: Line = {
        AG.calculateLineBy(
            p1: .zero,
            p2: CGPoint(x: screenBounds.maxX, y: .zero)
        )
    }()

    static var leadingEdgeLine: Line = {
        AG.calculateLineBy(
            p1: .zero,
            p2: CGPoint(x: .zero, y: screenBounds.maxY)
        )
    }()

    static var trailingEdgeLine: Line = {
        AG.calculateLineBy(
            p1: CGPoint(x: screenBounds.maxX, y: .zero),
            p2: CGPoint(x: screenBounds.maxX, y: screenBounds.maxY)
        )
    }()

    static var bottomEdgeLine: Line = {
        AG.calculateLineBy(
            p1: CGPoint(x: .zero, y: screenBounds.maxY),
            p2: CGPoint(x: screenBounds.maxX, y: screenBounds.maxY)
        )
    }()

    static var edgesLines: [Line] = {
        [
            AG.topEdgeLine,
            AG.leadingEdgeLine,
            AG.trailingEdgeLine,
            AG.bottomEdgeLine
        ]
    }()

    // MARK: - Private properties

    private static var screenBounds = UIScreen.main.bounds

    // MARK: - Static functions

    static func calculateMedianPerpendicular(p1: CGPoint, p2: CGPoint) -> Line {
        let A = p2.x - p1.x
        let B = p2.y - p1.y
        let midpoint = p2.midpoint(to: p1)
        let C = -(A * midpoint.x) - (B * midpoint.y)
        return Line(A, B, C)
    }

    static func calculateLineBy(p1: CGPoint, p2: CGPoint) -> Line {
        Line(
            A: p1.y - p2.y,
            B: p2.x - p1.x,
            C: p1.x * p2.y - p2.x * p1.y
        )
    }

    static func calculateLinesRelationship(for l1: Line, and l2: Line) -> LinesRelationship {
        guard l1 != l2 else {
            return .match
        }
        guard !l1.parallel(to: l2) else {
            return .parallel
        }
        let (A1, B1, C1) = (l1.A, l1.B, l1.C)
        let (A2, B2, C2) = (l2.A, l2.B, l2.C)
        let intersectPoint = CGPoint(
            x: (C2 * B1 - C1 * B2) / (A1 * B2 - A2 * B1),
            y: (C2 * A1 - C1 * A2) / (B1 * A2 - B2 * A1)
        )
        return .intersect(intersectPoint)
    }

    static func pointsBelongToSameHalfPlane(line: Line,
                                            p1: CGPoint,
                                            p2: CGPoint) -> Bool {
        if p1.belong(to: line) || p2.belong(to: line) {
            return true
        } else {
            return line.substitute(point: p1) * line.substitute(point: p2) >= 0
        }
    }

    static func pointsBelongToSameHalfPlanes(lines: [Line], p1: CGPoint, p2: CGPoint) -> Bool {
        for line in lines {
            if !pointsBelongToSameHalfPlane(line: line, p1: p1, p2: p2) {
                return false
            }
        }
        return true
    }

}
