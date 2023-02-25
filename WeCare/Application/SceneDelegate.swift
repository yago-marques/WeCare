//
//  SceneDelegate.swift
//  WeCare
//
//  Created by Yago Marques on 06/02/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let rootView = DailyTasksFactory.make()
        let navigation = UINavigationController(rootViewController: rootView)
        window.rootViewController = navigation
        window.makeKeyAndVisible()

        self.window = window
    }

}

