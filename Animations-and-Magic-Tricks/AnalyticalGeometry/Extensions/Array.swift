//
//  Array.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 08.09.2022.
//

import CoreGraphics

extension Array where Element == CGPoint {

    typealias Intersection = (point: CGPoint, parent: CGPoint)

    func sortAsVertex() -> Self {
        guard !isEmpty else { return [] }
        var copy = self
        var sorted: Self = []
        sorted.append(copy.removeFirst())
        copy.forEach { _ in
            if
                let last = sorted.last,
                let vertex = nextVertex(base: last, candidates: copy) {
                sorted.append(vertex)
                copy = copy.filter { $0 != vertex }
            }
        }
        return sorted
    }

    func nextVertex(base point: CGPoint,
                    candidates: [CGPoint]) -> CGPoint? {
        let candidates = candidates
            .filter { $0 != point }
            .sorted { $0.x < $1.x }
        let diagonals: [(Line, CGPoint)] = candidates.map { candidate in
            (
                AG.calculateLineBy(p1: point, p2: candidate),
                candidate
            )
        }
        let intersectionsPoints: [Intersection] = diagonals.compactMap { line, parentPoint in
            let relation = AG.calculateLinesRelationship(
                for: line,
                and: AG.leadingEdgeLine
            )
            if case .intersect(let point) = relation {
                return (point, parentPoint)
            }
            return nil
        }
        return intersectionsPoints
            .sorted { intersection1, intersection2 in
                intersection1.point.y < intersection2.point.y
            }
            .first?.parent
    }

}
