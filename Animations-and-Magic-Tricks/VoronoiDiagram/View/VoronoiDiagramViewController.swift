//
//  VoronoiDiagramViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import UIKit

class VoronoiDiagramViewController: UIViewController {

    // MARK: - Subviews

    private let locusesView = LocusesView(frame: UIScreen.main.bounds)

    // MARK: - Private properties

    private let diagramBuilder = VoronoiDiagramBuilder()
    private var tapGecture = UITapGestureRecognizer()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTapGecture()
        view.addGestureRecognizer(tapGecture)
        view.addSubview(locusesView)
        locusesView.backgroundColor = .lightGray
        generateDiagram()
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
        diagramBuilder.addSite(coordinate)
        locusesView.locuses = diagramBuilder.locuses
    }

    func generateDiagram() {
        let sites = CGPoint.randoms(in: UIScreen.main.bounds, count: 20)
        diagramBuilder.addSites(sites)
        locusesView.locuses = diagramBuilder.locuses
    }

}

// MARK: - Actions

@objc
private extension VoronoiDiagramViewController {

    func handleTap(sender: UITapGestureRecognizer) {
        addPoint(with: sender.location(in: view))
    }

}
