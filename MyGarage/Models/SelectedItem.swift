//
//  SelectedItem.swift
//  MyGarage
//
//  Created by mac on 24.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import SwiftUI

struct SelectedItem: Identifiable {
    var id = UUID()
    var name: String
    var price: String
    var seller: String
    var count: String
}
