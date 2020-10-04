//
//  QuotesViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

final class QuotesViewController: RxViewController {
    private let viewModel: QuotesViewModelInterface
    
    init(with viewModel: QuotesViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }
}

private extension QuotesViewController {
    /* View */
    func setupView() {
        view.backgroundColor = .green
    }
    
    /* Rx Bindings */
    func setupRxBindings() {
        bindNavigationItems()
    }
    
    func bindNavigationItems() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }
}
