//
//  VoronoiDiagramBuilder.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

final class VoronoiDiagramBuilder {

    // MARK: - Properties

    private(set) var points = [CGPoint]()
    private(set) var locuses = [Locus]()

    // MARK: - Private properties

    // MARK: - Methods

    func addPoint(_ point: CGPoint) {
        points.append(point)
    }

}

private extension VoronoiDiagramBuilder {

    func calculateMedianPerpendicular(p1: CGPoint, p2: CGPoint) -> Line {
        let A = p2.x - p1.x
        let B = p2.y - p1.y
        let midpoint = p2.midpoint(to: p1)
        let C = -(A * midpoint.x) - (B * midpoint.y)
        return Line(A, B, C)
    }

}

#if DEBUG

extension VoronoiDiagramBuilder {

    func _testableCalculateMedianPerpendicular(p1: CGPoint, p2: CGPoint) -> Line {
        calculateMedianPerpendicular(p1: p1, p2: p2)
    }

}

#endif
