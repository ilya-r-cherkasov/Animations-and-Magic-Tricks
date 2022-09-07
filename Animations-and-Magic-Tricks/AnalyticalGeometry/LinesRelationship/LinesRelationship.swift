//
//  LinesRelationship.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 07.09.2022.
//

import CoreGraphics

enum LinesRelationship {
    case match
    case intersect(CGPoint)
    case parallel
}
