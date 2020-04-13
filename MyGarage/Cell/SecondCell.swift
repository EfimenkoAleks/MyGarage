//
//  SecondCell.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SecondCell: UICollectionViewCell {
        
        static var reuseId: String = "SecondCell"
        
        var partImageView: UIImageView = {
              let imageView = UIImageView()
              imageView.image = UIImage(named: "picture")
              imageView.translatesAutoresizingMaskIntoConstraints = false
              imageView.layer.cornerRadius = 8
              imageView.layer.masksToBounds = true
              imageView.contentMode = .scaleAspectFit
              imageView.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
              return imageView
          }()
          
          var partName: UILabel = {
              let lb = UILabel()
              lb.textAlignment = .center
              lb.font = UIFont.systemFont(ofSize: 12)
              lb.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
              lb.shadowColor = .purple
              let size = CGSize(width: 0, height: -1)
              lb.shadowOffset = size
              lb.layer.cornerRadius = 8
              lb.layer.masksToBounds = true
        //      lb.lineBreakMode = .byWordWrapping
              lb.numberOfLines = 0
              lb.translatesAutoresizingMaskIntoConstraints = false
              return lb
          }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
            setupConstraints()
            
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
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
    extension SecondCell {
        func setupConstraints() {
            
            addSubview(partImageView)
          // oponentImageView constraints
            partImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            partImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            partImageView.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
            partImageView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
            
            partImageView.addSubview(partName)
            // oponentLabel constraints
            partName.topAnchor.constraint(equalTo: partImageView.topAnchor, constant: 8).isActive = true
            partName.leadingAnchor.constraint(equalTo: partImageView.leadingAnchor, constant: 8).isActive = true
            partName.trailingAnchor.constraint(equalTo: partImageView.trailingAnchor, constant: -8).isActive = true
            
        }
    }


