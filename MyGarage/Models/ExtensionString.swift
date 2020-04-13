//
//  ExtensionString.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension String {
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
//        label.textAlignment = .center
//        label.backgroundColor = .white
//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true
//        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}
