//
//  PanelTransition.swift
//  MyGarage
//
//  Created by mac on 14.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
//    var presentationController: UIPresentationController?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented,
presenting: presenting ?? source)
}
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }

}
