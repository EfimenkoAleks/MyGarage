//
//  RootViewController.swift
//  MyGarage
//
//  Created by mac on 05.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    private var current: UIViewController
    
    static var shared = RootViewController()
    
    init() {
        current = UINavigationController(rootViewController: RegistrViewController())
        super.init(nibName:  nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    func showPartController() {
        
        let new = MainTabBarController()
        
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
         current.willMove(toParent: nil)
         addChild(new)
         transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
             
         }) { completed in
             self.current.removeFromParent()
             new.didMove(toParent: self)
             self.current = new
             completion?()
         }
     }
     
     private func animateDismissTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
         
         let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
         current.willMove(toParent: nil)
         addChild(new)
         new.view.frame = initialFrame
         
         transition(from: current, to: new, duration: 0.3, options: [], animations: {
             new.view.frame = self.view.bounds
         }) { completed in
             self.current.removeFromParent()
             new.didMove(toParent: self)
             self.current = new
             completion?()
         }
     }
}
