//
//  BadgeView.swift
//  MyGarage
//
//  Created by user on 16.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class BadgeButtonItem: UIBarButtonItem {

    public func setBadge(with value: Int) {
        self.badgeValue = value
    }

    private var badgeValue: Int? {
        didSet {
            if let value = badgeValue,
                value > 0 {
                lblBadge.isHidden = false
                lblBadge.text = "\(value)"
//                print("\(String(describing: lblBadge.text))")
            } else {
                lblBadge.isHidden = true
            }
        }
    }
    
    private let button = UIButton()
    private let lblBadge = UILabel()
    
//    override init() {
//        super.init()
//        setup()
//    }

    init(with image: UIImage?, style: UIBarButtonItem.Style?, target: Any?, action: Selector?) {
        super.init()
       
        setup(image: image, style: style, target: target, action: action)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(image: UIImage? = nil, style: UIBarButtonItem.Style? = nil, target: Any? = nil, action: Selector? = nil) {

        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(image, for: .normal)

        self.lblBadge.frame = CGRect(x: 20, y: 20, width: 15, height: 15)
        self.lblBadge.backgroundColor = .red
        self.lblBadge.clipsToBounds = true
        self.lblBadge.layer.cornerRadius = 7
        self.lblBadge.textColor = UIColor.black
        self.lblBadge.font = UIFont.systemFont(ofSize: 10)
        self.lblBadge.textAlignment = .center
        self.lblBadge.isHidden = true
        self.lblBadge.minimumScaleFactor = 0.1
        self.lblBadge.adjustsFontSizeToFitWidth = true
        
        self.button.addSubview(self.lblBadge)
    
        if let action = action, let style = style {
            button.addTarget(target, action: action, for: .touchUpInside)
            self.style = style
        }
        self.setBadge(with: 0)
        self.customView = button
        
    }
    

}

