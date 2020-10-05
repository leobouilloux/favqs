//
//  SceneDelegate.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScene)

        guard let window = window else { return }
        let provider = NetworkProvider(apiKey: "5247f8e12299d74c8e81010ebff7861e")
        applicationCoordinator = ApplicationCoordinator(window: window,
                                                        coordinatorFactory: CoordinatorFactory(),
                                                        provider: provider)
        applicationCoordinator?.start()
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
