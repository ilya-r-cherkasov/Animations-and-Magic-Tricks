//
//  PointView.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 05.09.2022.
//

import UIKit

final class PointView: UIView {

    // MARK: - Nested types

    enum Constants {
        static let defaultBackgroundColor: UIColor = Color.black
        static let defaultRadius: CGFloat = 5.0
    }

    // MARK: - Private calculated properties

    private var radius: CGFloat {
        _radius ?? Constants.defaultRadius
    }

    // MARK: - Private strored properties

    private var _radius: CGFloat?

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        configureAppearance()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }

    // MARK: - Methods

    func configure(with model: PointViewModel? = nil) {
        _radius = model?.radius
    }

    // MARK: - UIView

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if point.belongToCircle(center: bounds.center, radius: radius) {
            return self
        }
        return nil
    }

}

// MARK: - Private methods

private extension PointView {

    func configureAppearance() {
        backgroundColor = Color.black
        frame = CGRect(
            origin: frame.origin,
            size: CGSize(width: radius * 2, height: radius * 2)
        )
        layer.cornerRadius = radius
    }

}

// MARK: - CGPoint

private extension CGPoint {

    func belongToCircle(center: CGPoint, radius: CGFloat) -> Bool {
        pow((x - center.x), 2)
        + pow((y - center.y), 2)
        <= pow(radius, 2)
    }

}

