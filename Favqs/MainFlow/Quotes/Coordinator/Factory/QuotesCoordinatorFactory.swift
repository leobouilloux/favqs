//
//  QuotesCoordinatorFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

extension CoordinatorFactory {
    func makeQuotesCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> QuotesCoordinator {
        let coordinator = QuotesCoordinator(router: router(navController),
                                               factory: QuotesFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
