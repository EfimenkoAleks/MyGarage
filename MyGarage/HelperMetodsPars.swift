//
//  HelperMetodsPars.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Parse

class HelperMetodsPars {
    
    static let shared = HelperMetodsPars()
    
    func saveMyCar() {
        
        if let masivCars = CoreDataManager.sharedManager.fetchAllCars() {
            let cars = masivCars
//            let stringUser = currentUserConst!.name! + currentUserConst!.password!
            
            for curentCar in cars {
                if curentCar.keySave == true {
                    
                    self.delitCurentCar(curentCar: curentCar)
                    
                }
            }
        }
    }
    
    private func objectForSave(curentCar: Car) {
        
        let stringUser = currentUserConst!.name! + currentUserConst!.password!
        let car = PFObject(className: "MyCar")
        car["name"] = curentCar.name
        car["subName"] = curentCar.subName
        car["number"] = curentCar.number
        car["userKey"] = stringUser
        
        let masivCarDetail = curentCar.carDetail?.allObjects as! [CarDetail]
        var mas = [[String]]()
        for masiv in masivCarDetail {
            mas.append([masiv.propertyCar!, masiv.dateOfBirth!])
        }
        
        car["masiv"] = mas
        
        // Saves the new object.
        car.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
                print("Pars saved")
            } else {
                print("no saved")
                // There was a problem, check error.description
            }
        }
        CoreDataManager.sharedManager.updateCar(name: nil, subName: nil, number: nil, bool: false, car: curentCar)
    }
    
    private func delitCurentCar(curentCar: Car) {
        
//        var boolDelit = false
        let stringUser = currentUserConst!.name! + currentUserConst!.password!
        let query = PFQuery(className: "MyCar")
        query.whereKey("userKey", equalTo: stringUser)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let returnedobjects = objects {
                    for object in returnedobjects {
                        if (object.value(forKey: "name") as! String) == curentCar.name && (object.value(forKey: "subName") as! String) == curentCar.subName && (object.value(forKey: "number") as! String) == curentCar.number {
                            object.deleteInBackground()
                            print("object delete")
 //                           boolDelit = true
                            
//                            DispatchQueue.main.async {
//                                completion(boolDelit)
//                            }
 //                           self.objectForSave(curentCar: curentCar)
                        }
                    }
                }
                self.objectForSave(curentCar: curentCar)
            }
        }
//        DispatchQueue.main.async {
//            completion(boolDelit)
//        }
    }
    
//    func updateCar() {
//
//        if let masivCars = CoreDataManager.sharedManager.fetchAllCars() {
//            let cars = masivCars
//            let stringUser = currentUserConst!.name! + currentUserConst!.password!
//
//            for curentCar in cars {
//
//                if curentCar.keySave == true {
//
//                    let query = PFQuery(className:"MyCar")
//
//                    query.whereKey("userKey", equalTo: stringUser)
//                    query.findObjectsInBackground { (objects, error) in
//                        if error != nil {
//                            print("\(error ?? "nil error" as! Error)")
//                            if let returnedobjects = objects {
//
//                                for object in returnedobjects {
//
//                                    //                            for curentCar in cars {
//                                    //
//                                    //                                if curentCar.keySave == true {
//
//                                    if (object.value(forKey: "name") as! String) == curentCar.name && (object.value(forKey: "subName") as! String) == curentCar.subName && (object.value(forKey: "number") as! String) == curentCar.number {
//
//                                        let masivCarDetail = curentCar.carDetail?.allObjects as! [CarDetail]
//                                        var mas = [[String]]()
//                                        for masiv in masivCarDetail {
//                                            mas.append([masiv.propertyCar!, masiv.dateOfBirth!])
//                                        }
//                                        object.setValue(mas, forKey: "masiv")
//
//                                        object.saveInBackground {
//                                            (success: Bool, error: Error?) in
//                                            if (success) {
//                                                // The object has been saved.
//                                                CoreDataManager.sharedManager.updateCar(name: nil, subName: nil, number: nil, bool: false, car: curentCar)
//                                                print("Pars saved")
//                                            } else {
//
//                                                print("no saved")
//                                                // There was a problem, check error.description
//                                            }
//                                        }
//                                    }
//                                }
//
//                            }
//                        }
//                    }
//                }
//                self.saveMyCar(curentCar: curentCar, stringUser: stringUser)
//            }
//        }
//
//    }
    
    func fetchCar() {
        
        var masivCars = [Car]()
        if let masCars = CoreDataManager.sharedManager.fetchAllCars() {
            masivCars = masCars
        }
        
        let stringUser = currentUserConst!.name! + currentUserConst!.password!
        
        
        let query = PFQuery(className: "MyCar")
        query.whereKey("userKey", equalTo: stringUser)
        query.findObjectsInBackground { (objects, error) in
            
            if error == nil {
                // There was no error in the fetch
                if let returnedobjects = objects {
                    
                    for object in returnedobjects {
                        var carBool = true
                        if masivCars.count > 0 {
                            for car in masivCars {
                                if car.name == (object.value(forKey: "name") as! String) && car.subName == (object.value(forKey: "subName") as! String) && car.number == (object.value(forKey: "number") as! String) {
                                    carBool = false
                                    break
                                }
                            }
                        }
                        if carBool {
                            
                            CoreDataManager.sharedManager.saveCar(name: object.value(forKey: "name") as! String, subName: object.value(forKey: "subName") as! String, number: object.value(forKey: "number") as! String, bool: false, masiv: (object.value(forKey: "masiv") as! [[String]]))
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
                }
            }
        }
        //        }
    }
    
    func deleteCar() {
        
        let stringUser = currentUserConst!.name! + currentUserConst!.password!
        
        let query = PFQuery(className: "MyCar")
        query.whereKey("userKey", equalTo: stringUser)
        query.findObjectsInBackground { (objects, error) in
            if error == nil {
                if let returnedobjects = objects {
                    for object in returnedobjects {
                        object.deleteInBackground()
                        print("object delete")
                    }
                }
            }
        }
    }
    
    //    func fetchDetailCar(car: Car, tableView: UITableView) -> [CarDetail]? {
    //
    //        var masivCarStr = [CarDetail]()
    //        let query = PFQuery(className: "MyCar")
    //        query.findObjectsInBackground { (objects, error) in
    //            if error == nil {
    //                // There was no error in the fetch
    //                if let returnedobjects = objects {
    //                    for object in returnedobjects {
    //                        if object.value(forKey: "name") as? String == car.name && object.value(forKey: "subName") as? String == car.subName && object.value(forKey: "number") as? String == car.number {
    //                            if (object.value(forKey: "masiv") != nil) {
    //                                let masivs = object.value(forKey: "masiv") as! [[String]]
    //                                for carDetail in masivs {
    //                                    CoreDataManager.sharedManager.updateCar(property: carDetail[0], date: carDetail[1], car: car)
    //                                }
    //
    //                                if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
    //                                    for carFetch in carFetches {
    //                                        if carFetch.name == car.name, carFetch.subName == car.subName, carFetch.number == car.number {
    //                                            masivCarStr = carFetch.carDetail?.allObjects as! [CarDetail]
    //                                        }
    //                                    }
    ////                                if let detailCarFetches = car.carDetail?.allObjects {
    ////                                    masivCarStr = detailCarFetches as! [CarDetail]
    ////                                    tableView.reloadData()
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }
    //        return masivCarStr
    //    }
    
}
