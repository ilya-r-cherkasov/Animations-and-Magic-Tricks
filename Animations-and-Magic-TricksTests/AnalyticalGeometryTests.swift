//
//  AnalyticalGeometryTests.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 07.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class AnalyticalGeometryTests: XCTestCase {

    func testLineEqualityToYourself() {
        let line = Line(1, -2, 1)
        XCTAssertEqual(line, line)
    }

    func testLineEqualityInCommonCase() {
        let line1 = Line(1, -2, 1)
        let line2 = Line(-3, 6, -3)
        XCTAssertEqual(line1, line2)
    }

    func testLineEqualityWithZeroComponent() {
        let line1 = Line(1, -2, 0)
        let line2 = Line(-3, 6, 0)
        XCTAssertEqual(line1, line2)
    }

    func testCalculateMedianPerpendicular() {
        let start = CGPoint(x: -4.0, y: -16.0)
        let end = CGPoint(x: 22.0, y: 8.0)
        let line = AG.calculateMedianPerpendicular(p1: start, p2: end)
        XCTAssertEqual(line, Line(-13, -12, 69))
    }

    func testCalculateIntersectionPoint() {
        let line1 = Line(-12, 13, 160)
        let line2 = Line(-13, -12, 69)
        let relationship = AG.calculateLinesRelationship(for: line1, and: line2)
        if case .intersect(let intersectionPoint) = relationship {
            XCTAssertEqual(intersectionPoint, CGPoint(x: 9.0, y: -4.0))
        } else {
            XCTFail()
        }
    }

    func testCalculateLineByTwoPoint() {
        let line = AG.calculateLineBy(
            p1: CGPoint(x: -6, y: -2),
            p2: CGPoint(x: -4, y: 4)
        )
        let trueLine = Line(A: -3, B: 1, C: -16)
        XCTAssertEqual(trueLine, line)
    }

    func testTwoPointsBelongToSameHalfPlaneNum1() {
        let line = Line(A: -3, B: 1, C: -16)
        let result = AG.detectTwoPointsBelongToSameHalfPlane(
            line: line,
            p1: CGPoint(x: -5.0, y: 6.0),
            p2: CGPoint(x: -6.0, y: 4.0)
        )
        XCTAssertTrue(result)
    }

    func testTwoPointsBelongToSameHalfPlaneNum2() {
        let line = Line(A: -3, B: 1, C: -16)
        let result = AG.detectTwoPointsBelongToSameHalfPlane(
            line: line,
            p1: CGPoint(x: -5.0, y: 6.0),
            p2: CGPoint(x: -6.0, y: 4.0)
        )
        XCTAssertTrue(result)
    }

    func testTwoPointsDontBelongToSameHalfPlane() {
        let line = Line(A: -3, B: 1, C: -16)
        let result = AG.detectTwoPointsBelongToSameHalfPlane(
            line: line,
            p1: CGPoint(x: -5.0, y: 6.0),
            p2: CGPoint(x: -2.0, y: 2.0)
        )
        XCTAssertFalse(result)
    }

}
