//
//  SceneDelegate.swift
//  TestDemo
//
//  Created by mike liu on 2023/6/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // 創建一個新的 UIWindow 並賦予它 scene
        window = UIWindow(windowScene: windowScene)
        
        // 創建你的視圖控制器
        let viewController = SiteViewController()
        
        // 創建 UINavigationController，並把剛剛建立的 ViewController 當作 root view controller
        let navigationController = UINavigationController(rootViewController: viewController)
        
        // 設定 UIWindow 的 rootViewController 為 UINavigationController
        window?.rootViewController = navigationController
        
        // 使此窗口成為主窗口並顯示它
        window?.makeKeyAndVisible()
    }
    
//    private func navigationBarConfiguration (_ controller: UINavigationController) {
//        controller.navigationBar.prefersLargeTitles = true
//        controller.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        controller.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        controller.navigationBar.tintColor = .white
//        controller.navigationBar.backgroundColor = UIColor.systemBlue
//    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
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
    }


}

