//
//  VoronoiDiagramBuilderTests.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 06.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class VoronoiDiagramBuilderTests: XCTestCase {

    func testCalculateIntersectionPoints() {
        let builder = VoronoiDiagramBuilder()
        let points = [
            CGPoint(x: -6, y: -2),
            CGPoint(x: -4, y: 4),
            CGPoint(x: 2, y: 6),
            CGPoint(x: 6, y: -8)
        ]
        points.forEach { builder.addPoint($0) }
        let calculatedIntersectionPoints = builder._testableCalculateIntersectionPoints(for: CGPoint(x: -6, y: -2))
        let trueIntersectionPoints = [
            CGPoint(x: 1, y: -1),
            CGPoint(x: 5.0 / 3.0, y: -5.0 / 3.0),
            CGPoint(x: 156.0 / 84.0, y: -108.0 / 84.0)
        ]
        XCTAssertEqual(
            calculatedIntersectionPoints.sorted(by: { $0.x < $1.x }),
            trueIntersectionPoints.sorted(by: { $0.x < $1.x })
        )
    }

}
