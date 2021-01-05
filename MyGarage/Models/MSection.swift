//
//  MSection.swift
//  MyGarage
//
//  Created by user on 06.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

struct MSection: Hashable {
    var type: String
    var title: String
    var items: [MPart]
}
