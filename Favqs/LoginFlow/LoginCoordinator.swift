//
//  LoginCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 05/10/2020.
//

import RxSwift

final class LoginCoordinator: BaseCoordinator {
    private let bag = DisposeBag()

    private let factory: LoginFactory
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    let output = LoginCoordinatorOutput()

    init(router: Router, factory: LoginFactory, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        setupRoot(presentationType: presentationType)
    }
}

/* Navigation */
private extension LoginCoordinator {
    func setupRoot(presentationType: PresentationType) {
        let viewModel = LoginViewModel(with: provider)
        viewModel.output.userDidConnect.bind(to: output.finishFlowAction).disposed(by: bag)

        let presentable = factory.makeLoginPresentable(with: viewModel)
        router.navigate(to: presentable, with: presentationType)
    }
}
