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
    lb.font = UIFont.systemFont(ofSize: 16)
    lb.textAlignment = .center
    lb.textColor = .black
    lb.backgroundColor = .clear
    lb.translatesAutoresizingMaskIntoConstraints = false
    return lb
}()
    
    let countLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()

let nameImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 12
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .clear
    return imageView
}()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let width = self.frame.width / 3
        
        addSubview(nameImage)
        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(priceLabel)

        nameImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        nameImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameImage.widthAnchor.constraint(equalToConstant: width).isActive = true
        nameImage.heightAnchor.constraint(equalToConstant: width).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: width / 3 - 5).isActive = true
        
        countLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor).isActive = true
 
        priceLabel.leadingAnchor.constraint(equalTo: nameImage.trailingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
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
        self.layer.cornerRadius = 12.0
        self.nameImage.layer.cornerRadius = 12.0

    }
    
}
