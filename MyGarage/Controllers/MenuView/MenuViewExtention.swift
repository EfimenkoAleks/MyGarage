//
//  MenuViewExtention.swift
//  MyGarage
//
//  Created by user on 25.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

extension MenuViewTab {
    
    func createTable() -> UITableView {
        let tableView = UITableView()
        
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = UIColor.clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
//        tableView.refreshControl = UIRefreshControl()
        
        addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        return tableView
    }
    
//    func createBarItemPlus() -> UIBarButtonItem {
//
//        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
//        let imageMenu = UIImage(systemName: "plus", withConfiguration: scaleConfig)!
//        let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
//        let menu = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(CollectionView.addItem(_:)))
//        //        navigationItem.rightBarButtonItem = menu
//        return menu
//    }
}

//extension MenuViewTab: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.menus.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId, for: indexPath) as! MenuCell
//
//        cell.nameLabel.text = menus[indexPath.row]
//        return cell
//    }
//
//
//}

