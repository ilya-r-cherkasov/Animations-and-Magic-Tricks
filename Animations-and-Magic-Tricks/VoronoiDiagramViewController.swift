//
//  VoronoiDiagramViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import UIKit

class VoronoiDiagramViewController: UIViewController {

    // MARK: - Private properties

    private let diagramBuilder = VoronoiDiagramBuilder()
    private var tapGecture = UITapGestureRecognizer()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTapGecture()
        view.addGestureRecognizer(tapGecture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Private methods

private extension VoronoiDiagramViewController {

    func configureTapGecture() {
        tapGecture.numberOfTapsRequired = 1
        tapGecture.addTarget(self, action: #selector(handleTap(sender:)))
    }

    func addPoint(with coordinate: CGPoint) {
        let point = PointView()
        view.addSubview(point)
        point.configure()
        point.center = coordinate
        diagramBuilder.addPoint(coordinate)
    }

}

// MARK: - Actions

@objc
private extension VoronoiDiagramViewController {

    func handleTap(sender: UITapGestureRecognizer) {
        addPoint(with: sender.location(in: view))
    }

}
