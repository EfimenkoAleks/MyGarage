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
    
//    lazy var button: UIButton = {
//        let but = UIButton()
//        but.backgroundColor = .systemBackground
//        but.setImage(UIImage(systemName: "chevron.left", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
//        but.layer.cornerRadius = 8
//        but.layer.borderWidth = 1
//        but.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
//        but.addTarget(self, action: #selector(MenuViewController.closeDidPress), for: .touchUpInside)
//        but.translatesAutoresizingMaskIntoConstraints = false
//        return but
//    }()
    
    weak var delegate: MenuVCProtocol?
    private let transition = PanelTransition()
    var menuTableView: UITableView?
    let menus = ["Selected Parts", "Spare parts reports", "Last price", "Quit"]
    let icomMenus = ["cart", "archivebox", "dollarsign.square", "square.and.arrow.up"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.addTable()
        view.backgroundColor = .secondarySystemBackground
        self.view.alpha = 0.95
//        self.addButton()
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(MenuViewController.handleTap(_:)))
//        self.view.addGestureRecognizer(tap)
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(MenuViewController.handleSwipe(_:)))
        swipeLeftGesture.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeftGesture)
    }
    
//    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
//        print("tap working")
//        if gestureRecognizer.state == UIGestureRecognizer.State.recognized {
//            print(gestureRecognizer.location(in: gestureRecognizer.view))
//            self.dismiss(animated: true, completion: nil)
//       }
//    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {

        // example task: animate view off screen
//        let originalLocation = self.view.center
        
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
           self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func addTable() {
           menuTableView = UITableView()
           menuTableView!.dataSource = self
           menuTableView!.delegate = self
           menuTableView!.separatorStyle = .none
           menuTableView!.backgroundColor = UIColor.clear
           menuTableView?.translatesAutoresizingMaskIntoConstraints = false
        menuTableView?.isScrollEnabled = false

           view.addSubview(menuTableView!)

        menuTableView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
           menuTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
           menuTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
           menuTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        menuTableView?.register(MenuCell.self, forCellReuseIdentifier: MenuCell.reuseId)
       }
    
//    private func addButton() {
//        view.addSubview(button)
//        button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
//        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
//    }
    
//    @objc func closeDidPress(_ sender: Any) {
//
//        self.dismiss(animated: true, completion: nil)
//    }
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.reuseId) as! MenuCell
        
        cell.nameLabel.text = menus[indexPath.row]
        cell.iconButton.setImage(UIImage(systemName: self.icomMenus[indexPath.row]), for: .normal)
        
//        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let selected = menus[indexPath.row]
            delegate?.showController(name: selected)
            self.dismiss(animated: true, completion: nil)
        }
    
}
