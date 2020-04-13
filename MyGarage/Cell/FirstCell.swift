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
    
    var partImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(named: "picture")
          imageView.translatesAutoresizingMaskIntoConstraints = false
          imageView.layer.cornerRadius = 0
          imageView.layer.masksToBounds = true
          imageView.contentMode = .scaleAspectFit
          imageView.backgroundColor = .white
          return imageView
      }()
      
      var partName: UILabel = {
          let lb = UILabel()
          lb.textAlignment = .center
          lb.font = UIFont.systemFont(ofSize: 14)
        lb.backgroundColor = .clear
          lb.shadowColor = .purple
          let size = CGSize(width: 0, height: -1)
          lb.shadowOffset = size
          lb.layer.cornerRadius = 10
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
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.shadowRadius = 5
        self.layer.opacity = 1
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.clipsToBounds = false
    }
    
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
    
        addSubview(partImageView)
        
        // oponentImageView constraints
        partImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
        partImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        partImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        partImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        partImageView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        partImageView.layer.cornerRadius = self.frame.width / 2
  
        addSubview(partName)
        // oponentLabel constraints
        partName.topAnchor.constraint(equalTo: partImageView.bottomAnchor, constant: 8).isActive = true
        partName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        partName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
    }
}

