//
//  MenuCell.swift
//  MyGarage
//
//  Created by user on 23.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class MenuCell: UITableViewCell {
    
    static var reuseId: String = "MenuCell"
       
        let nameLabel: UILabel = {
            let lb = UILabel()
            //        tv.isEditable = false
            lb.font = UIFont.systemFont(ofSize: 25)
            lb.textColor = .black
            lb.backgroundColor = .clear
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
    
    let iconButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "car"), for: .normal)
        btn.tintColor = .black
        btn.isUserInteractionEnabled = false
        //           btn.setTitle("Save", for: .normal)
        //          btn.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        //          btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //          btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        
        //           btn.addTarget(self, action: #selector(SelectedItemsViewController.forSavebutton), for: .touchUpInside)
        return btn
    }()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            
            self.setupConstraint()
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
                frame.origin.y += 20
                frame.size.height -= 2 * 6
                super.frame = frame
            }
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            self.selectionStyle = .none
            self.layer.cornerRadius = 10.0
//            self.backgroundColor = #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1)
            self.backgroundColor = .clear
           
        }
}

extension MenuCell {
    private func setupConstraint() {
        addSubview(iconButton)
        
          iconButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
          iconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
          iconButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
          iconButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(nameLabel)
        
        nameLabel.leadingAnchor.constraint(equalTo: iconButton.trailingAnchor, constant: 12).isActive = true
          nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
          nameLabel.widthAnchor.constraint(equalToConstant: self.frame.width / 3 * 2).isActive = true
          nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
}
