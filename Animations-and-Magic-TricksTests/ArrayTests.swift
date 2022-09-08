//
//  ArrayTests.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 08.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class ArrayTests: XCTestCase {

    func testSortAsVertex() {
        let candidates: [CGPoint] = [
            CGPoint(x: 10.0, y: 4.0),
            CGPoint(x: 16.0, y: 6.0),
            CGPoint(x: 14.0, y: 6.0),
            CGPoint(x: 20.0, y: 2.0),
            CGPoint(x: 12.0, y: 2.0),
            CGPoint(x: 16.0, y: 0.0)
        ]
        let truePoints: [CGPoint] = [
            CGPoint(x: 10.0, y: 4.0),
            CGPoint(x: 14.0, y: 6.0),
            CGPoint(x: 16.0, y: 6.0),
            CGPoint(x: 20.0, y: 2.0),
            CGPoint(x: 16.0, y: 0.0),
            CGPoint(x: 12.0, y: 2.0)
        ]
        XCTAssertEqual(candidates.sortAsVertex(), truePoints)
    }

}
