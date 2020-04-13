//
//  TopCell.swift
//  MyGarage
//
//  Created by user on 25.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class TopCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let lb = UILabel()
//        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .black
        lb.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .black
        lb.textAlignment = .center
        lb.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let separotor: UIView = {
        let sp = UIView()
        sp.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
        sp.translatesAutoresizingMaskIntoConstraints = false
        return sp
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
     
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(separotor)
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width - 10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
        separotor.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        separotor.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
       // separotor.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        separotor.widthAnchor.constraint(equalToConstant: self.frame.width + self.frame.width / 3).isActive = true
        separotor.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //Configure the view for the selected state
    }
    
   
}

//extension UIStackView {
//
//    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, pading: UIEdgeInsets = .zero) {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            topAnchor.constraint(equalTo: top, constant: pading.top).isActive = true
//        }
//        if let leading = leading {
//            leadingAnchor.constraint(equalTo: leading, constant: pading.left).isActive = true
//        }
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: pading.bottom).isActive = true
//        }
//        if let trailing = trailing {
//            trailingAnchor.constraint(equalTo: trailing, constant: pading.right).isActive = true
//        }
//    }
//
//}
//
//extension UILabel {
//    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, width: NSLayoutDimension?, pading: UIEdgeInsets = .zero, size: CGSize = .zero) {
//
//        translatesAutoresizingMaskIntoConstraints = false
//
//        if let top = top {
//            topAnchor.constraint(equalTo: top, constant: pading.top).isActive = true
//        }
//        if let leading = leading {
//            leadingAnchor.constraint(equalTo: leading, constant: pading.left).isActive = true
//        }
//        if let bottom = bottom {
//            bottomAnchor.constraint(equalTo: bottom, constant: pading.bottom).isActive = true
//        }
//        if let trailing = trailing {
//            trailingAnchor.constraint(equalTo: trailing, constant: pading.right).isActive = true
//        }
//
//        if let width = width {
//            widthAnchor.constraint(equalTo: width, multiplier: 1000, constant: size.width).isActive = true
//        }
//
//        if size.width != 0 {
//            widthAnchor.constraint(equalToConstant: size.width).isActive = true
//        }
//        if size.height != 0 {
//            heightAnchor.constraint(equalToConstant: size.height).isActive = true
//        }
//    }
//
//}
