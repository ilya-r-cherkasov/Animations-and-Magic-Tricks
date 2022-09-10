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

    var onLocused: (([Locus]) -> Void)?

    private(set) var sites = [CGPoint]()

    // MARK: - Private properties

    private var locuses = [Locus]()
    private var group = DispatchGroup()
    private let lock = NSLock()

    private var calculationsQueue = DispatchQueue(
        label: "calculationsQueue",
        qos: .userInteractive,
        attributes: .concurrent
    )

    // MARK: - Methods

    func addSite(_ site: CGPoint) {
        sites.append(site)
        calculateLocuses()
    }

    func addSites(_ sites: [CGPoint]) {
        self.sites += sites
        calculateLocuses()
    }

    func reset() {
        sites.removeAll()
    }

}

// MARK: - Private methods

private extension VoronoiDiagramBuilder {

    func calculateLocuses() {
        locuses.removeAll()
        sites.forEach { site in
            calculationsQueue.async(
                execute: getWorkItemForVertexCalculation(with: site)
            )
        }
        group.notify(queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            self.onLocused?(self.locuses)
        }
    }

    func calculateMedianPerpendiculars(for site: CGPoint) -> [Line] {
        sites
            .filter {
                $0 != site
            }
            .map {
                AG.calculateMedianPerpendicular(p1: $0, p2: site)
            }
    }

    func calculateIntersectionPoints(for site: CGPoint, perpendiculars: inout [Line]) -> [CGPoint] {
        var intersectionPoints = [CGPoint]()
        let endIndex = perpendiculars.endIndex
        for index in 1...(endIndex - 1) {
            let perpendicular = perpendiculars[index - 1]
            intersectionPoints += perpendiculars[index...(endIndex - 1)].compactMap {
                let relationship = AG.calculateLinesRelationship(for: perpendicular, and: $0)
                if case .intersect(let intersectionPoint) = relationship {
                    return intersectionPoint
                }
                return nil
            }

        }
        return intersectionPoints
    }

    func calculateEdgesPoints(with lines: [Line]) -> [CGPoint] {
        var edgesPoints = [CGPoint]()
        AG.edgesLines.forEach { edgeLine in
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
        var perpendiculars = calculateMedianPerpendiculars(for: site)
        let intersectionPoints = calculateIntersectionPoints(for: site, perpendiculars: &perpendiculars)
        let edgesPoints = calculateEdgesPoints(with: perpendiculars)
        (intersectionPoints + edgesPoints).forEach { point in
            if AG.pointsBelongToSameHalfPlanes(
                lines: perpendiculars,
                p1: point,
                p2: site
            ) {
                vertexes.append(point)
            }
        }
        return vertexes
    }

    func getWorkItemForVertexCalculation(with site: CGPoint) -> DispatchWorkItem {
        group.enter()
        return DispatchWorkItem { [weak self] in
            guard let self = self else {
                return
            }
            let vertexes = self.calcutateLocusVertexes(for: site)
            self.lock.lock()
            self.locuses.append(Locus(site: site, vertexes: vertexes))
            self.lock.unlock()
            self.group.leave()
        }
    }

}

// MARK: - API for Tests

#if DEBUG

extension VoronoiDiagramBuilder {

    func _testableCalculateIntersectionPoints(for site: CGPoint, perpendiculars: [Line]) -> [CGPoint] {
        var perpendiculars = perpendiculars
        return calculateIntersectionPoints(for: site, perpendiculars: &perpendiculars)
    }

}

#endif
