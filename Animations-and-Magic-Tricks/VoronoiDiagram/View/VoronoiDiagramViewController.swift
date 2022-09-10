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
    private let imageView = UIImageView(frame: UIScreen.main.bounds.insetBy(dx: 5, dy: 50))

    // MARK: - Private properties

    private let diagramBuilder = VoronoiDiagramBuilder()
    private var tapGecture = UITapGestureRecognizer()
    private var images = [UIImage]()
    private var timer: Timer?
    private let group = DispatchGroup()
    private var builders = [VoronoiDiagramBuilder]()
    private let stringImages = ["lion", "giraffe", "cat", "fish", "elephant"]

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        view.backgroundColor = .black
        configureTapGecture()
        view.addGestureRecognizer(tapGecture)
        view.addSubview(imageView)
        imageView.contentMode = .center
        generateDiagramImage()
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

    func generateDiagramImage() {
        (0...10).forEach { _ in
            group.enter()
            let diagramBuilder = VoronoiDiagramBuilder()
            builders.append(diagramBuilder)
            let sites = CGPoint.randoms(in: UIScreen.main.bounds, count: 100)
            let locusesView = LocusesView(frame: UIScreen.main.bounds)
            diagramBuilder.addSites(sites)
            diagramBuilder.onLocused = { [weak self] locused in
                locusesView.locuses = locused
                self?.images.append(locusesView.asImage())
                self?.group.leave()
            }
        }
        group.notify(queue: .main) { [weak self] in
            self?.builders.removeAll()
            self?.startAnimation()
        }
    }

    func startAnimation() {
        imageView.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse, .curveEaseOut]) {
            self.imageView.alpha = 1.0
        }

        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            self.imageView.applyCutMask(
                image: self.images.randomElement()!,
                cutMask: UIImage(named: self.stringImages.randomElement()!)!
            )
        }
        timer?.fire()
    }

}

// MARK: - Actions

@objc
private extension VoronoiDiagramViewController {

    func handleTap(sender: UITapGestureRecognizer) {
        generateDiagramImage()
    }

}
