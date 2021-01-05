//
//  SelectedItemsTableViewCell.swift
//  MyGarage
//
//  Created by mac on 18.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SelectedItemsTableViewCell: UITableViewCell {

    let nameLabel: UILabel = {
    let lb = UILabel()
    //        tv.isEditable = false
    lb.font = UIFont.systemFont(ofSize: 17)
    lb.textAlignment = .left
    lb.textColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
    lb.backgroundColor = .clear
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
}()
    
    let countLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.text = "Count"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberCountLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.text = "Price"
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberPriceLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 14)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

let nameImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.layer.cornerRadius = 12
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .clear
    return imageView
}()
    
    let internetButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let width: CGFloat = self.bounds.size.width
        
        addSubview(nameImage)
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(numberCountLabel)
        addSubview(priceLabel)
        addSubview(numberPriceLabel)
        addSubview(internetButton)

        nameImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4).isActive = true
        nameImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameImage.widthAnchor.constraint(equalToConstant: width / 4).isActive = true
        nameImage.heightAnchor.constraint(equalToConstant: width / 4 + 10).isActive = true
        nameImage.layer.cornerRadius = width / 8
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: width / 10 * 3.5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 4).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: width / 7 * 5).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        countLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor, constant: 8).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: numberCountLabel.leadingAnchor, constant: -8).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -8).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: width / 6 * 2).isActive = true
        
        numberCountLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: -8).isActive = true
        numberCountLabel.bottomAnchor.constraint(equalTo: numberPriceLabel.topAnchor, constant: -8).isActive = true
        numberCountLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        numberCountLabel.widthAnchor.constraint(equalToConstant: width / 6 * 2).isActive = true
 
        priceLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor, constant: 8).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: numberPriceLabel.leadingAnchor, constant: -8).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: width / 6 * 2).isActive = true
        
        numberPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor,constant:  8).isActive = true
        numberPriceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        numberPriceLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
        numberPriceLabel.widthAnchor.constraint(equalTo: priceLabel.widthAnchor).isActive = true
        
        internetButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        internetButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        internetButton.widthAnchor.constraint(equalToConstant: width / 10).isActive = true
        internetButton.heightAnchor.constraint(equalToConstant: width / 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = .none
 //       self.layer.cornerRadius = 12.0
 //       self.nameImage.layer.cornerRadius = 12.0

    }
    
}
