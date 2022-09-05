//
//  VoronoiDiagramBuilder.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import CoreGraphics

final class VoronoiDiagramBuilder {

    // MARK: - Properties

    private(set) var points = [CGPoint]()

    // MARK: - Methods

    func addPoint(_ point: CGPoint) {
        points.append(point)
    }

}
