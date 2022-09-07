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

// MARK: - Private methods

private extension VoronoiDiagramBuilder {

    func calculateMedianPerpendiculars(for site: CGPoint) -> [Line] {
        let otherPoints = points.filter { $0 != site }
        var lines = [Line]()
        otherPoints.forEach {
            lines.append(AG.calculateMedianPerpendicular(p1: $0, p2: site))
        }
        return lines
    }

    func calculateIntersectionPoints(for site: CGPoint) -> [CGPoint] {
        var perpendiculars = calculateMedianPerpendiculars(for: site)
        var intersectionPoints = [CGPoint]()
        perpendiculars.forEach { perpendicular in
            let otherPerpendiculars = perpendiculars.filter { $0 != perpendicular }
            otherPerpendiculars.forEach { otherPerpendicular in
                let relationship = AG.calculateLinesRelationship(for: perpendicular, and: otherPerpendicular)
                if case .intersect(let intersectionPoint) = relationship {
                    intersectionPoints.append(intersectionPoint)
                }
            }
            perpendiculars.removeFirst()
        }
        return intersectionPoints
    }
    
}

// MARK: - API for Tests

#if DEBUG

extension VoronoiDiagramBuilder {

    func _testableCalculateIntersectionPoints(for site: CGPoint) -> [CGPoint] {
        calculateIntersectionPoints(for: site)
    }

}

#endif
