//
//  HelperMethods.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class HelperMethods {
    
    static let shared = HelperMethods()
    
    //    -------------------------------------------------------------------------------------
    //MARK: CoreDataManager
    
    func curentDate() -> String {
        
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm"
        let dateString = dateFormater.string(from: date)
        
        return dateString
    }
    
    //    -------------------------------------------------------------------------------------
    //MARK: SparePartsReportViewController
    
    func calkulateCurentParts(parts: MasivChoiceParts) -> String {
        var price = 0
        if let partCalk = parts.forSaveCP?.allObjects {
            for part in partCalk as! [ForSaveChoicePart] {
                if Int(part.price!)! != 0, Int(part.count!)! != 0 {
                    price += Int(part.price!)! * Int(part.count!)!
                }
            }
        }
        return price.description
    }
    
    func allMasivChoisePart(masiv: [MasivChoiceParts]) -> String {
        var priceAllParts = 0
        for part in masiv {
            priceAllParts += Int(self.calkulateCurentParts(parts: part))!
        }
        
        return priceAllParts.description
    }
    
    func calkulateSeller(part: MasivChoiceParts, seller: String) -> String {
        var price = 0
        if let partCalk = part.forSaveCP?.allObjects {
            for part in partCalk as! [ForSaveChoicePart] {
                if part.seller == seller {
                    if Int(part.price!)! != 0, Int(part.count!)! != 0 {
                    price += Int(part.price!)! * Int(part.count!)!
                    }
                }
            }
        }
        
        return price.description
    }
    
    func countTheSellerForTheMonth(masiv: [MasivChoiceParts], seller: String) -> String {
        var priceAllSeller = 0
        for masivCP in masiv {
            priceAllSeller += Int(self.calkulateSeller(part: masivCP, seller: seller))!
        }
        return priceAllSeller.description
    }
    
    //    -------------------------------------------------------------------------------------
    //MARK: CarViewController
    
    func saveFirstEnter() {
        
    }
    
    func curentMonthAndYear() -> (String, String) {
        let date = Date()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MM"
        let dateStringMonth = dateFormater.string(from: date)
        let dateFormater2 = DateFormatter()
        dateFormater2.dateFormat = "yyyy"
        let dateStringYear = dateFormater2.string(from: date)
        return (dateMonth: dateStringMonth, dateYear: dateStringYear)
    }
    
    func setFirstMonthAndYear() {
        let monthAndYear = self.curentMonthAndYear()
        let lastMonth = monthAndYear.0
        let lastYear = monthAndYear.1
        UserDefaults.standard.set(lastMonth, forKey: "kLastMonthDate")
        UserDefaults.standard.set(lastYear, forKey: "kLastYearDate")
        UserDefaults.standard.synchronize()
    }
    
    func newMonth(){
     
        if UserDefaults.standard.value(forKey: "kLastMonthDate") != nil {
            let now = self.curentMonthAndYear()
            let lastMonth = UserDefaults.standard.value(forKey: "kLastMonthDate") as! (String)
            let lastYear = UserDefaults.standard.value(forKey: "kLastYearDate") as! (String)
        switch now {
        case (let month, _) where Int(month)! > Int(lastMonth)! :
            self.forSwichMonthAndYear()
        case (let month, let year) where Int(month)! < Int(lastMonth)! && Int(year)! > Int(lastYear)! :
            self.forSwichMonthAndYear()
        default:
            return
        }
        
            
        }
    }
    
    func forSwichMonthAndYear() {
        let lastMonth1 = self.allMasivChoisePart(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!)
        UserDefaults.standard.set(lastMonth1, forKey: "lastMonth")
        UserDefaults.standard.synchronize()
        
        let lastMonthForSellerLena = self.countTheSellerForTheMonth(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!, seller: "Lena")
        UserDefaults.standard.set(lastMonthForSellerLena, forKey: "lastMonthForSellerLena")
        UserDefaults.standard.synchronize()
        
        let lastMonthForSellerVasia = self.countTheSellerForTheMonth(masiv: CoreDataManager.sharedManager.fetchAllMasivChoiseParts()!, seller: "Vasia")
        UserDefaults.standard.set(lastMonthForSellerVasia, forKey: "lastMonthForSellerVasia")
        UserDefaults.standard.synchronize()
        
        CoreDataManager.sharedManager.deleteAllMasivChoiseParts()
        
        self.setFirstMonthAndYear()
    }
    
    //------------------------------------------------------
    
    // создание даты для component collection
    func createMSection(numberItem: Int) -> [MSection] {
        let mSection1 = MSection(type: "CategoriParts", title: "CategoriParts", items: categoriParts)
        let mSection2 = MSection(type: "Parts", title: "Parts", items: partsNames[numberItem])
        var array = [MSection]()

//        mSection1.items = categoriParts
//        mSection1.type = "CategoriParts"
//        mSection1.title = "CategoriParts"
        array.append(mSection1)
        
//        mSection2.items = partsNames[numberItem]
//        mSection2.type = "Parts"
//        mSection2.title = "Parts"
        array.append(mSection2)

        return array
    }
    
    func findLastPrice(part: String) -> ForSaveChoicePart? {
        
        var masivSave = [ForSaveChoicePart]()
        
        let masivCP = CoreDataManager.sharedManager.fetchAllMasivChoiseParts()
        for masiv in masivCP! {
            let mas = (masiv.forSaveCP?.allObjects)! as! [ForSaveChoicePart]
            for choiceP in mas {
                if choiceP.name == part {
                    
                    masivSave.append(choiceP)
                }
            }
        }
        return masivSave.last
    }
    
    //MARK: PopOverForCar
    
    func createAlert(title: String, message: String, number: Int, controller: UIViewController) -> UIAlertController {
        
        let alert1 = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default) { (action) in
            switch number {
            case 0:
                HelperMetodsPars.shared.fetchCar()
                break
            case 1:
                HelperMetodsPars.shared.saveMyCar()
                break
            case 2:
                HelperMetodsPars.shared.deleteCar()
                break
            default:
                print("error")
            }
            
            controller.dismiss(animated: true, completion: nil)
            
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel) { (cancel) in
            controller.dismiss(animated: true, completion: nil)
        }
        
        alert1.addAction(okAction)
        alert1.addAction(cancelAction)
        
        return alert1
    }
    
    //MARK: SetBackGround
    
//    func setBackGround(view: UIView) {
//
//        let color1 = UIColor.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 1).cgColor
//        let color2 = UIColor.init(red: 0.998, green: 1, blue: 1, alpha: 1).cgColor
//        let color3 = UIColor.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 1).cgColor
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = view.frame
//        gradientLayer.colors = [color1, color2, color3]
//        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
//        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
//        view.layer.insertSublayer(gradientLayer, at: 0)
//
//       // let collor1 = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//    }
    
    func setBackGround(view: UIView, color1: UIColor, color2: UIColor, color3: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor, color3.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
//    func createLabel(text: String, cellWidth: CGFloat) -> UILabel {
//
//        let label = UILabel()
//        label.font = UIFont(name: "Arial-BoldMT", size: 16)
//        label.text = text
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.textColor = UIColor.black
//        label.backgroundColor = UIColor.white
//        //cell.addSubview(label)
//
//        let maxSize = CGSize(width: cellWidth, height: 20)
//        var size = label.sizeThatFits(maxSize)
//        if size.width > cellWidth || size.width > cellWidth - 20 {
//            size.width = cellWidth - 20
//        }
//
//        label.frame = CGRect(origin: CGPoint(x: 10, y: 0), size: size)
//
//        return label
//    }
    
    func delay(_ delay: Double, closure: @escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
