//
//  LorenzViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 10.09.2022.
//

import UIKit

final class LorenzViewController: UIViewController {

    let lorenzView = LorenzView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lorenzView)
        lorenzView.points = LorenzPointsProvider().get()
    }

}
