//
//  VoronoiDiagramBuilder.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics
import UIKit

final class VoronoiDiagramBuilder {

    // MARK: - Properties

    private(set) var points = [CGPoint]()
    private(set) var locuses = [Locus]()

    // MARK: - Private properties

    private var edgesLines: [Line] {
        [
            AG.topEdgeLine,
            AG.leadingEdgeLine,
            AG.trailingEdgeLine,
            AG.bottomEdgeLine
        ]
    }

    // MARK: - Methods

    func addPoint(_ point: CGPoint) {
        points.append(point)
    }

    func testCalcutateLocusVertexes(for site: CGPoint) -> [CGPoint] {
        calcutateLocusVertexes(for: site)
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

    func calculateEdgesPoints(with lines: [Line]) -> [CGPoint] {
        var edgesPoints = [CGPoint]()
        edgesLines.forEach { edgeLine in
            lines.forEach { line in
                let relationship = AG.calculateLinesRelationship(for: edgeLine, and: line)
                if
                    case .intersect(let intersectionPoint) = relationship,
                    UIScreen.main.bounds
                        .insetBy(dx: -20, dy: -20)
                        .contains(intersectionPoint)
                {
                    edgesPoints.append(intersectionPoint)
                }
            }
        }
        return edgesPoints
    }

    func calcutateLocusVertexes(for site: CGPoint) -> [CGPoint] {
        var vertexes = [CGPoint]()
        let perpendiculars = calculateMedianPerpendiculars(for: site)
        let intersectionPoints = calculateIntersectionPoints(for: site)
        let edgesPoints = calculateEdgesPoints(with: perpendiculars)
        (intersectionPoints + edgesPoints).forEach { point in
            if AG.detectTwoPointsBelongToSameHalfPlanes(
                lines: perpendiculars,
                p1: point,
                p2: site
            ) {
                vertexes.append(point)
            }
        }
        return vertexes
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
