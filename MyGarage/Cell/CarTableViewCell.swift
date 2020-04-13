//
//  CarTableViewCell.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
  //      lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let subNameLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
//        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 18)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let width = self.bounds.width * 1.2
        addSubview(bubbleView)
        
        bubbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = false
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleView.widthAnchor.constraint(equalToConstant: width).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        bubbleView.addSubview(nameLabel)
        bubbleView.addSubview(subNameLabel)
        bubbleView.addSubview(numberLabel)
       
        nameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: width / 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 28).isActive = true
        
        subNameLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        subNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        subNameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
        subNameLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        subNameLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        
        numberLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor).isActive = true
        numberLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor).isActive = true
        numberLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
        numberLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        
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
        
    }
    
}
