//
//  TabBarController.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import RxCocoa
import RxSwift
import UIKit

final class TabBarController: UITabBarController, UITabBarControllerDelegate {
    private var didSetup = false
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        tabBar.isTranslucent = false

        setupRxBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !didSetup {
            setupItems()
            selectedIndex = 0
            didSetup = true
        }
    }
}

private extension TabBarController {
    func setupRxBindings() {
        bindTheme()
    }

    func bindTheme() {
//        themeService.rx
//            .bind({ $0.backgroundColor }, to: tabBar.rx.barTintColor)
//            .bind({ $0.textColor }, to: tabBar.rx.tintColor)
//            .disposed(by: bag)
    }

    func setupItems() {
        let bottomBarItems: [(image: UIImage, title: String)] = [
            (Assets.Icons.quoteBubbleFill, Loc.Quotes.title),
            (Assets.Icons.starFill, Loc.Favorites.title)
        ]

        let items = bottomBarItems.enumerated().map { index, item in
            UITabBarItem(title: item.title, image: item.image, tag: index)
        }

        guard let controllers = viewControllers else { return }

        zip(controllers, items).enumerated()
            .map { ($0, $1.0, $1.1) }
            .forEach { _, controller, item in
                controller.tabBarItem = item
        }
    }
}
