//
//  MainTabBarController.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

//https://uxplanet.org/20-ios-tab-bar-open-source-ui-animation-components-libraries-swift-objective-c-43c0039dff0d
// https://github.com/Ramotion/animated-tab-bar

import Foundation
import UIKit
import RAMAnimatedTabBarController

class MainTabBarController: RAMAnimatedTabBarController {
 
    lazy var lineView: UIView = {
        let view = UIView(frame: CGRect(x: gXPoint, y: 0, width: 130, height: 50))
        view.backgroundColor = UIColor.systemTeal.withAlphaComponent(0.3)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super .viewDidLoad()
    
        self.setupInit()
        self.tabBar.addSubview(lineView)
        self.addNotificationForTransition()
        
    }
    
    private func setupInit() {
               HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
                
                let backItem = UIBarButtonItem()
                backItem.title = "Main"
                navigationItem.backBarButtonItem = backItem
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.4330351949, blue: 0.631259501, alpha: 1)
        //        UITabBar.appearance().unselectedItemTintColor = #colorLiteral(red: 0, green: 0.5902375579, blue: 0.8606020808, alpha: 1).withAlphaComponent(0.7)

        //               // убираем верхний бордер:
        //        UITabBar.appearance().shadowImage = UIImage()
        //        UITabBar.appearance().backgroundImage = UIImage()

                       // как сделать бэкграунд синим?
        //        UITabBar.appearance().barTintColor = UIColor.systemPink // не работает
         //       UITabBar.appearance().backgroundImage = UIImage(color: #colorLiteral(red: 1, green: 0.9805611968, blue: 0.6677139401, alpha: 1).withAlphaComponent(0.2))
                
                let carsViewController = CarViewController()
        //        carsViewController.delegate = self
                let partsViewController = PartsViewController()
        //        partsViewController.delegate = self
                let qrViewController = QrCodeController()
        //        qrViewController.delegate = self
                
                // для подчеркивания в табБаре
                
        //        self.isBottomLineShow = true
        //        self.bottomLineHeight = 10
        //        self.bottomLineColor = .black
        //        self.selectedIndex = 1
                
                let boldConfig = UIImage.SymbolConfiguration(scale: .large)
                let carImage = UIImage(systemName: "car", withConfiguration: boldConfig)!
                let selCar = UIImage(systemName: "car.fill")!
         //       let imageInsetCar = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                let partImage = UIImage(named: "ingenir", in: nil, with: boldConfig)!
                let selPart = UIImage(named: "ingenir.fill")!
                let qrImage = UIImage(systemName: "qrcode.viewfinder", withConfiguration: boldConfig)!
                let selQr = UIImage(systemName: "viewfinder.circle.fill")!
                
                let partItem = RAMAnimatedTabBarItem(title: "Part", image: partImage, selectedImage: selPart)
                let qrItem = RAMAnimatedTabBarItem(title: "QrCode", image: qrImage, selectedImage: selQr)
                let carItem = RAMAnimatedTabBarItem(title: "Car", image: carImage, selectedImage: selCar)
                
                let animation = RAMRotationAnimation()
                animation.direction = .left
                partItem.animation = animation
                qrItem.animation = animation
                 carItem.animation = animation
                
                 partItem.bgDefaultColor = #colorLiteral(red: 0.9179650313, green: 0.9837188698, blue: 1, alpha: 1).withAlphaComponent(0.1)
                 qrItem.bgDefaultColor = #colorLiteral(red: 0.9179650313, green: 0.9837188698, blue: 1, alpha: 1).withAlphaComponent(0.1)
                carItem.bgDefaultColor = #colorLiteral(red: 0.9179650313, green: 0.9837188698, blue: 1, alpha: 1).withAlphaComponent(0.1)
                partItem.tag = 0
                qrItem.tag = 1
                carItem.tag = 2
        UITabBar.appearance().tintColor = #colorLiteral(red: 0, green: 0.4330351949, blue: 0.631259501, alpha: 1)
                UITabBar.appearance().barTintColor = #colorLiteral(red: 0.9179650313, green: 0.9837188698, blue: 1, alpha: 1).withAlphaComponent(0.5)

                viewControllers = [
                    generateNavigationController(rootViewController: partsViewController, item: partItem, tag: 0),
                    generateNavigationController(rootViewController: qrViewController, item: qrItem, tag: 1),
                    generateNavigationController(rootViewController: carsViewController, item: carItem, tag: 2)
                ]
            
    }
    
    private func addNotificationForTransition() {
        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.lineWiev0(notification:)), name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.lineWiev1(notification:)), name: NSNotification.Name(rawValue: "lineWiev1"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(MainTabBarController.lineWiev2(notification:)), name: NSNotification.Name(rawValue: "lineWiev2"), object: nil)
    }
    
    @objc func lineWiev0(notification: Notification) {

        let xFinish: CGFloat = 0
        self.animationSqueeze(xStart: gXPoint, xFinish: xFinish)
        gXPoint = xFinish
    }
    
    @objc func lineWiev1(notification: Notification) {
   
        let xFinish: CGFloat = 140
        self.animationSqueeze(xStart: gXPoint, xFinish: xFinish)
        gXPoint = xFinish
    }
    
    @objc func lineWiev2(notification: Notification) {
        
       let xFinish: CGFloat = 280
        self.animationSqueeze(xStart: gXPoint, xFinish: xFinish)
        gXPoint = xFinish
    }
    
    private func animationSqueeze(xStart: CGFloat, xFinish: CGFloat) {
        
//        let force: CGFloat = 1
        let translate = CGAffineTransform(translationX: xStart, y: 0)
        let scale = CGAffineTransform(scaleX: 1.5, y: 0)
        lineView.transform = translate.concatenating(scale)
        
        UIView.animate(withDuration: 1.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            
            let translate = CGAffineTransform(translationX: xFinish, y: 0)
            let scale = CGAffineTransform(scaleX: 1, y: 1)
            self.lineView.transform = translate.concatenating(scale)
            
        }, completion: nil)
    }
    
    private func generateNavigationController(rootViewController: UIViewController, item: RAMAnimatedTabBarItem, tag: Int) ->UIViewController {
    
            let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem = item
        navigationVC.tabBarItem.tag = tag
    
            return navigationVC
        }
    
    
//    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage, selectedImage: UIImage, tag: Int, inset: UIEdgeInsets) ->UIViewController {
//
//        let navigationVC = UINavigationController(rootViewController: rootViewController)
//        navigationVC.tabBarItem.title = title
//        navigationVC.tabBarItem.selectedImage = selectedImage
//        navigationVC.tabBarItem.image = image
//        navigationVC.tabBarItem.imageInsets = inset
//        navigationVC.tabBarItem.tag = tag
//
//        return navigationVC
//    }
    
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//
//        let force: CGFloat = 0.7
//            let scale = CGAffineTransform(scaleX: 2 * force, y: 2 * force)
////            fonImage.transform = scale
//
//
//            UIView.animate(withDuration: 1.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
//
//                let scale = CGAffineTransform(scaleX: 1, y: 1)
// //               self.fonImage.transform = scale
//
//            }, completion: nil)
//    }
    
//    private func selectedItem(item: UITabBarItem) {
//        for curItem in tabBar.items! {
//            curItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        }
//
//        if item.tag == 0 {
//        item.imageInsets = UIEdgeInsets(top: -8, left: 0, bottom: 8, right: 0)
//        print("\(item.tag)")
//        }
//
//
//    }
    
}

class RAMBounceAnimation : RAMItemAnimation {

    override func playAnimation(_ icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
        icon.tintColor = iconSelectedColor
    
    }

    override func deselectAnimation(_ icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor, defaultIconColor: UIColor) {
        textLabel.textColor = defaultTextColor
         icon.tintColor = defaultIconColor
    }

    override func selectedState(_ icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
        icon.tintColor = iconSelectedColor
    }

    func playBounceAnimation(_ icon : UIImageView) {

        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.2, 1.4, 1.2, 1.0, 0.8, 1.0]  //[1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(duration)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic

        icon.layer.add(bounceAnimation, forKey: "bounceAnimation")
    }
}


