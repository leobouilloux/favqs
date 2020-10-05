//
//  TabBarCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa
import RxSwift
import UIKit

final class TabbarCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    let tabbarRouter: TabBarController

    let coordinatorFactory: CoordinatorFactory
    let provider: Provider
    let bag = DisposeBag()

    let output = TabBarCoordinatorOutput()

    init(tabbarController: TabBarController, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.tabbarRouter = tabbarController
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        self.setupChildCoordinators()
    }

    func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        if let option = option {
            switch option {
            default: break
            }
        }
        childCoordinators.forEach { $0.start(with: option, presentationType: presentationType) }
    }

    func setupChildCoordinators(with option: DeepLinkOption? = nil) {
        let quotesCoordinator = createQuotesFlow()
        let favoritesCoordinator = createFavoritesFlow()
        let accountCoordinator = createAccountFlow()

        childCoordinators = [
            quotesCoordinator,
            favoritesCoordinator,
            accountCoordinator
        ]

        tabbarRouter.viewControllers = [
            quotesCoordinator.router.toPresent() as? NavigationController ?? UIViewController(),
            favoritesCoordinator.router.toPresent() as? NavigationController ?? UIViewController(),
            accountCoordinator.router.toPresent() as? NavigationController ?? UIViewController()
        ]
    }

    func createQuotesFlow() -> QuotesCoordinator {
        let quotesCoordinator = coordinatorFactory.makeQuotesCoordinator(with: provider)
        quotesCoordinator.start(presentationType: .root)
        addDependency(quotesCoordinator)
        return quotesCoordinator
    }

    func createFavoritesFlow() -> FavoritesCoordinator {
        let favoritesCoordinator = coordinatorFactory.makeFavoritesCoordinator(with: provider)
        favoritesCoordinator.start(presentationType: .root)
        addDependency(favoritesCoordinator)
        return favoritesCoordinator
    }

    func createAccountFlow() -> AccountCoordinator {
        let accountCoordinator = coordinatorFactory.makeAccountCoordinator(with: provider)
        accountCoordinator.start(presentationType: .root)
        accountCoordinator.output.userDidDisconnect.bind(to: output.userDidDisconnect).disposed(by: bag)
        addDependency(accountCoordinator)
        return accountCoordinator
    }

}

// *****************************************************************************************************************
// MARK: - Helpers
extension TabbarCoordinator {
    var currentRouter: Router? {
        switch tabbarRouter.selectedIndex {
        case 0: return quotesRouter
        case 1: return favoritesRouter
        case 2: return accountRouter
        default: return nil
        }
    }

    var quotesRouter: Router? {
        return (childCoordinators[0] as? QuotesCoordinator)?.router
    }

    var favoritesRouter: Router? {
        return (childCoordinators[1] as? FavoritesCoordinator)?.router
    }

    var accountRouter: Router? {
        return (childCoordinators[2] as? AccountCoordinator)?.router
    }
}
