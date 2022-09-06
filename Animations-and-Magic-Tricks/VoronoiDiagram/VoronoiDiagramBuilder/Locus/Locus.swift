//
//  Locus.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

struct Locus {

    // MARK: - Properties

    let point: CGPoint
    let vertexes: [CGPoint]

    // MARK: - Initialization

    init(point: CGPoint, vertexes: [CGPoint]) {
        self.point = point
        self.vertexes = vertexes
    }
    
}
