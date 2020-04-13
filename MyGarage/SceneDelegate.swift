//
//  SceneDelegate.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Parse

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
  
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        self.window = UIWindow(windowScene: windowScene)
//        let controller = RegistrViewController()
//        controller.delegate = self
//        let mainNavigationController = UINavigationController(rootViewController: controller)
//        self.window!.rootViewController = mainNavigationController
//        self.window!.makeKeyAndVisible()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
            window = UIWindow(frame: windowScene.coordinateSpace.bounds)
            window?.windowScene = windowScene
            window?.rootViewController = UINavigationController(rootViewController: RegistrViewController())
            window?.makeKeyAndVisible()
        
        
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = "FODcs5RdgIS5J8RhtZT1kZFBOzfMQvNXjeD33Rum"
            $0.clientKey = "957J22Fx53IAKSSOJiiVczlu9CvtCy7xNHnwFBxp"
            $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: parseConfig)
        
//      UITabBar.appearance().barTintColor = UIColor.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        
        CoreDataManager.sharedManager.saveContext()
        
     //   (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

//extension SceneDelegate: RootControllerDelegate {
//
//    func setRootController(controller: String) {
////        self.window?.rootViewController?.dismiss(animated: true, completion: nil)
//
//        switch controller {
//        case "RegistrViewController":
//            self.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            self.window?.rootViewController = MainTabBarController()
//            self.window!.makeKeyAndVisible()
//        case "CarViewController":
//            self.window = UIWindow(frame: UIScreen.main.bounds)
//            self.window?.rootViewController?.dismiss(animated: true, completion: nil)
//            let carController = RegistrViewController()
//            carController.delegate = self
//            self.window?.rootViewController = carController
//            self.window!.makeKeyAndVisible()
//        default:
//            let carController = RegistrViewController()
//            carController.delegate = self
//            self.window?.rootViewController = carController
//            self.window!.makeKeyAndVisible()
//        }
//    }
//}



extension SceneDelegate {
    static var shared = SceneDelegate()

    func setRootController(rootController: UIViewController) {
        let scene = UIApplication.shared.connectedScenes.first
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIApplication.shared.windows.first
        window!.windowScene = windowScene
        window!.rootViewController?.dismiss(animated: true, completion: nil)
        window!.rootViewController = rootController
        window!.makeKeyAndVisible()
    }
}


