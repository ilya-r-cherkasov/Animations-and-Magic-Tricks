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
    private let imageView = UIImageView(frame: UIScreen.main.bounds.insetBy(dx: 5, dy: 5))

    // MARK: - Private properties

    private let diagramBuilder = VoronoiDiagramBuilder()
    private var tapGecture = UITapGestureRecognizer()

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureTapGecture()
        view.addGestureRecognizer(tapGecture)
        view.addSubview(imageView)
        locusesView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        view.backgroundColor = .black
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
        diagramBuilder.onLocused = { [weak self] locused in
            self?.locusesView.locuses = locused
        }
    }

    func generateDiagram() {
        diagramBuilder.reset()
        let sites = CGPoint.randoms(in: UIScreen.main.bounds, count: 50)
        diagramBuilder.addSites(sites)
        diagramBuilder.onLocused = { [weak self] locused in
            self?.locusesView.locuses = locused
        }
        let locusesImage = locusesView.asImage()
        imageView.applyCutMask(image: locusesImage, cutMask: UIImage(named: "giraffe")!)
    }

}

// MARK: - Actions

@objc
private extension VoronoiDiagramViewController {

    func handleTap(sender: UITapGestureRecognizer) {
        generateDiagram()
    }

}
