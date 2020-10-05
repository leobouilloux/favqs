//
//  SplashScreenViewController.swift
// Favqs
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class SplashScreenViewController: RxViewController {
    let viewModel: SplashScreenViewModelInterface

    private let titleLabel: UILabel
    private let avatarView: UIView
    private let avatarImageView: UIImageView
    private let avatarLabel: UILabel
    private let activityIndicatorView: UIActivityIndicatorView

    init(with viewModel: SplashScreenViewModelInterface) {
        self.viewModel = viewModel
        self.titleLabel = UILabel()
        self.avatarView = UIView()
        self.avatarImageView = UIImageView()
        self.avatarLabel = UILabel()
        if #available(iOS 13.0, *) {
            self.activityIndicatorView = UIActivityIndicatorView(style: .medium)
        } else {
            self.activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        }
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.viewModel.output.didFinishLoading.accept(())
        }
    }
}

private extension SplashScreenViewController {
    /* View */
    func setupView() {
        view.backgroundColor = UIColor(hex: "#5188C7")

        setupTitleLabel()
        setupActivityIndicatorView()
        setupAvatarView()
    }

    func setupTitleLabel() {
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 72)
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: titleLabel, attribute: .centerY,
                relatedBy: .equal,
                toItem: view, attribute: .centerY,
                multiplier: 0.5, constant: 0
            ),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        activityIndicatorView.color = .white
        view.addSubview(activityIndicatorView)

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func setupAvatarView() {
        view.addSubview(avatarView)

        setupAvatarImageView()
        setupAvatarLabel()

        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint( // this is not possible using anchors for some reason
                item: avatarView, attribute: .centerY,
                relatedBy: .equal,
                toItem: view, attribute: .centerY,
                multiplier: 1.5, constant: 0
            ),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            avatarView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            avatarView.heightAnchor.constraint(equalToConstant: 64)
        ])

    }

    func setupAvatarImageView() {
        avatarImageView.contentMode = .scaleAspectFit
        avatarView.addSubview(avatarImageView)

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64)
        ])

        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 32
    }

    func setupAvatarLabel() {
        avatarLabel.font = .boldSystemFont(ofSize: 14)
        avatarLabel.textColor = .white
        avatarLabel.numberOfLines = 0
        avatarView.addSubview(avatarLabel)

        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            avatarLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            avatarLabel.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor)
        ])
    }

    /* Rx Bindings */
    func setupRxBindings() {
        bindTitleLabel()
        bindAvatarImageView()
        bindAvatarLabel()
    }

    func bindTitleLabel() {
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: bag)
    }

    func bindAvatarImageView() {
        viewModel.avatarImage.bind(to: avatarImageView.rx.image).disposed(by: bag)
    }

    func bindAvatarLabel() {
        viewModel.caption.bind(to: avatarLabel.rx.text).disposed(by: bag)
    }
}
