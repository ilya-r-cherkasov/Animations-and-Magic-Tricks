//
//  LorenzView.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 10.09.2022.
//

import UIKit

final class LorenzView: UIView {

    let path = UIBezierPath()
    var points = [CGPoint]() {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.blue.setStroke()
        path.removeAllPoints()
        path.move(to: points.removeFirst())
        points.forEach { point in
            path.addLine(to: point)
        }
        path.close()
        path.stroke()
        points = LorenzPointsProvider().get()
    }

}
