//
//  SparePartReportCell.swift
//  MyGarage
//
//  Created by user on 25.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SparePartReportCell: UITableViewCell {

    let nameLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .left
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let countLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let priceLabel: UILabel = {
        let lb = UILabel()
//        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let sellerLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
 //       let width = self.frame.width + (self.frame.width / 4)

        addSubview(nameLabel)
        addSubview(countLabel)
        addSubview(priceLabel)
        addSubview(sellerLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor).isActive = true
        priceLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        countLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: sellerLabel.leadingAnchor).isActive = true
        countLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        countLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        sellerLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sellerLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor).isActive = true
        sellerLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sellerLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        sellerLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
