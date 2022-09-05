//
//  VoronoiDiagramViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import UIKit

class VoronoiDiagramViewController: UIViewController {

    let point = PointView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(point)
        point.configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        point.center = view.center
    }

}

