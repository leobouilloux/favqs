//
//  AccountViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import UIKit

final class AccountViewController: RxViewController {
    private let viewModel: AccountViewModelInterface

    private let avatarView = UIView()
    private let avatarImageView = UIImageView()
    private let loginLabel = UILabel()
    private let favoritesCountLabel = UILabel()
    private let followingCountLabel = UILabel()
    private let followersCountLabel = UILabel()
    private let signoutButton = UIButton()

    init(with viewModel: AccountViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.isControllerActive.accept(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        viewModel.isControllerActive.accept(false)
    }
}

private extension AccountViewController {
    /* View */
    func setupView() {
        setupAvatarView()
        setupFavoritesCountLabel()
        setupFollowingCountLabel()
        setupFollowersCountLabel()
        setupSignOutButton()
    }

    func setupAvatarView() {
        view.addSubview(avatarView)

        setupAvatarImageView()
        setupLoginLabel()

        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            avatarView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            avatarView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16),
            avatarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func setupAvatarImageView() {
        avatarImageView.backgroundColor = .lightGray
        avatarImageView.tintColor = .white
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

    func setupLoginLabel() {
        loginLabel.textColor = .label
        loginLabel.font = .boldSystemFont(ofSize: 24)
        loginLabel.numberOfLines = 0
        avatarView.addSubview(loginLabel)

        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            loginLabel.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor),
            loginLabel.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor)
        ])
    }

    func setupFavoritesCountLabel() {
        favoritesCountLabel.textColor = .secondaryLabel
        favoritesCountLabel.font = .systemFont(ofSize: 20)
        favoritesCountLabel.textAlignment = .center
        view.addSubview(favoritesCountLabel)

        favoritesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesCountLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 24),
            favoritesCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            favoritesCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupFollowingCountLabel() {
        followingCountLabel.textColor = .secondaryLabel
        followingCountLabel.font = .systemFont(ofSize: 20)
        followingCountLabel.textAlignment = .center
        view.addSubview(followingCountLabel)

        followingCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followingCountLabel.topAnchor.constraint(equalTo: favoritesCountLabel.bottomAnchor, constant: 8),
            followingCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            followingCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupFollowersCountLabel() {
        followersCountLabel.textColor = .secondaryLabel
        followersCountLabel.font = .systemFont(ofSize: 20)
        followersCountLabel.textAlignment = .center
        view.addSubview(followersCountLabel)

        followersCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            followersCountLabel.topAnchor.constraint(equalTo: followingCountLabel.bottomAnchor, constant: 8),
            followersCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            followersCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    func setupSignOutButton() {
        signoutButton.tintColor = .white
        signoutButton.backgroundColor = .red
        view.addSubview(signoutButton)

        signoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signoutButton.heightAnchor.constraint(equalToConstant: 54),
            signoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24)
        ])

        signoutButton.layer.masksToBounds = true
        signoutButton.layer.cornerRadius = 4
    }

    /* Rx Bindings */
    func setupRxBindings() {
        bindNavigationItems()
        bindAvatarImageView()
        bindLogin()
        bindFavoritesCountLabel()
        bindFollowingCountLabel()
        bindFollowersCountLabel()
        bindSignOutButton()
    }

    func bindAvatarImageView() {
        viewModel.avatarImage.bind(to: avatarImageView.rx.image).disposed(by: bag)
    }

    func bindNavigationItems() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }

    func bindLogin() {
        viewModel.login.bind(to: loginLabel.rx.text).disposed(by: bag)
    }

    func bindFavoritesCountLabel() {
        viewModel.favoriteCount.bind(to: favoritesCountLabel.rx.text).disposed(by: bag)
    }

    func bindFollowingCountLabel() {
        viewModel.following.bind(to: followingCountLabel.rx.text).disposed(by: bag)
    }

    func bindFollowersCountLabel() {
        viewModel.followers.bind(to: followersCountLabel.rx.text).disposed(by: bag)
    }

    func bindSignOutButton() {
        viewModel.signoutButtonTitle.bind(to: signoutButton.rx.title()).disposed(by: bag)

        signoutButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.signOut()
            })
            .disposed(by: bag)
    }
}
