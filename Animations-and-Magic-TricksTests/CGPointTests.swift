//
//  CGPointTests.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 06.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class CGPointTests: XCTestCase {

    func testMidpoint() {
        let start = CGPoint(x: -4.0, y: -16.0)
        let end = CGPoint(x: 22.0, y: 8.0)
        let midpoint = start.midpoint(to: end)
        XCTAssertEqual(midpoint, CGPoint(x: 9.0, y: -4.0))
    }

}
