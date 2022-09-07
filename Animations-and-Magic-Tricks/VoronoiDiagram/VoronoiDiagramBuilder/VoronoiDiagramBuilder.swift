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

    private var screenBounds = UIScreen.main.bounds

    private var topEdgeLine: Line {
        AG.calculateLineBy(
            p1: .zero,
            p2: CGPoint(x: screenBounds.maxX, y: .zero)
        )
    }

    private var leadingEdgeLine: Line {
        AG.calculateLineBy(
            p1: .zero,
            p2: CGPoint(x: .zero, y: screenBounds.maxY)
        )
    }

    private var trailingEdgeLine: Line {
        AG.calculateLineBy(
            p1: CGPoint(x: screenBounds.maxX, y: .zero),
            p2: CGPoint(x: screenBounds.maxX, y: screenBounds.maxY)
        )
    }

    private var bottomEdgeLine: Line {
        AG.calculateLineBy(
            p1: CGPoint(x: .zero, y: screenBounds.maxY),
            p2: CGPoint(x: screenBounds.maxX, y: screenBounds.maxY)
        )
    }

    private var edgesLines: [Line] {
        [
            topEdgeLine,
            leadingEdgeLine,
            trailingEdgeLine,
            bottomEdgeLine
        ]
    }

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
        let edgesPoints = calculateEdgesPoints(with: perpendiculars)
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
        return intersectionPoints + edgesPoints
    }

    func calculateEdgesPoints(with lines: [Line]) -> [CGPoint] {
        var edgesPoints = [CGPoint]()
        edgesLines.forEach { edgeLine in
            lines.forEach { line in
                let relationship = AG.calculateLinesRelationship(for: edgeLine, and: line)
                if case .intersect(let intersectionPoint) = relationship {
                    edgesPoints.append(intersectionPoint)
                }
            }
        }
        return edgesPoints
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
