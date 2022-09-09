//
//  LocusesView.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 08.09.2022.
//

import UIKit

final class LocusesView: UIView {

    // MARK: - Properties

    var locuses = [Locus]() {
        didSet {
            setNeedsDisplay()
        }
    }

    // MARK: - Private properties

    private var pathBuffer = UIBezierPath()

    // MARK: - UIView

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        pathBuffer.removeAllPoints()
        locuses.forEach { locus in
            UIColor.random.setFill()
            let locusPath = makeLocusPath(from: locus)
            pathBuffer.append(locusPath)
        }
    }

}

// MARK: - Private methods

private extension LocusesView {

    func makeLocusPath(from locus: Locus) -> UIBezierPath {
        if locus.vertexes.isEmpty { return UIBezierPath() }
        let path = UIBezierPath()
        getAllTriangles(from: locus.vertexes).forEach { triangle in
            let subPath = UIBezierPath()
            subPath.move(to: triangle[0])
            subPath.addLine(to: triangle[1])
            subPath.addLine(to: triangle[2])
            subPath.close()
            subPath.fill()
            path.append(subPath)
        }
//        var vertexes = locus.vertexes
//        path.move(to: vertexes.removeFirst())
//        vertexes.forEach { vertex in
//            path.addLine(to: vertex)
//        }
//        path.close()
//        path.fill()
        return path
    }

    //TODO: - non-optimal solution
    //wiil changed to sortAsVertex()
    func getAllTriangles(from points: [CGPoint]) -> [[CGPoint]] {
        var triangles = [[CGPoint]]()
        points.forEach { p1 in
            points.forEach { p2 in
                points.forEach { p3 in
                    triangles.append([p1, p2, p3])
                }
            }
        }
        return triangles
    }

}

