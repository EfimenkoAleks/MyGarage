//
//  CoreDataManager.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//
// https://habr.com/ru/post/436510/

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    static let sharedManager = CoreDataManager()
 
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyGarage")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    //MARK: Car
    
    func saveCar(image: Data, name: String, subName: String, number : String, bool: Bool, masiv: [[String]]?) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)!
        let car = NSManagedObject(entity: entity, insertInto: context)
        
        car.setValue(image, forKey: "image")
        car.setValue(name, forKeyPath: "name")
        car.setValue(subName, forKeyPath: "subName")
        car.setValue(number, forKey: "number")
        car.setValue(bool, forKey: "keySave")
        //       car.setValue(true, forKey: "keySave")
        if let masiv = masiv {
            for mas in masiv {
                self.updateCar(property: mas.first!, date: mas.last!, car: car as! Car)
            }
        }
        guard let user = currentUserConst else { return }
        let userSaved = self.fetchAllUser(userName: user.name! + user.password!)?.first
        userSaved?.addToSetCar(car as! Car)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
//    func insertCar(image: Data, name: String, subName: String, number : String) -> Car? {
//
//        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//        let entity = NSEntityDescription.entity(forEntityName: "Car", in: context)!
//
//        let car = NSManagedObject(entity: entity, insertInto: context)
//
//        car.setValue(image, forKey: "image")
//        car.setValue(name, forKeyPath: "name")
//        car.setValue(number, forKeyPath: "number")
//        car.setValue(subName, forKey: "subName")
//
//        do {
//            try context.save()
//            return car as? Car
//        } catch let error as NSError {
//            print("Could not save. \(error), \(error.userInfo)")
//            return nil
//        }
//    }
    
    func updateCar(name: Data?, subName: String?, number : String?, bool: Bool?, car : Car) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        if let bool = bool {
            car.setValue(bool, forKey: "keySave")
        }
        if let name = name {
            car.setValue(name, forKey: "name")
        }
        if let number = number {
            car.setValue(number, forKey: "number")
        }
        if let subName = subName {
            car.setValue(subName, forKey: "subName")
        }
            do {
                try context.save()
                print("UpdateCar saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
        
    }
    
    func updateCar(property: String, bool: Bool, car : Car) {
        
        car.setValue(bool, forKey: "keySave")
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CarDetail", in: context)!
        let carDetail = NSManagedObject(entity: entity, insertInto: context)
        
        carDetail.setValue(property, forKeyPath: "propertyCar")
        carDetail.setValue(HelperMethods.shared.curentDate(), forKeyPath: "dateOfBirth")
        
        car.addToCarDetail(carDetail as! CarDetail)
        
        do {
            try context.save()
            print("UpdateCar saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    private func updateCar(property: String, date: String, car : Car) {

        let context = CoreDataManager.sharedManager.persistentContainer.viewContext

        //let carDetail = self.saveCarDetail(property)

        let entity = NSEntityDescription.entity(forEntityName: "CarDetail", in: context)!

        let carDetail = NSManagedObject(entity: entity, insertInto: context)

        carDetail.setValue(property, forKeyPath: "propertyCar")
        carDetail.setValue(date, forKeyPath: "dateOfBirth")

        car.addToCarDetail(carDetail as! CarDetail)

        do {
            try context.save()
            print("UpdateCar saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {

        }

    }
    
    func deleteCar(_ car : Car){
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        guard let user = currentUserConst else { return }
        let userSaved = self.fetchAllUser(userName: user.name! + user.password!)?.first
        userSaved?.removeFromSetCar(car)
//            context.delete(car)
        do {
            try context.save()
        } catch {
        }
    }
    
    func fetchAllCars() -> [Car]?{
 
        guard let user = currentUserConst else { return nil }
        let userSaved = self.fetchAllUser(userName: user.name! + user.password!)?.first
        let arrayCar = userSaved?.setCar?.allObjects
       
        return arrayCar as? [Car]
    }
    
//    func delete(number: String) -> [Car]? {
//
//        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Car")
//
//        fetchRequest.predicate = NSPredicate(format: "name == %i" ,number)
//        do {
//
//            let item = try context.fetch(fetchRequest)
//            var removedCar = [Car]()
//            for i in item {
//                context.delete(i)
//                try context.save()
//                removedCar.append(i as! Car)
//            }
//            return removedCar
//
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//            return nil
//        }
//
//    }
//---------------------------------------------------------------------------
    //MARK: CarDetail
    
    func saveCarDetail(_ name: String) -> CarDetail {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CarDetail", in: context)!
        let carDetail = NSManagedObject(entity: entity, insertInto: context)
        
        carDetail.setValue(name, forKeyPath: "propertyCar")
        carDetail.setValue(HelperMethods.shared.curentDate(), forKeyPath: "dateOfBirth")
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return carDetail as! CarDetail
    }

    func deleteCarDetail(_ carDetail : CarDetail) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        context.delete(carDetail)
        do {
            try context.save()
        } catch {
        }
    }
    //-------------------------------------------------------------------------------------------

//MARK: Create user
    func createUserForPart() {
        guard let user = currentUserConst else { return }
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchAllUserParts = NSFetchRequest<NSManagedObject>(entityName: "UserChoicePart")
//        guard let fetch = fetchAllUserParts.propertiesToFetch else { return }
        
        if fetchAllUserParts.propertiesToFetch == nil {
            
            let entity = NSEntityDescription.entity(forEntityName: "UserChoicePart", in: context)!
            let userPart = NSManagedObject(entity: entity, insertInto: context)
            userPart.setValue(user.name! + user.password!, forKeyPath: "keyUser")
            
//            let userPart = UserChoicePart(context: managedContext)
//            userPart.keyUser = user.name! + user.password!
            
        } else {
            return
        }
            do {
                try context.save()
                
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
    }
// Fetch user
    private func fetchAllUser(userName: String) -> [UserChoicePart]?{
      
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let fetchAllUserParts = NSFetchRequest<NSManagedObject>(entityName: "UserChoicePart")
        fetchAllUserParts.predicate = NSPredicate(format: "SELF.keyUser = %@", userName)
        do {
            let userPart = try context.fetch(fetchAllUserParts)
            return userPart as? [UserChoicePart]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    //-------------------------------------------------------------------------------------------
    //MARK: ChoicePart
    
// По user мы возвращаем all ChoicePart
    func fetchAllChoicePart() -> [ChoicePart]? {
        
        guard let user = currentUserConst else { return nil}
        let userParts = self.fetchAllUser(userName: user.name! + user.password!)?.first
        if userParts?.setChoicePart?.allObjects != nil {
            return (userParts?.setChoicePart?.allObjects)! as? [ChoicePart]
        } else {
            return nil
        }
    }
// По user мы возвращаем all MasivChoicePart
    func fetchAllMasivChoicePart() -> [MasivChoiceParts]? {
        
        guard let user = currentUserConst else { return nil}
        let userMasivParts = self.fetchAllUser(userName: user.name! + user.password!)?.first
        if userMasivParts?.setMasivCP?.allObjects != nil {
            return (userMasivParts?.setMasivCP?.allObjects)! as? [MasivChoiceParts]
        } else {
            return nil
        }
    }
    
    func saveChoicePart(name: String, count: String, price: String?, seller: String) {
        
        guard let user = currentUserConst else { return }
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let userCP = self.fetchAllUser(userName: user.name! + user.password!)?.first
        let choicePart = ChoicePart(context: context)
        choicePart.name = name
        choicePart.count = count
        choicePart.seller = seller
        if let price = price {
            choicePart.price = price
        }
        userCP?.addToSetChoicePart(choicePart)
        do {
            try context.save()
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func updateChoisePart(count: String, price : String, seller: String, choicePart : ChoicePart) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        choicePart.count = count
        choicePart.seller = seller
        choicePart.price = price
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }

    func deleteChoisePart( _ choisePart : ChoicePart) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        guard let user = currentUserConst else { return }
        let userCP = self.fetchAllUser(userName: user.name! + user.password!)?.first
        userCP?.removeFromSetChoicePart(choisePart)
        context.delete(choisePart)
        do {
            try context.save()
        } catch {
        }
    }
    
    func deleteAllChoisePart() {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        guard let user = currentUserConst else { return }
        let userCP = self.fetchAllUser(userName: user.name! + user.password!)?.first
        var arrayCP = userCP?.setChoicePart?.allObjects
        arrayCP?.removeAll()
        let setCP = NSSet.init(array: arrayCP!)
        userCP?.setChoicePart = setCP
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //------------------------------------------------------------------------------------
    //MARK: MasivChoiceParts
    
    private func insertMasivChoiseParts() -> MasivChoiceParts? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MasivChoiceParts", in: context)!
        let masivChoiceParts = NSManagedObject(entity: entity, insertInto: context)
        let curentDate = HelperMethods.shared.curentDate()
//        print(HelperMethods.shared.dateFirstDay())
        masivChoiceParts.setValue(curentDate, forKeyPath: "dateCreation")
        masivChoiceParts.setValue(false, forKey: "expanded")
        
        do {
            try context.save()
            return masivChoiceParts as? MasivChoiceParts
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveMasivChoiseParts(masiv: [ChoicePart]) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let masivCP = CoreDataManager.sharedManager.insertMasivChoiseParts()
        for choicePart in masiv {

            let entity = NSEntityDescription.entity(forEntityName: "ForSaveChoicePart", in: context)!
            let forChoicePart = NSManagedObject(entity: entity, insertInto: context)
            forChoicePart.setValue(choicePart.name, forKeyPath: "name")
            forChoicePart.setValue(choicePart.count, forKeyPath: "count")
            forChoicePart.setValue(choicePart.price, forKey: "price")
            forChoicePart.setValue(choicePart.seller, forKey: "seller")

            masivCP?.addToForSaveCP(forChoicePart as! ForSaveChoicePart)
        }
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAllMasivChoiseParts() -> [MasivChoiceParts]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MasivChoiceParts")
        
        do {
            let allMasivChoiseParts = try context.fetch(fetchRequest)
            return allMasivChoiseParts as? [MasivChoiceParts]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func deleteMasivChoiseParts( _ masivChoisePart : MasivChoiceParts) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        guard let user = currentUserConst else { return }
        let userMasivPart = self.fetchAllUser(userName: user.name! + user.password!)?.first
        userMasivPart?.removeFromSetMasivCP(masivChoisePart)
 //       context.delete(masivChoisePart)
        do {
            try context.save()
        } catch {
        }
    }
    
    func deleteAllMasivChoiseParts() {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MasivChoiceParts")
        guard let user = currentUserConst else { return }
        let userMasivPart = self.fetchAllUser(userName: user.name! + user.password!)?.first
        guard let arrayMP =  userMasivPart?.setMasivCP?.allObjects else { return }
        var arrayMasivPart = arrayMP
        arrayMasivPart.removeAll()
        userMasivPart?.setMasivCP = NSSet(array: arrayMasivPart)
        
        do {
//            let masivChoiceParts = try context.fetch(fetchRequest)
//            for part in masivChoiceParts {
//                context.delete(part)
//            }
            try context.save()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
    
    //-----------------------------------------------------------------------------------
    
    //MARK: KeyForParse
    
    func saveKey(key: Int) {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "KeyForParse", in: context)!
//        let choicePart = NSManagedObject(entity: entity, insertInto: context)
//        choicePart.setValue(key, forKeyPath: "key")
        
        let keyPart = KeyForParse(context: context)
        keyPart.key = Int32(key)
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchKey() -> [KeyForParse]? {
        
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "KeyForParse")
        do {
            let allKeyForParse = try context.fetch(fetchRequest)
            return allKeyForParse as? [KeyForParse]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
}

