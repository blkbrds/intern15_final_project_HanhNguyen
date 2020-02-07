//
//  AppDelegate.swift
//  MyApp
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

let networkIndicator = NetworkActivityIndicatorManager.shared

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configNetwork()
        window = UIWindow(frame: UIScreen.main.bounds)
        createTabbar()
        window?.makeKeyAndVisible()
        return true
    }

    private func createTabbar() {

           let homeVC = HomeViewController()
           let homeNavi = UINavigationController(rootViewController: homeVC)
           homeNavi.tabBarItem = UITabBarItem(title: "Trang chủ", image: #imageLiteral(resourceName: "ic-home"), tag: 0)

           let popularVC = PopularViewController()
           let popularNavi = UINavigationController(rootViewController: popularVC)
           popularNavi.tabBarItem = UITabBarItem(title: "Thịnh hành", image: #imageLiteral(resourceName: "ic-popular"), tag: 1)

           let channelVC = ChannelViewController()
           let channelNavi = UINavigationController(rootViewController: channelVC)
           channelNavi.tabBarItem = UITabBarItem(title: "Kênh đăng ký", image: #imageLiteral(resourceName: "ic-channel"), tag: 2)

           let libraryVC = LibraryViewController()
           let libraryNavi = UINavigationController(rootViewController: libraryVC)
           libraryNavi.tabBarItem = UITabBarItem(title: "Thư viện", image: #imageLiteral(resourceName: "ic-library"), tag: 3)

           let tabbarController = UITabBarController()
           tabbarController.viewControllers = [homeNavi, popularNavi, channelNavi, libraryNavi]
           tabbarController.tabBar.tintColor = #colorLiteral(red: 0.9960784314, green: 0, blue: 0, alpha: 1)
           tabbarController.tabBar.barTintColor = .white

        window?.rootViewController = tabbarController
       }
}

extension AppDelegate {
    fileprivate func configNetwork() {
        networkIndicator.isEnabled = true
        networkIndicator.startDelay = 0
    }
}
