//
//  CoordinatorFactory.swift
// Favqs
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public class CoordinatorFactory {
    public init() {}

    public func router(_ navController: NavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }

    public func navigationController(_ navController: NavigationController?) -> NavigationController {
        return navController ?? NavigationController(rootViewController: UIViewController())
    }
}
