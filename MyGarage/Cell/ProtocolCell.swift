//
//  ProtocolCell.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with intValue: String)
}
