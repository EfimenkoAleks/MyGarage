//
//  TopOfferViewController.swift
//  MyGarage
//
//  Created by user on 25.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class TopOfferViewController: UIViewController {
    
    var topOfferTable: UITableView?
    
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 0
    
    let masivCategory = categoriParts
    let masivPart = partsNames
    var masivExtendedCurent = masivExtended
    let cellId = "TopOfferCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTable()
        topOfferTable?.register(TopCell.self, forCellReuseIdentifier: cellId)
        
//        navigationController?.navigationBar.prefersLargeTitles = true
        self.setupInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)

           NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)
//          self.delegate?.moveLine(tag: self.tagLine)
      }
    
    private func setupInit() {
        title = "Last price"
        
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        var i = self.masivCategory.count
        while i >= 0 {
            i = i - 1
            self.masivExtendedCurent.append(false)
        }
    }
    
    private func addTable() {
        topOfferTable = UITableView()
        topOfferTable!.dataSource = self
        topOfferTable!.delegate = self
        topOfferTable!.separatorStyle = .none
        topOfferTable!.backgroundColor = UIColor.clear
        topOfferTable?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topOfferTable!)
        
        topOfferTable?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        topOfferTable?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        topOfferTable?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        topOfferTable?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
}

extension TopOfferViewController: UITableViewDataSource, UITableViewDelegate, ExpandebleHeaderViewDelegate {
    
    //MARK: UICollectionViewDataSourse
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.masivCategory.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masivPart[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TopCell
        
        let masivPart = self.masivPart[indexPath.section]
        cell.nameLabel.text = masivPart[indexPath.row]
        
        if let part = HelperMethods.shared.findLastPrice(part: masivPart[indexPath.row]) {
//            cell.sellerLabel.text = part.seller
            cell.priceLabel.text = part.price
        } else {
//            cell.sellerLabel.text = ""
            cell.priceLabel.text = ""
        }
        cell.layer.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.masivExtendedCurent[indexPath.section] {
            return 44
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandebleHeaderView()
        header.setup(withTitle: self.masivCategory[section], section: section, delegate: self)
        return header
    }
    
    //MARK: toggleSection
    
    func toggleSection(header: ExpandebleHeaderView, section: Int) {
        self.masivExtendedCurent[section] = !self.masivExtendedCurent[section]
        
        topOfferTable!.beginUpdates()
        for row in 0..<self.masivPart[section].count {
            topOfferTable!.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
        }
        topOfferTable!.endUpdates()
        
    }
    
}
