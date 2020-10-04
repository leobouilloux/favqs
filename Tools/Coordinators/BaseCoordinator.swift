//
//  BaseCoordinator.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

open class BaseCoordinator: Coordinator {
    public var childCoordinators: [Coordinator] = []
    public let router: Router

    public init(router: Router) {
        self.router = router
    }

    open func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        if let option = option {
            childCoordinators.forEach { coordinator in
                coordinator.start(with: option, presentationType: presentationType)
            }
        }
    }
}
