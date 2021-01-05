//
//  Protocols.swift
//  MyGarage
//
//  Created by mac on 10.03.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

protocol MenuVCProtocol: class {
    func showController(name: String)
}

protocol RootControllerDelegate: class {
    func setRootController(controller: String)
}

protocol SlideMenuDegate: class {
    func createMenu()
}

protocol PicerPhotoCarProtocol: class {
    func takePhoto()
    func reloadCarTable()
}
