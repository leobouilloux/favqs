//
//  SplashScreenCoordinator.swift
// Favqs
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import RxSwift

final class SplashScreenCoordinator: BaseCoordinator {
    private let bag = DisposeBag()

    private let factory: SplashScreenFactory
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    let output = SplashScreenCoordinatorOutput()

    init(router: Router, factory: SplashScreenFactory, coordinatorFactory: CoordinatorFactory, provider: Provider) {
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
private extension SplashScreenCoordinator {
    func setupRoot(presentationType: PresentationType) {
        let viewModel = SplashScreenViewModel(with: provider)
        viewModel.output.didFinishLoading.bind(to: output.finishFlowAction).disposed(by: bag)

        let splashScreenPresentable = factory.makeSplashScreenPresentable(with: viewModel)
        router.navigate(to: splashScreenPresentable, with: presentationType)
    }
}
