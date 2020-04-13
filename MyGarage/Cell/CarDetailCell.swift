//
//  CarDetailCell.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CarDetailCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let dateLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 16)
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear // #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.5)
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let width = self.frame.width * 1.18
        addSubview(bubbleView)
        bubbleView.addSubview(nameLabel)
        bubbleView.addSubview(dateLabel)
        
        bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = false
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.widthAnchor.constraint(equalToConstant: width).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width * (3 / 5)).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: bubbleView.heightAnchor).isActive = true
        
        dateLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: 10).isActive = true
        dateLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        
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
            frame.size.height -= 2 * 2
            super.frame = frame
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        self.layer.cornerRadius = 10.0
        self.backgroundColor = #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1)
       
    }

}

