//
//  FirstCell.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class FirstCell: UICollectionViewCell {
    
    static var reuseId: String = "FirstCell"
    
    var bgView: UIView = {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var partImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "picture")
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.layer.cornerRadius = 0
          imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
          imageView.contentMode = .scaleAspectFit
          imageView.backgroundColor = .white
          return imageView
      }()
      
      var partName: UILabel = {
          let lb = UILabel()
          lb.textAlignment = .center
          lb.font = UIFont.systemFont(ofSize: 12)
        lb.backgroundColor = .clear
//          lb.shadowColor = .purple
//          let size = CGSize(width: 0, height: -1)
//          lb.shadowOffset = size
          lb.layer.cornerRadius = 6
          lb.layer.masksToBounds = true
    //      lb.lineBreakMode = .byWordWrapping
          lb.numberOfLines = 1
          lb.translatesAutoresizingMaskIntoConstraints = false
          return lb
      }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupConstraints()
        
    }
    
//    override func layoutSubviews() {
//        self.layer.cornerRadius = self.frame.width / 2
//        self.layer.shadowRadius = 5
//        self.layer.opacity = 1
//        self.layer.shadowOffset = CGSize(width: 3, height: 3)
//        self.clipsToBounds = false
//    }
    
    func configure(with part: String) {
        partImageView.image = UIImage(named: part + ".jpg")
        partName.text = part
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Setup Constraints
extension FirstCell {
    func setupConstraints() {
        
        addSubview(bgView)
        
        // oponentImageView constraints
        //        partImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        bgView.heightAnchor.constraint(equalTo: bgView.widthAnchor).isActive = true
        bgView.layer.cornerRadius = self.frame.width / 2
        
        bgView.addSubview(partImageView)
        partImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        partImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        partImageView.widthAnchor.constraint(equalToConstant: self.frame.width - 2).isActive = true
        partImageView.heightAnchor.constraint(equalTo: partImageView.widthAnchor).isActive = true
        partImageView.layer.cornerRadius = self.frame.width / 2
        
        addSubview(partName)
        // oponentLabel constraints
        partName.topAnchor.constraint(equalTo: bgView.bottomAnchor, constant: 6).isActive = true
        partName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2).isActive = true
        partName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2).isActive = true
        
    }
}

