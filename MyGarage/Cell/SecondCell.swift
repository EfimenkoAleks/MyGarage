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
    
    let cartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    var partName: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var lastPrice: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: 13)
        lb.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        lb.textColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        lb.layer.cornerRadius = 8
        lb.layer.masksToBounds = true
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstraints()
        self.clipsToBounds = true
    }
    
    func configure(with part: String) {
        partImageView.image = UIImage(named: part + ".jpg")
        lastPrice.text = "Last price = 140"
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
        addSubview(partName)
        addSubview(lastPrice)
        addSubview(cartButton)
       
        partImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        partImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        partImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        partImageView.widthAnchor.constraint(equalTo: partImageView.heightAnchor).isActive = true
        partImageView.layer.cornerRadius = self.bounds.size.height / 2
        
        lastPrice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        lastPrice.leadingAnchor.constraint(equalTo: partImageView.trailingAnchor, constant: 8).isActive = true
        lastPrice.trailingAnchor.constraint(equalTo: cartButton.leadingAnchor, constant: -12).isActive = true
        
        partName.bottomAnchor.constraint(equalTo: lastPrice.topAnchor, constant: -4).isActive = true
        partName.leadingAnchor.constraint(equalTo: lastPrice.leadingAnchor).isActive = true
        partName.trailingAnchor.constraint(equalTo: lastPrice.trailingAnchor).isActive = true
        
        cartButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cartButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4).isActive = true
        cartButton.widthAnchor.constraint(equalToConstant: self.bounds.size.width / 10).isActive = true
        cartButton.heightAnchor.constraint(equalToConstant: self.bounds.size.width / 10).isActive = true
        cartButton.layer.cornerRadius = self.bounds.size.width / 21
        
    }
}


