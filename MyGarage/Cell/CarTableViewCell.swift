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
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textAlignment = .left
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let subNameLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textAlignment = .left
        lb.textColor = .black
        lb.backgroundColor = .clear
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let numberLabel: UILabel = {
        let lb = UILabel()
        //        tv.isEditable = false
        lb.font = UIFont.systemFont(ofSize: 15)
        lb.textAlignment = .left
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
    
    var carImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "picture")
           imageView.translatesAutoresizingMaskIntoConstraints = false
           imageView.layer.cornerRadius = 8
           imageView.layer.masksToBounds = true
           imageView.contentMode = .scaleAspectFit
           imageView.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
           return imageView
       }()
    
    var lineView: UIView = {
        let bg = UIView()
        bg.backgroundColor = .systemGray2
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.setupConstraints()
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
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }
    
}

extension CarTableViewCell {
    private func setupConstraints() {
        
        let width = self.bounds.width
        
        addSubview(carImageView)
        
        carImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        carImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        carImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        carImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        carImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
         addSubview(bubbleView)
         
        bubbleView.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 20).isActive = true
         bubbleView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
         bubbleView.heightAnchor.constraint(equalToConstant: 80).isActive = true
         bubbleView.widthAnchor.constraint(equalToConstant: width / 3 * 2).isActive = true
         
         bubbleView.addSubview(nameLabel)
         bubbleView.addSubview(subNameLabel)
         bubbleView.addSubview(numberLabel)
        
         nameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
         nameLabel.bottomAnchor.constraint(equalTo: subNameLabel.topAnchor, constant: -2).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
         nameLabel.heightAnchor.constraint(equalToConstant: 17).isActive = true
 
        subNameLabel.bottomAnchor.constraint(equalTo: numberLabel.topAnchor, constant: -2).isActive = true
         subNameLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
         subNameLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
         subNameLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
         
        numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6).isActive = true
         numberLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
         numberLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor).isActive = true
         numberLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor).isActive = true
        
        self.addSubview(lineView)
        lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: width * 2).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}
