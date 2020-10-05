//
//  AccountViewModel.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxCocoa
import RxRealm
import RxSwift

final class AccountViewModel: AccountViewModelInterface {
    private let provider: Provider

    let title = BehaviorRelay<String>(value: Loc.Account.title)

    let avatarImage = BehaviorRelay<UIImage>(value: Assets.Icons.personCropCircle)
    let login = BehaviorRelay<String>(value: "")
    let email = BehaviorRelay<String>(value: "")
    let followers = BehaviorRelay<String>(value: "")
    let following = BehaviorRelay<String>(value: "")
    let favoriteCount = BehaviorRelay<String>(value: "")
    let signoutButtonTitle = BehaviorRelay<String>(value: Loc.Account.signout)
    let isControllerActive = BehaviorRelay<Bool>(value: false)
    let errorMessage = PublishRelay<String>()

    let output = AccountOutput()

    private var dataBaseDisposable: Disposable?
    private let bag = DisposeBag()

    init(with provider: Provider) {
        self.provider = provider

        bindIsControllerActive()
    }

    func signOut() {
        provider.signOut { [weak self] result in
            switch result {
            case .success: self?.output.userDidSignout.accept(())
            case .failure: return
            }
        }
    }

    func bindIsControllerActive() {
        isControllerActive
            .subscribe(onNext: { [weak self] isControllerActive in
                if isControllerActive {
                    self?.watchDataBase()
                } else {
                    self?.dataBaseDisposable?.dispose()
                }
            })
            .disposed(by: bag)
    }

    func loadImage(from url: URLRequest) {
        URLSession.shared.rx
            .response(request: url)
            .subscribe(onNext: { [weak self] response in
                let image = UIImage(data: response.data) ?? Assets.Icons.personCropCircle
                self?.avatarImage.accept(image)
            })
            .disposed(by: bag)
    }

    private func watchDataBase() {
        guard let objects = provider.realmManager?.objects(User.self) else { return }

        dataBaseDisposable = Observable.array(from: objects)
            .subscribe(onNext: { [weak self] users in
                guard
                    let user = users.first,
                    let self = self
                    else { return }
                self.login.accept(user.login)
                self.favoriteCount.accept(Loc.Account.favoriteCount(p1: "\(user.publicFavoritesCount)"))
                self.followers.accept(Loc.Account.followersCount(p1: "\(user.followers)"))
                self.following.accept(Loc.Account.followingCount(p1: "\(user.following)"))
                if let url = URL(string: user.pictureURL) {
                    self.loadImage(from: URLRequest(url: url))
                }
            })
    }
}
