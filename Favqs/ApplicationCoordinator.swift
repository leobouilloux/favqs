//
//  ApplicationCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RealmSwift
import RxSwift

final class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    private let bag = DisposeBag()

    init(window: UIWindow, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.coordinatorFactory = coordinatorFactory
        self.window = window
        self.provider = provider
    }

    func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        if let option = option, !childCoordinators.isEmpty {
            switch option {
            default: childCoordinators.forEach { $0.start(with: option, presentationType: .root) }
            }
        } else {
            runSplashScreenFlow(presentationType: .root)
        }
    }

    private func runSplashScreenFlow(presentationType: PresentationType, option: DeepLinkOption? = nil) {
        let coordinator = coordinatorFactory.makeSplashScreenCoordinator(with: provider)
        coordinator.output.finishFlowAction
            .subscribe(onNext: { [weak self, weak coordinator] in
                
                if self?.provider.realmManager?.objects(UserSession.self).first != nil {
                    self?.runMainFlow(presentationType: .root)
                } else {
                    self?.runLoginFlow(presentationType: .root)
                }
                self?.removeDependency(coordinator)
            })
            .disposed(by: bag)

        addDependency(coordinator)
        coordinator.start(with: option)
//
        window.rootViewController = coordinator.router.toPresent()
    }

    private func runLoginFlow(presentationType: PresentationType, with option: DeepLinkOption? = nil) {
        let coordinator = coordinatorFactory.makeLoginCoordinator(with: provider)
        coordinator.output.finishFlowAction
            .subscribe(onNext: { [weak self, weak coordinator] in
                self?.runMainFlow(presentationType: .root)
                self?.removeDependency(coordinator)
            })
            .disposed(by: bag)

        addDependency(coordinator)
        coordinator.start(with: option, presentationType: presentationType)

        window.rootViewController = coordinator.router.toPresent()
    }

    private func runMainFlow(presentationType: PresentationType, with option: DeepLinkOption? = nil) {
        let coordinator = TabbarCoordinatorFactory().makeTabbarCoordinator(provider: provider)
        coordinator.output.userDidDisconnect
            .subscribe(onNext: { [weak self] in
                self?.provider.wipeData()
                self?.runLoginFlow(presentationType: .root)
                self?.removeDependency(coordinator)
            })
            .disposed(by: bag)
        addDependency(coordinator)
        coordinator.start(with: option, presentationType: presentationType)

        window.rootViewController = coordinator.tabbarRouter.toPresent()
    }
}
