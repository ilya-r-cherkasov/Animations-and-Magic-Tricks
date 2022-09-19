//
//  HighOrderFunctions.swift
//  Animations-and-Magic-TricksTests
//
//  Created by Ilya Cherkasov on 18.09.2022.
//

import XCTest
@testable import Animations_and_Magic_Tricks

final class HighOrderFunctionsPerfomanceTests: XCTestCase {

    let endNumber = 50_000_000

    lazy var trueResult: Int = (1 + endNumber) * endNumber / 2 //arifmetic progression
    lazy var testData: [Int] = (1...endNumber).map { Int($0) }
    lazy var c_testData: [CLongLong] = (1...endNumber).map { CLongLong($0) }

    func testForEachLoop() {
        var result: Int = 0
        let testData = testData
        measure {
            testData.forEach { number in
                result += number
            }
        }
    }

    func testForLoop() {
        var result: Int = 0
        let testData = testData
        measure {
            for number in testData {
                result += number
            }
        }
    }

    func testReduce() {
        let testData = testData
        measure {
            testData.reduce(0, +)
        }
    }

    func testMap() {
        var result: Int = 0
        let testData = testData
        measure {
            _ = testData.map { number in
                result += number
            }
        }
    }

    func test_c_forEach() {
        var testData = c_testData
        var result: CLongLong = 0
        measure {
            result = c_for_each(&testData)
        }
        XCTAssertEqual(result, 1250000025000000)
    }

}
