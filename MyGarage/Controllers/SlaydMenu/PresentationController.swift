//
//  PresentationController.swift
//  MyGarage
//
//  Created by mac on 14.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class PresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let bounds = containerView!.bounds
//        let halfHeight = bounds.height / 2
//        return CGRect(x: 0,
//                             y: halfHeight,
//                             width: bounds.width,
//                             height: halfHeight)
        
        let halfWidth = bounds.width * 0.3
        return CGRect(x: 0,
                             y: 0,
                             width: bounds.width - halfWidth,
                             height: bounds.height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        containerView?.addSubview(presentedView!)
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
