//
//  AccountCoordinatorFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

extension CoordinatorFactory {
    func makeAccountCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> AccountCoordinator {
        let coordinator = AccountCoordinator(router: router(navController),
                                               factory: AccountFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
