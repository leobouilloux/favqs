//
//  AppDelegate.swift
//  Favqs
//
//  Created by Leo Marcotte on 04/10/2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var applicationCoordinator: ApplicationCoordinator?

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            return true
        } else {
            let window = UIWindow(frame: UIScreen.main.bounds)
            let provider = NetworkProvider(apiKey: "5247f8e12299d74c8e81010ebff7861e")

            applicationCoordinator = ApplicationCoordinator(window: window,
                                                            coordinatorFactory: CoordinatorFactory(),
                                                            provider: provider)
            window.makeKeyAndVisible()
            applicationCoordinator?.start()
            self.window = window
            return true
        }
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
