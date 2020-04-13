//
//  SparePartReportDetailViewController.swift
//  MyGarage
//
//  Created by user on 25.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SparePartReportDetailViewController: UIViewController {
    
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 0
    
    var chart: PieChartView!
    var razdel = [String]()
    var podRazdel = [Double]()
    var masivChoisePart = [MasivChoiceParts]()
    
    var segment: UISegmentedControl = {
        let segm = UISegmentedControl()
        segm.backgroundColor = .red
        segm.selectedSegmentTintColor = .purple
        segm.tintColor = .green
        segm.translatesAutoresizingMaskIntoConstraints = false
        return segm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        chart = PieChartView(frame: self.view.bounds)
        self.view.addSubview(chart)
        
        if let masiv = CoreDataManager.sharedManager.fetchAllMasivChoiseParts() {
           self.masivChoisePart = masiv
        }
        self.setupSegment()
        self.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)
 //       self.delegate?.moveLine(tag: self.tagLine)
    }
    
    private func setupSegment() {
     
        // Initialize
        let items = ["Текущий месяц", "Прошлый месяц"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0

        // Set up Frame and SegmentedControl
        let frame = UIScreen.main.bounds
        customSC.frame = CGRect(x: frame.minX + 10, y: frame.minY + 100,
                                width: frame.width - 20, height: frame.height*0.05)

        // Style the Segmented Control
        customSC.layer.cornerRadius = 5.0  // Don't let background bleed
        customSC.backgroundColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        customSC.tintColor = .brown
        customSC.selectedSegmentTintColor = MySettings.shared.gcolorNavBar // #colorLiteral(red: 0.7571966052, green: 0.906237781, blue: 1, alpha: 1)
        

        // Add target action method
        customSC.addTarget(self, action: #selector(SparePartReportDetailViewController.changeMonth(sender:)), for: .valueChanged)

        // Add this custom Segmented Control to our view
        self.view.addSubview(customSC)
        
    }

    /**
      Handler for when custom Segmented Control changes and will change the
      background color of the view depending on the selection.
     */
    @objc func changeMonth(sender: UISegmentedControl) {
        razdel = ["Lena", "Vasia"]
        
        switch sender.selectedSegmentIndex {
        case 0:
            DispatchQueue.global(qos: .utility).async {
                
                self.podRazdel = self.calck()
                
                DispatchQueue.main.async {
                    if self.razdel.count > 0 && self.podRazdel.count > 0 {
                        self.updateChartData(razdel: self.razdel, podRazdel: self.podRazdel)
                    }
                }
            }
            
        default:
            var rezult = ""
            var arrayDouble = [Double]()
            
            if let selerL = UserDefaults.standard.object(forKey: "lastMonthForSellerLena") {
                rezult = selerL as! String
            } else { rezult = "10" }
            let tipDouble1 = NSString(string: rezult).doubleValue
            arrayDouble.append(tipDouble1)
            
            if let selerv = UserDefaults.standard.object(forKey: "lastMonthForSellerVasia") {
                rezult = selerv as! String
            } else { rezult = "10"}
            let tipDouble2 = NSString(string: rezult).doubleValue
            arrayDouble.append(tipDouble2)
            
            if self.razdel.count > 0 && self.podRazdel.count > 0 {
                self.updateChartData(razdel: self.razdel, podRazdel: arrayDouble)
            }
        }
    }
    
    private func setupInit() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
    }
    
    func fetchData() {
        razdel = ["Lena", "Vasia"]
        DispatchQueue.global(qos: .utility).async {

            self.podRazdel = self.calck()

            DispatchQueue.main.async {
                if self.razdel.count > 0 && self.podRazdel.count > 0 {
                    self.updateChartData(razdel: self.razdel, podRazdel: self.podRazdel)
                }
            }
        }
    }
    
    func updateChartData(razdel: [String], podRazdel: [Double]) {
   
        // generate chart data entries
        let razdel = razdel
        let podRazdel = podRazdel
        
        var entries = [PieChartDataEntry]()
        for (index, value) in podRazdel.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = razdel[index]
            entries.append(entry)
        }
        // chart setup
        let set = PieChartDataSet(entries: entries, label: "Расходы")
        var colors: [UIColor] = []
        for _ in 0..<podRazdel.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/256), green: CGFloat(green/256), blue: CGFloat(blue/256), alpha: 1)
            colors.append(color)
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = "iosCharts.io"
        chart.chartDescription = d
        chart.centerText = "Расходы"
        chart.holeRadiusPercent = 0.2
        chart.transparentCircleColor = UIColor.clear
   
    }
    
    private func calck() -> [Double] {

        var rezult = [Double]()
        var rez = ""
       
        rez = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "Lena")
        let tipDouble1 = NSString(string: rez).doubleValue
        rezult.append(tipDouble1)
        rez = HelperMethods.shared.countTheSellerForTheMonth(masiv: self.masivChoisePart, seller: "Vasia")
        let tipDouble2 = NSString(string: rez).doubleValue
        rezult.append(tipDouble2)
        
        return rezult
     }
    
}

//case 3:
//    if let selerL = UserDefaults.standard.object(forKey: "lastMonthForSellerLena") {
//        rezult = selerL as! String
//    } else { rezult = "0" }
//    break
//case 4:
//    if let selerv = UserDefaults.standard.object(forKey: "lastMonthForSellerVasia") {
//        rezult = selerv as! String
//    } else { rezult = "0"}
//    break
//case 5:
//    if let seler = UserDefaults.standard.object(forKey: "lastMonth") {
//        rezult = seler as! String
//    } else { rezult = "0"}
//    break
