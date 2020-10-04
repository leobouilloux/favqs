//
//  NavigationController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa
import RxSwift
import UIKit

public class NavigationController: UINavigationController {
    private let bag = DisposeBag()
    private let backButton = UIBarButtonItem(
        image: UIImage(systemName: "chevron.left"),
        style: .plain,
        target: nil,
        action: nil
    )
    private let closeButton = UIBarButtonItem(
        image: UIImage(systemName: "xmark"),
        style: .plain,
        target: nil,
        action: nil
    )
    public let loaderController = LoaderController()

    public let willDismissAction = PublishRelay<Void>()
    public let didDismissAction = PublishRelay<Void>()

    private var showCloseButton: Bool = true

    override public var viewControllers: [UIViewController] {
        didSet {
            if viewControllers.count == 1
                && presentingViewController != nil
                && showCloseButton
                && viewControllers.first?.navigationItem.leftBarButtonItem == nil {
                viewControllers.first?.navigationItem.leftBarButtonItem = closeButton
            }
        }
    }

    public init(rootViewController: UIViewController, showCloseButton: Bool = true) {
        self.showCloseButton = showCloseButton
        super.init(rootViewController: rootViewController)
    }

    public init(showCloseButton: Bool = true) {
        self.showCloseButton = showCloseButton
        super.init(rootViewController: UIViewController())
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupRxBindings()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if viewControllers.count == 1
            && presentingViewController != nil
            && showCloseButton
            && viewControllers.first?.navigationItem.leftBarButtonItem == nil {
            viewControllers.first?.navigationItem.leftBarButtonItem = closeButton
        }
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.isEmpty {
        } else {
            viewController.navigationItem.backBarButtonItem = nil
            viewController.navigationItem.leftBarButtonItem = backButton
        }

        super.pushViewController(viewController, animated: animated)
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count <= 1 {
            navigationItem.leftBarButtonItem = closeButton
        } else {
            navigationItem.leftBarButtonItem = backButton
        }
        return super.popViewController(animated: animated)
    }
}

private extension NavigationController {
    func setupView() {
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = closeButton
    }

    // *****************************************************************************
    // - MARK: Rx Bindings
    func setupRxBindings() {
        bindCloseButton()
        bindBackButton()
    }

    func bindBackButton() {
        backButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                if self.viewControllers.count > 1 {
                    _ = self.popViewController(animated: true)
                }
            })
            .disposed(by: bag)
    }

    func bindCloseButton() {
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.willDismissAction.accept(())
                self?.dismiss(animated: true, completion: { [weak self] in
                    self?.didDismissAction.accept(())
                })
            })
            .disposed(by: bag)
    }
}

public extension NavigationController {
    /******************************************************/
    // MARK: - Loader
    func showLoader(completion: (() -> Void)? = nil) {
        self.loaderController.modalPresentationStyle = .overFullScreen
        self.loaderController.modalTransitionStyle = .crossDissolve
        self.present(self.loaderController, animated: true, completion: completion)
    }

    func hideLoader(completion: (() -> Void)? = nil) {
        self.loaderController.dismiss(animated: true, completion: completion)
    }
}
