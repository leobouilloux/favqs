//
//  AccountCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxSwift

final class AccountCoordinator: BaseCoordinator {
    private let factory: AccountFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    private let bag = DisposeBag()

    let output = AccountCoordinatorOutput()

    init(router: Router, factory: AccountFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType) {
        setupRoot(presentationType: presentationType)
    }
}

private extension AccountCoordinator {
    // *****************************************************************************
    // - MARK: Setup
    func setupRoot(presentationType: PresentationType) {
        let viewModel = AccountViewModel(with: provider)
        viewModel.output.userDidSignout.bind(to: output.userDidDisconnect).disposed(by: bag)
        let presentable = factory.makeAccountPresentable(with: viewModel)
        router.navigate(to: presentable, with: presentationType)
    }
}
