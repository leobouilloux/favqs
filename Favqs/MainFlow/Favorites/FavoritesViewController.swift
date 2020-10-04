//
//  FavoritesViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

final class FavoritesViewController: RxViewController {
    private let viewModel: FavoritesViewModelInterface
    
    init(with viewModel: FavoritesViewModelInterface) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }
}

private extension FavoritesViewController {
    /* View */
    func setupView() {
        view.backgroundColor = .blue
    }
    
    /* Rx Bindings */
    func setupRxBindings() {
        bindNavigationItems()
    }
    
    func bindNavigationItems() {
        viewModel.title.bind(to: navigationItem.rx.title).disposed(by: bag)
    }
}
