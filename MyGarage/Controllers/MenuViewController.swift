//
//  MenuViewController.swift
//  MyGarage
//
//  Created by mac on 14.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    
    lazy var button: UIButton = {
        let but = UIButton()
        but.backgroundColor = .systemBackground
        but.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        but.layer.cornerRadius = 8
        but.layer.borderWidth = 1
        but.layer.borderColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        but.addTarget(self, action: #selector(MenuViewController.closeDidPress), for: .touchUpInside)
        but.translatesAutoresizingMaskIntoConstraints = false
        return but
    }()
    
    weak var delegate: MenuVCProtocol?
    private let transition = PanelTransition()
    var menuTableView: UITableView?
    let menus = ["Selected Parts", "Spare parts reports", "Last price"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.addTable()
        view.backgroundColor = #colorLiteral(red: 0.7848287225, green: 0.9245255589, blue: 0.9792879224, alpha: 1)
        self.view.alpha = 0.8
        self.addButton()
    }
    
    private func addTable() {
           menuTableView = UITableView()
           menuTableView!.dataSource = self
           menuTableView!.delegate = self
           menuTableView!.separatorStyle = .none
           menuTableView!.backgroundColor = UIColor.clear
           menuTableView?.translatesAutoresizingMaskIntoConstraints = false

           view.addSubview(menuTableView!)

        menuTableView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
           menuTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
           menuTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
           menuTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        menuTableView?.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseId)
       }
    
    private func addButton() {
        view.addSubview(button)
        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    @objc func closeDidPress(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId) as! MenuCell
        
        cell.nameLabel.text = menus[indexPath.row]
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let selected = menus[indexPath.row]
   
        switch selected {
        case "Selected Parts":
            delegate?.showController(name: selected)
            self.dismiss(animated: true, completion: nil)
        case "Spare parts reports":
            delegate?.showController(name: selected)
            self.dismiss(animated: true, completion: nil)
        default:
            delegate?.showController(name: selected)
            self.dismiss(animated: true, completion: nil)
        }
        }
    
}
