//
//  TabBarCoordinatorFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

final class TabbarCoordinatorFactory: TabbarCoordinatorFactoryInterface {
    func makeTabbarCoordinator(provider: Provider) -> TabbarCoordinator {
        let tabbarController = TabBarController()
        let coordinator = TabbarCoordinator(tabbarController: tabbarController,
                                            coordinatorFactory: CoordinatorFactory(),
                                            provider: provider)
        return coordinator
    }
}
