//
//  QuotesCoordinator.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//


import RxSwift

final class QuotesCoordinator: BaseCoordinator {
    private let factory: QuotesFactoryInterface
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    private let bag = DisposeBag()

    init(router: Router, factory: QuotesFactoryInterface, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType) {
        setupRoot(presentationType: presentationType)
    }
}

private extension QuotesCoordinator {
    // *****************************************************************************
    // - MARK: Setup
    func setupRoot(presentationType: PresentationType) {
        let viewModel = QuotesViewModel(provider: provider)
        let presentable = factory.makeQuotesPresentable(with: viewModel)
        
        router.navigate(to: presentable, with: presentationType)
    }
}
