//
//  CarDetailViewController.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Parse

class CarDetailViewController: UIViewController {
    
    var detailCar: UITableView?
    let cellId = "CarDetailCell"
    
    var titleCar = "Repairs"
    var curentCar: Car?
    var masivCarStr = [CarDetail]()
    
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTable()
        detailCar?.register(CarDetailCell.self, forCellReuseIdentifier: cellId)
    
        self.setupInit()
       self.createCurentCar()
     
        if let masivCarS = curentCar!.carDetail?.allObjects {
            self.masivCarStr = masivCarS as! [CarDetail]
            self.sortArray()
        }

//        let imageBack = UIImage(named: "back")
//        let imageTempBack = imageBack?.withRenderingMode(.alwaysTemplate)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempBack, style: .plain, target: self, action: #selector(CarDetailViewController.backButton))
    }
    
      override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            self.detailCar!.reloadData()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev2"), object: nil)
    //        self.delegate?.moveLine(tag: self.tagLine)
        }
    
    private func setupInit() {
          HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        title = titleCar
               
               navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .plain, target: self, action: #selector(setupBarButton))
        navigationController?.navigationBar.shadowImage = UIImage()
               navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
    }
    
//    @objc func backButton() {
////        AppDelegate.shared.rootViewController.switchToCarScreen()
//    }
    
    func createCurentCar() {
        
        guard let dictionary = UserDefaults.standard.value(forKey: "kdictionaryCar") as? [String : String] else { return }
        
        let masivCar = CoreDataManager.sharedManager.fetchAllCars()
        for carInMas in masivCar! {
            if dictionary["name"] == carInMas.name && dictionary["subName"] == carInMas.subName && dictionary["number"] == carInMas.number {
                self.curentCar = carInMas
                break
            }
        }
  
    }
    
    
    private func addTable() {
        detailCar = UITableView()
        detailCar!.dataSource = self
        detailCar!.delegate = self
        detailCar!.separatorStyle = .none
        detailCar!.backgroundColor = UIColor.clear
        detailCar?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(detailCar!)
        
        detailCar?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        detailCar?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        detailCar?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        detailCar?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    //MARK: Func for left barbutton
    
    @objc func setupBarButton() {
        
        let alert = UIAlertController(title: "Свойство", message: "Введите свойство", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "name"
            
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in
            if let propertyTextFild = alert.textFields?[0].text {
                CoreDataManager.sharedManager.updateCar(property: propertyTextFild, bool: true, car: self.curentCar!)

//               let carDetail = CarDetail()
//                carDetail.propertyCar = propertyTextFild
//                carDetail.dateOfBirth = HelperMethods.shared.curentDate()
//                self.masivCarStr.append(carDetail)
                
//                if let detailCarFetches = self.curentCar.carDetail?.allObjects {
//                    self.masivCarStr = detailCarFetches as! [CarDetail]
//                }
            }
            if let cars = CoreDataManager.sharedManager.fetchAllCars() {
                for car in cars {
                    if car.name == self.curentCar!.name && car.subName == self.curentCar!.subName && car.number == self.curentCar!.number {
                        self.masivCarStr = car.carDetail?.allObjects as! [CarDetail]
                        
                      //  let addedDateString = "Tue, 25 May 2010 12:53:58 +0000"
                        
                        // Transform addedDateString to Date
                    //    let addedDateFormatter = DateFormatter()
                   //     addedDateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                        
//                        if let addedDate = addedDateFormatter.date(from: addedDateString) {
//                        }
                        self.sortArray()
                        DispatchQueue.main.async {
                            self.detailCar!.reloadData()
                        }
                    }
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func sortArray() {
        self.masivCarStr.sort(by: { (carDetail1, carDetail2) -> Bool in
            let addedDateFormatter = DateFormatter()
            addedDateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
            let addedDate1 = addedDateFormatter.date(from: carDetail1.dateOfBirth!)
            let addedDate2 = addedDateFormatter.date(from: carDetail2.dateOfBirth!)
            return addedDate1! > addedDate2!
        })
    }
    
}

extension CarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masivCarStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CarDetailCell
        
        cell.nameLabel.text = masivCarStr[indexPath.row].propertyCar
        cell.dateLabel.text = masivCarStr[indexPath.row].dateOfBirth
        cell.accessoryType = .detailButton
        cell.tintColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).withAlphaComponent(0.1)
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        CoreDataManager.sharedManager.deleteCarDetail(self.masivCarStr[indexPath.row])
        self.masivCarStr = curentCar!.carDetail?.allObjects as! [CarDetail]
        self.detailCar!.reloadData()
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: self.masivCarStr[indexPath.row].dateOfBirth, message: self.masivCarStr[indexPath.row].propertyCar, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
       
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    
}

