//
//  LoaderController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

public final class LoaderController: UIViewController {
    let activityIndicator = UIActivityIndicatorView()

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension LoaderController {
    /******************************************************/
    // MARK: - View
    func setupView() {
        view.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)

        setupActivityIndicatorView()
    }

    func setupActivityIndicatorView() {
        activityIndicator.backgroundColor = .tertiarySystemBackground
        activityIndicator.style = .large
        activityIndicator.color = .label
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.masksToBounds = true
        view.addSubview(activityIndicator)

        activityIndicator.startAnimating()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 55),
            activityIndicator.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    /******************************************************/
    // MARK: - RxBindings
    func setupRxBindings() {

    }
}
