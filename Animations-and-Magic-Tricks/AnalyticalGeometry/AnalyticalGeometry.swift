//
//  AnalyticalGeometry.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 07.09.2022.
//

import CoreGraphics

typealias AG = AnalyticalGeometry

class AnalyticalGeometry {

    static func calculateMedianPerpendicular(p1: CGPoint, p2: CGPoint) -> Line {
        let A = p2.x - p1.x
        let B = p2.y - p1.y
        let midpoint = p2.midpoint(to: p1)
        let C = -(A * midpoint.x) - (B * midpoint.y)
        return Line(A, B, C)
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

}
