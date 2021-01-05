//
//  MainTabBarController.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

// https://stackoverflow.com/questions/42367219/how-to-create-tabbar-with-custom-ui-in-swift-3-0
// https://github.com/eggswift/ESTabBarController

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        view.backgroundColor = .white
        
        let backItem = UIBarButtonItem()
        backItem.title = "Main"
        navigationItem.backBarButtonItem = backItem
//        navigationController?.navigationBar.prefersLargeTitles = true
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.4330351949, blue: 0.631259501, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0, green: 0.5902375579, blue: 0.8606020808, alpha: 1).withAlphaComponent(0.7)

        
//               // убираем верхний бордер:
//        UITabBar.appearance().shadowImage = UIImage()
//        UITabBar.appearance().backgroundImage = UIImage()

               // как сделать бэкграунд синим?
//        UITabBar.appearance().barTintColor = UIColor.blue // не работает
        UITabBar.appearance().backgroundImage = UIImage(color: #colorLiteral(red: 0.9665722251, green: 0.9766036868, blue: 0.9875525832, alpha: 1).withAlphaComponent(0.96))
       
        
        let carsViewController = CarViewController()
        let partsViewController = PartsViewController()
 
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let carImage = UIImage(systemName: "car", withConfiguration: boldConfig)!
        let partImage = UIImage(systemName: "cart", withConfiguration: boldConfig)!
    
        
        viewControllers = [
            generateNavigationController(rootViewController: partsViewController, title: "Parts", image: partImage),
            generateNavigationController(rootViewController: carsViewController, title: "Cars", image: carImage)
        ]
    
        self.delegate = self
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image:UIImage) ->UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        
        return navigationVC
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 0 {
            tabBar.items?.first?.selectedImage = UIImage(systemName: "cart.fill")
        } else {
            tabBar.items?.last?.selectedImage = UIImage(systemName: "car.fill")
        }
    }
}



