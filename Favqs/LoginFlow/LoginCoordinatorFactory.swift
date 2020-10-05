//
//  LoginCoordinatorFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

extension CoordinatorFactory {
    func makeLoginCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> LoginCoordinator {
        let coordinator = LoginCoordinator(router: router(navController),
                                               factory: LoginFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
