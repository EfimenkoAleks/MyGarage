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
    
    // Сохранить все авто на сервере
    func saveMyCar() {
        if let masivCars = CoreDataManager.sharedManager.fetchAllCars() {
            let cars = masivCars
            for curentCar in cars {
                if curentCar.keySave == true {
                    self.deleteCurentCar(curentCar: curentCar)
                }
            }
        }
    }
    
    // Сохранить текущее авто на сервере
    private func objectForSave(curentCar: Car) {
        
        let stringUser = currentUserConst!.name! + currentUserConst!.password!
        let car = PFObject(className: "MyCar")
        car["image"] = curentCar.image
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
    
    // Удалить текущее авто с сервера
    private func deleteCurentCar(curentCar: Car) {
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
                        }
                    }
                }
                self.objectForSave(curentCar: curentCar)
            }
        }
    }
    
    // Берём все авто с сервера
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
                            
                            CoreDataManager.sharedManager.saveCar(image: object.value(forKey: "image") as! Data, name: object.value(forKey: "name") as! String, subName: object.value(forKey: "subName") as! String, number: object.value(forKey: "number") as! String, bool: false, masiv: (object.value(forKey: "masiv") as! [[String]]))
                        }
                    }
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
                }
            }
        }
    }
    
    // Удаляем все авто с сервера
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
    
}
