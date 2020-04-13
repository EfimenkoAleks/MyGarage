//
//  SparePartsReportsViewController.swift
//  MyGarage
//
//  Created by user on 24.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SparePartsReportsViewController: UIViewController {
        
        var reportTableView: UITableView?
        
        var curentLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .right
            lb.textColor = .black
            lb.backgroundColor = .clear
            lb.text = "0"
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var vasiaLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .right
            lb.textColor = .black
            lb.backgroundColor = .clear
            lb.text = "0"
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var lenaLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .right
            lb.textColor = .black
            lb.backgroundColor = .clear
            lb.text = "0"
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var nameCurentLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .left
            lb.textColor = .black
            lb.text = "Curent"
            lb.backgroundColor = .clear
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var nameVasiaLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .left
            lb.textColor = .black
            lb.text = "Vasia"
            lb.backgroundColor = .clear
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var nameLenaLabel: UILabel = {
            let lb = UILabel()
            lb.font = UIFont.systemFont(ofSize: 18)
            lb.textAlignment = .left
            lb.textColor = .black
            lb.text = "Lena"
            lb.backgroundColor = .clear
            lb.translatesAutoresizingMaskIntoConstraints = false
            return lb
        }()
        
        var masivChoiceParts = [MasivChoiceParts]()
        let cellId = "SparePartReport"
    
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.addTable()
            reportTableView?.register(SparePartReportCell.self, forCellReuseIdentifier: cellId)
            
            self.setupInit()
            if let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
                self.masivChoiceParts = masivCP
                self.masivChoiceParts = self.masivChoiceParts.sorted(by: { (first: MasivChoiceParts, second: MasivChoiceParts) -> Bool in
                    first.dateCreation! > second.dateCreation! } )
            }
            
            self.reportTableView!.separatorStyle = .none
            self.setunNavBar()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)
//        self.delegate?.moveLine(tag: self.tagLine)
    }
    
    private func setupInit() {
         title = "Report"
//            navigationController?.navigationBar.prefersLargeTitles = true
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "diagrama"), style: .plain, target: self, action: #selector(SparePartsReportsViewController.buttonStatistika))
    }
   
        private func addTable() {
            
            reportTableView = UITableView()
            reportTableView!.dataSource = self
            reportTableView!.delegate = self
            reportTableView!.separatorStyle = .none
            reportTableView!.backgroundColor = UIColor.clear
            reportTableView?.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(reportTableView!)
            view.addSubview(vasiaLabel)
            view.addSubview(lenaLabel)
            view.addSubview(curentLabel)
            view.addSubview(nameVasiaLabel)
            view.addSubview(nameLenaLabel)
            view.addSubview(nameCurentLabel)
            
            reportTableView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            reportTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            reportTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            reportTableView?.bottomAnchor.constraint(equalTo: vasiaLabel.topAnchor).isActive = true
            
            vasiaLabel.leadingAnchor.constraint(equalTo: nameVasiaLabel.trailingAnchor).isActive = true
            vasiaLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
            vasiaLabel.topAnchor.constraint(equalTo: reportTableView!.bottomAnchor).isActive = true
            vasiaLabel.bottomAnchor.constraint(equalTo: lenaLabel.topAnchor).isActive = true
            vasiaLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            vasiaLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width / 2).isActive = true
            
            lenaLabel.leadingAnchor.constraint(equalTo: nameLenaLabel.trailingAnchor).isActive = true
            lenaLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
            lenaLabel.topAnchor.constraint(equalTo: vasiaLabel.bottomAnchor).isActive = true
            lenaLabel.bottomAnchor.constraint(equalTo: curentLabel.topAnchor).isActive = true
            lenaLabel.heightAnchor.constraint(equalTo: vasiaLabel.heightAnchor).isActive = true
            lenaLabel.widthAnchor.constraint(equalTo: vasiaLabel.widthAnchor).isActive = true
            
            curentLabel.leadingAnchor.constraint(equalTo: nameCurentLabel.trailingAnchor).isActive = true
            curentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
            curentLabel.topAnchor.constraint(equalTo: lenaLabel.bottomAnchor).isActive = true
            curentLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            curentLabel.heightAnchor.constraint(equalTo: vasiaLabel.heightAnchor).isActive = true
            curentLabel.widthAnchor.constraint(equalTo: vasiaLabel.widthAnchor).isActive = true
            
            nameVasiaLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
            nameVasiaLabel.trailingAnchor.constraint(equalTo: vasiaLabel.leadingAnchor).isActive = true
            nameVasiaLabel.topAnchor.constraint(equalTo: reportTableView!.bottomAnchor).isActive = true
            nameVasiaLabel.bottomAnchor.constraint(equalTo: nameLenaLabel.topAnchor).isActive = true
            nameVasiaLabel.heightAnchor.constraint(equalTo: vasiaLabel.heightAnchor).isActive = true
            
            nameLenaLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
            nameLenaLabel.trailingAnchor.constraint(equalTo: lenaLabel.leadingAnchor).isActive = true
            nameLenaLabel.topAnchor.constraint(equalTo: nameVasiaLabel.bottomAnchor).isActive = true
            nameLenaLabel.bottomAnchor.constraint(equalTo: nameCurentLabel.topAnchor).isActive = true
            nameLenaLabel.heightAnchor.constraint(equalTo: vasiaLabel.heightAnchor).isActive = true
            
            nameCurentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
            nameCurentLabel.trailingAnchor.constraint(equalTo: curentLabel.leadingAnchor).isActive = true
            nameCurentLabel.topAnchor.constraint(equalTo: nameLenaLabel.bottomAnchor).isActive = true
            nameCurentLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
            nameCurentLabel.heightAnchor.constraint(equalTo: vasiaLabel.heightAnchor).isActive = true
            
        }
        
        //MARK: addRightButtonItem
        
        @objc func buttonStatistika() {
         let nextVC = SparePartReportDetailViewController()
            navigationController?.pushViewController(nextVC, animated: true)
        }
        
        func setunNavBar() {
            // navigationController?.navigationBar.prefersLargeTitles = true
            let sc = UISearchController(searchResultsController: nil)
            navigationItem.searchController = sc
            // navigationItem.hidesSearchBarWhenScrolling = false
        }
        
    }

    extension SparePartsReportsViewController: UITableViewDataSource, UITableViewDelegate, ExpandebleHeaderViewDelegate {
        
        //MARK: UICollectionDataSourse
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return self.masivChoiceParts.count
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if let masivCP = self.masivChoiceParts[section].forSaveCP?.count {
                return masivCP
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SparePartReport") as! SparePartReportCell
            
            let masivMCP = self.masivChoiceParts[indexPath.section]
            let masiv = masivMCP.forSaveCP?.allObjects as! [ForSaveChoicePart]
            let choisePart = masiv[indexPath.row]
            
            
            cell.nameLabel.text = choisePart.name
            cell.countLabel.text = choisePart.count
            cell.priceLabel.text = choisePart.price
            cell.sellerLabel.text = choisePart.seller
            
            if choisePart.seller == "Vasia" {
                cell.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 0.3096639555)
            } else if choisePart.seller == "Lena" {
                cell.backgroundColor = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 0.1982020548)
            } else {
                cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            }
            
            return cell
        }
        
        //MARK: UICollectionDelegate
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 44
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if self.masivChoiceParts[indexPath.section].expanded {
                return 44
            }
            return 0
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 2
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let header = ExpandebleHeaderView()
            header.setup(withTitle: self.masivChoiceParts[section].dateCreation!, section: section, delegate: self)
            return header
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            CoreDataManager.sharedManager.deleteMasivChoiseParts(self.masivChoiceParts[indexPath.section])
            self.masivChoiceParts = CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!
            reportTableView!.reloadData()
        }
        
        //MARK: toggleSection
        //func for sliding sections
        
        func toggleSection(header: ExpandebleHeaderView, section: Int) {
            self.masivChoiceParts[section].expanded = !self.masivChoiceParts[section].expanded
            DispatchQueue.global(qos: .utility).async {
                let curentPartInGlobalQueue = HelperMethods.shared.calkulateCurentParts(parts: self.masivChoiceParts[section])
                DispatchQueue.main.async {
                    self.curentLabel.text = curentPartInGlobalQueue
                }
            }
            DispatchQueue.global(qos: .utility).async {
                let calkSellerL = HelperMethods.shared.calkulateSeller(part: self.masivChoiceParts[section], seller: "Lena")
                DispatchQueue.main.async {
                    self.lenaLabel.text = calkSellerL
                }
            }
            DispatchQueue.global(qos: .utility).async {
                let calkSellerV = HelperMethods.shared.calkulateSeller(part: self.masivChoiceParts[section], seller: "Vasia")
                DispatchQueue.main.async {
                    self.vasiaLabel.text = calkSellerV
                }
            }
            reportTableView!.beginUpdates()
            for row in 0..<(self.masivChoiceParts[section].forSaveCP?.count)! {
                reportTableView!.reloadRows(at: [IndexPath(row: row, section: section)], with: .automatic)
            }
            reportTableView!.endUpdates()
            
        }
    
    
}
