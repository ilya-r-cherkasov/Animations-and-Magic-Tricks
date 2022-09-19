//
//  ColorChangerViewController.swift
//  Animations-and-Magic-Tricks
//
//  Created by Ilya Cherkasov on 12.09.2022.
//

import UIKit

final class ColorChangerViewController: UIViewController {

    // MARK: - Subviews

    private var imageView = UIImageView(frame: UIScreen.main.bounds)

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "watermelon")!
        //imageView.image = ColorChanger().erasureColor(from: image)
    }

}
