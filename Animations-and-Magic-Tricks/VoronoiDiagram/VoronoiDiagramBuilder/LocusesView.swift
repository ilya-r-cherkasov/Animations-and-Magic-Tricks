//
//  LocusesView.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 08.09.2022.
//

import UIKit

final class LocusesView: UIView {

    // MARK: - Properties

    var locuses = [[CGPoint]]() {
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

    func makeLocusPath(from locus: [CGPoint]) -> UIBezierPath {
        if locus.isEmpty { return UIBezierPath() }
        //var locus = locus.sortAsVertex()
        let path = UIBezierPath()
//        path.move(to: locus.removeFirst())
//        locus.forEach { point in
//            path.addLine(to: point)
//        }
//        locus.forEach { startPoint in
//            path.move(to: startPoint)
//            locus.forEach { point in
//                path.addLine(to: point)
//            }
//        }
        getAllTriangles(from: locus).forEach { triangle in
            let subPath = UIBezierPath()
            subPath.move(to: triangle[0])
            subPath.addLine(to: triangle[1])
            subPath.addLine(to: triangle[2])
            subPath.close()
            subPath.fill()
            path.append(subPath)
        }
        return path
    }

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

