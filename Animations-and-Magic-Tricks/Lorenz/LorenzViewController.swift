//
//  LorenzViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 10.09.2022.
//

import UIKit

final class LorenzViewController: UIViewController {

    // MARK: - Subviews

    private let startButton = UIButton(frame: CGRect(x: 200, y: 200, width: 100, height: 100))

    // MARK: - Private properties

    private let endNumber = 50_000_000
    private var trueResult: Int!
    private var c_testData: [CLongLong]!
    private var testData: [Int]!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        trueResult = (1 + endNumber) * endNumber / 2 //arifmetic progression
        testData = (1...endNumber).map { Int($0) }
        c_testData = (1...endNumber).map { CLongLong($0) }
        startButton.setTitleColor(.red, for: .normal)
        startButton.setTitle("Start", for: .normal)
        startButton.addTarget(self, action: #selector(startTest), for: .touchUpInside)
        view.addSubview(startButton)
        print("Ready")
    }

}

// MARK: - Actions

@objc
private extension LorenzViewController {

    func startTest() {
        testFor()
    }

}

// MARK: -  Private methods

private extension LorenzViewController {

    func testFor() {
        var result: Int = 0
        for number in testData {
            result += number
        }
        print(result == trueResult)
    }

    func test_c_for_each() {
        let result = c_for_each(&c_testData)
        print(Int(result) == trueResult)
    }

    func testForEach() {
        var result: Int = 0
        testData.forEach { number in
            result += number
        }
        print(result == trueResult)
    }

}
