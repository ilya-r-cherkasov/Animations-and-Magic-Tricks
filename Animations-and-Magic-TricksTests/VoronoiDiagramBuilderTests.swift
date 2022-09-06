//
//  VoronoiDiagramBuilderTests.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 06.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class VoronoiDiagramBuilderTests: XCTestCase {

    let builder = VoronoiDiagramBuilder()

    func testCalculateMedianPerpendicular() {
        let start = CGPoint(x: -4.0, y: -16.0)
        let end = CGPoint(x: 22.0, y: 8.0)
        let line = builder._testableCalculateMedianPerpendicular(p1: start, p2: end)
        XCTAssertEqual(line, Line(-13, -12, 69))
    }

}
