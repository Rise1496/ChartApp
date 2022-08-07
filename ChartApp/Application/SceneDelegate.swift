//
//  SceneDelegate.swift
//  ChartApp
//
//  Created by Nikita Yazikov on 06.08.2022.
//

import UIKit
import Core
import Moya

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    lazy var rootNavigationController: UINavigationController = {
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return navigationController
    }()
    
    private lazy var applicationCoordinator: Coordinatable = self.makeCoordinator()
    
    private func makeCoordinator() -> Coordinatable {
        return ApplicationCoordinator(
            router: Router(rootController: rootNavigationController),
            coordinatorFactory: CoordinatorFactory(),
            provider: MoyaProvider<APIProvider>()
        )
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else {
            return
        }
        applicationCoordinator.start()

    }
}

