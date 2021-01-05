//
//  MenuView.swift
//  MyGarage
//
//  Created by user on 25.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class MenuViewTab: UIView {
    
    lazy var table = createTable()
    let menus = ["Selected Parts", "Spare parts reports", "Last price"]

    override func layoutSubviews() {
        super.layoutSubviews()
        self.table.isHidden = false
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.table.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

        self.table.backgroundColor = .clear

    }
}
