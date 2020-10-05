//
//  FavoritesCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxSwift

final class FavoritesCoordinator: BaseCoordinator {
    private let factory: FavoritesFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    private let bag = DisposeBag()

    init(router: Router, factory: FavoritesFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType) {
        setupRoot(presentationType: presentationType)
    }
}

private extension FavoritesCoordinator {
    // *****************************************************************************
    // - MARK: Setup
    func setupRoot(presentationType: PresentationType) {
        let viewModel = FavoritesViewModel(provider: provider)
        let presentable = factory.makeFavoritesPresentable(with: viewModel)

        router.navigate(to: presentable, with: presentationType)
    }
}
