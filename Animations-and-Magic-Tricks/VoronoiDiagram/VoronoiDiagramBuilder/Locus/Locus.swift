//
//  Locus.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

struct Locus {

    // MARK: - Properties

    // locus building for this point (named site)
    let site: CGPoint

    //vertex of locus
    let vertexes: [CGPoint]

    // MARK: - Initialization

    init(site: CGPoint, vertexes: [CGPoint]) {
        self.site = site
        self.vertexes = vertexes
    }
    
}
