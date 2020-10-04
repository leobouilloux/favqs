//
//  RouterImp.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public class RouterImp: NSObject, Router {
    private weak var rootController: NavigationController?
    private var completions: [UIViewController : () -> Void]

    public init(rootController: NavigationController) {
        self.rootController = rootController
        completions = [:]
    }

    public func toPresent() -> UIViewController? {
        return rootController
    }

    public func present(_ module: Presentable?) {
        present(module, animated: true)
    }

    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        rootController?.present(controller, animated: animated, completion: nil)
    }

    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }

    public func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }

    public func push(_ module: Presentable?) {
        push(module, animated: true)
    }

    public func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }

    public func push(_ module: Presentable?, animated: Bool, completion: (() -> Void)?) {
        guard
            let controller = module?.toPresent(),
            (controller is NavigationController == false)
            else { assertionFailure("Deprecated push NavigationController."); return }

        if let completion = completion {
            completions[controller] = completion
        }
        rootController?.pushViewController(controller, animated: animated)
    }

    public func popModule() {
        popModule(animated: true)
    }

    public func popModule(animated: Bool) {
        if let controller = rootController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }

    public func popModule(to type: UIViewController.Type) {
        guard let viewController = rootController?.viewControllers.last(where: { $0.nameOfClass == type.nameOfClass })
            else { return }

        rootController?.popToViewController(viewController, animated: true)

    }

    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, hideBar: false)
    }

    public func setRootModule(_ module: Presentable?, hideBar: Bool = false) {
        guard let controller = module?.toPresent() else { return }
        rootController?.setViewControllers([controller], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }

    public func popToRootModule(animated: Bool) {
        if let controllers = rootController?.popToRootViewController(animated: animated) {
            controllers.forEach { controller in
                runCompletion(for: controller)
            }
        }
    }

    private func replaceCurrent(with module: Presentable) {
        if var viewControllers = rootController?.viewControllers,
            let controller = module.toPresent() {
            viewControllers[viewControllers.count - 1] = controller
            rootController?.viewControllers = viewControllers
        }
    }

    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }

    public func presentOverFullScreen(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent(),
            let root = rootController?.topViewController
            else { return }
        controller.modalPresentationStyle = .overFullScreen
        getLastPresentedViewController(in: root).present(controller, animated: animated)
    }

    func getLastPresentedViewController(in viewController: UIViewController) -> UIViewController {
        if let presented = viewController.presentedViewController {
            return getLastPresentedViewController(in: presented)
        }
        return viewController
    }

    public func close() {
        close(animated: true)
    }

    public func close(animated: Bool) {
        guard let rootController = rootController else { return }

        if rootController.isModal {
            rootController.dismiss(animated: animated)
        } else {
            _ = rootController.popViewController(animated: animated)
        }
    }

    public func navigate(to module: Presentable, with type: PresentationType) {
        switch type {
        case .push: push(module)
        case .present: present(module)
        case .replaceCurrent: replaceCurrent(with: module)
        case .root: setRootModule(module)
        }
    }
}
