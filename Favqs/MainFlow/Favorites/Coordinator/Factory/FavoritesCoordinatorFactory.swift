//
//  FavoritesCoordinatorFactory.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

extension CoordinatorFactory {
    func makeFavoritesCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> FavoritesCoordinator {
        let coordinator = FavoritesCoordinator(router: router(navController),
                                               factory: FavoritesFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
