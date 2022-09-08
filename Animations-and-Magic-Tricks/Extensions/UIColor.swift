//
//  UIColor.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 08.09.2022.
//

import UIKit

extension UIColor {

    static var random: UIColor {
        .init(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }

}
