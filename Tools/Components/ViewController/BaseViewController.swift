//
//  BaseViewController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxSwift
import UIKit

open class BaseViewController: UIViewController {
    public let snackBarController = SnackBarController()
    public let loaderController = LoaderController()

    private var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                showLoader()
            } else {
                hideLoader()
            }
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        snackBarController.setup(in: self)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }
}

public extension BaseViewController {
    // MARK: - Loader
    func showLoader(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.loaderController.modalPresentationStyle = .overFullScreen
            self.loaderController.modalTransitionStyle = .crossDissolve
            self.present(self.loaderController, animated: true, completion: completion)
        }
    }

    func hideLoader(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.loaderController.dismiss(animated: true, completion: completion)
        }
    }
}
