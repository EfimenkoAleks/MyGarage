//
//  SelectedItemsViewController.swift
//  MyGarage
//
//  Created by mac on 18.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit

class SelectedItemsViewController: UIViewController {
    
    var selectedItemsTableView: UITableView?
    
    var widthView: Int?
    
//    lazy var saveChoiceButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.tintColor = .black
//        button.setImage(UIImage(named: "saveButton")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        button.contentMode = .scaleAspectFit
//        button.addTarget(self, action: #selector(self.saveChoise(_:)), for: .touchUpInside)
//        return button
//    }()
    
    let viewShow2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 100
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.placeholder = "Name"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let countTextField2: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.placeholder = "Count"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let priceTextField2: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.placeholder = "Price"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var sellerTextField2: UITextField = {
        let tf = UITextField()
        tf.textAlignment = .center
        tf.placeholder = "Seller"
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 8
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let saveButton2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        btn.addTarget(self, action: #selector(SelectedItemsViewController.forSave2Button), for: .touchUpInside)
        return btn
    }()
    
    let cancelButton2: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 17)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        btn.addTarget(self, action: #selector(SelectedItemsViewController.forCancel2button), for: .touchUpInside)
        return btn
    }()
 
    var label2: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 25)
        lb.backgroundColor = .clear
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        lb.numberOfLines = 2
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
 
    var bubbleView2: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var choiceParts: [ChoicePart]!
    var isSaveble: Bool = false
    var myIndexPatch: IndexPath?
    
    private var stringPicker: UIPickerView?
    var pickerMasiv: [String]?
    var pickerLabel: UILabel?
    var blurEffectView: UIVisualEffectView?
    var boolForTab = true
    
    let cellId = "SelectedItemsCell"
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.addTable()
        self.selectedItemsTableView?.register(SelectedItemsTableViewCell.self, forCellReuseIdentifier: cellId)
        
        self.setupNavigationBarButton()
        self.setupInit()
        if let choicePartNoNill = CoreDataManager.sharedManager.fetchAllChoisePart() {
            self.choiceParts = choicePartNoNill
        }
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(SelectedItemsViewController.backButton))
    }
    
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        
        self.saveAndClearButton()
        self.selectedItemsTableView!.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)
        
      }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setToolbarHidden(true, animated: true)
        if boolForTab == false {
 //          tabBarController?.setTabBarVisible(visible: true, animated: true)
 //        navigationController!.toolBarHeight(visible: true, animated: true)
            
//            UIView.animate(withDuration: 0.2, animations: {
//
//                 self.tabBarController?.tabBar.isHidden = false
//                   }) { ( _ ) in
//                       self.tabBarController?.tabBar.alpha = 1
//            }
//           tabBarController?.tabBar.tabsVisiblti(true)
            boolForTab = true
        }
    }
    
    private func setupInit() {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        
        navigationItem.rightBarButtonItems?.first?.isEnabled = false
        navigationItem.rightBarButtonItems?.last?.isEnabled = false
        title = "Choice parts"
              
              self.selectedItemsTableView!.separatorStyle = .none
              
               self.pickerMasiv = ["Other", "Vasia", "Lena"]
        //       navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    @objc func backButton() {
//        AppDelegate.shared.rootViewController.switchToStartController()
//    }
    
    private func addTable() {
        selectedItemsTableView = UITableView()
        selectedItemsTableView!.dataSource = self
        selectedItemsTableView!.delegate = self
        selectedItemsTableView!.separatorStyle = .none
        selectedItemsTableView!.backgroundColor = UIColor.clear
        selectedItemsTableView!.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(selectedItemsTableView!)
//        view.addSubview(toolBar)
   //     view.addSubview(clearChoiceButton)
        
        selectedItemsTableView!.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        selectedItemsTableView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        selectedItemsTableView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        selectedItemsTableView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
//        let guide = self.view.safeAreaLayoutGuide
//        toolBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
//        toolBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
//        toolBar.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
//        toolBar.heightAnchor.constraint(equalToConstant: 44).isActive = true
 
    }
    
    private func setupNavigationBarButton() {
        
        let imageSave = UIImage(named: "save")
        let imageTemp = imageSave!.withRenderingMode(.alwaysTemplate)
        let save = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(SelectedItemsViewController.saveChoise(_:)))
        
        let imageTrash = UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        let imageTemp1 = imageTrash!.withRenderingMode(.alwaysTemplate)
        let trach = UIBarButtonItem(image: imageTemp1, style: .plain, target: self, action: #selector(SelectedItemsViewController.clearChoise(_:)))
        
        navigationItem.rightBarButtonItems = [trach, save]
        
    }
    
    @objc func forSave2Button() {
        
        if self.countTextField2.text!.count > 0 && self.priceTextField2.text!.count > 0 && self.sellerTextField2.text!.count > 0 {
            
            switch (self.sellerTextField2.text) {
                
            case "Vasia" :
                CoreDataManager.sharedManager.updateChoisePart(count: self.countTextField2.text!, price: self.priceTextField2.text!, seller: self.sellerTextField2.text!, choicePart: self.choiceParts![(myIndexPatch?.row)!])
                break
            case "Lena" :
                CoreDataManager.sharedManager.updateChoisePart(count: self.countTextField2.text!, price: self.priceTextField2.text!, seller: self.sellerTextField2.text!, choicePart: self.choiceParts![(myIndexPatch?.row)!])
                break
            default:
                let sellerTextField = "Other"
                CoreDataManager.sharedManager.updateChoisePart(count: self.countTextField2.text!, price: self.priceTextField2.text!, seller: sellerTextField, choicePart: self.choiceParts![(myIndexPatch?.row)!])
            }
            //                                }
            //                            }
        }
        if let choisePart = CoreDataManager.sharedManager.fetchAllChoisePart() {
            self.choiceParts = choisePart
            self.selectedItemsTableView!.reloadData()
        }
        self.saveAndClearButton()
        self.viewShow2.removeFromSuperview()
        
        self.countTextField2.text = ""
        self.priceTextField2.text = ""
        self.blurEffectView?.effect = nil
        self.blurEffectView?.removeFromSuperview()
    }
    
    @objc func forCancel2button() {
        self.viewShow2.removeFromSuperview()
        self.countTextField2.text = ""
        self.priceTextField2.text = ""
        self.blurEffectView?.effect = nil
        self.blurEffectView?.removeFromSuperview()
    }
    
    @objc func refreshTable(notification: Notification) {
        
        print("Received Notification")
      //  self.reloadMyTable()
    }
    
    private func saveAndClearButton() {
        
        if self.choiceParts.count > 0 {
            self.isSaveble = true
            navigationItem.rightBarButtonItems?.first?.isEnabled = true
            navigationItem.rightBarButtonItems?.last?.isEnabled = false
            DispatchQueue.global(qos: .utility).async {
                for part in self.choiceParts {
                    
                    if part.price == nil || part.count == nil {
                        self.isSaveble = false
                    }
                    if let price = part.price, let count = part.count {
                        if Int(price)! <= 0 && Int(count)! <= 0 {
                            self.isSaveble = false
                        }
                    }
                }
                DispatchQueue.main.async {
                    if self.isSaveble {
                        self.navigationItem.rightBarButtonItems?.last?.isEnabled = true
//                        self.toolBar.items?.first?.isEnabled = true
                    }
                }
            }
        }
        
    }
    
    @objc func saveChoise(_ sender: UIButton) {
        DispatchQueue.global(qos: .utility).async {
            CoreDataManager.sharedManager.saveMasivChoiseParts(masiv: self.choiceParts)
            
            DispatchQueue.main.async {
                CoreDataManager.sharedManager.deleteAllChoisePart()
                self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
                self.navigationItem.rightBarButtonItems?.first?.isEnabled = false
                self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
 //               self.toolBar.items?.first?.isEnabled = false
 //               self.toolBar.items?.last?.isEnabled = false
                self.isSaveble = false
                self.selectedItemsTableView!.reloadData()
            }
        }
    }
    
    @objc func clearChoise(_ sender: UIButton) {
        DispatchQueue.main.async {
            CoreDataManager.sharedManager.deleteAllChoisePart()
            self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
            self.navigationItem.rightBarButtonItems?.first?.isEnabled = false
            self.navigationItem.rightBarButtonItems?.last?.isEnabled = false
            self.isSaveble = false
            self.selectedItemsTableView!.reloadData()
        }
    }
    
    func codRusInEng(text: String) -> String {
            var str: String = ""
            for i in text {
                var dyct = gDyctionaryTranslate
                
                if let s = dyct.removeValue(forKey: i) {
                    str.append(s)
                } else {
                    str.append("_")
                }
                
    //            guard let st = dyct.removeValue(forKey: i) else { continue }
    //            str.append(st)
                    
                
            }
            return str
        }
}

extension SelectedItemsViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: UICollectionViewDataSourse
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choiceParts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! SelectedItemsTableViewCell
        
        cell.nameLabel.text = choiceParts[indexPath.row].name
        cell.countLabel.text = choiceParts[indexPath.row].count
        cell.priceLabel.text = choiceParts[indexPath.row].price
        if let image = choiceParts[indexPath.row].name {
            cell.nameImage.image = UIImage(named: image + ".jpg")
            if cell.nameImage.image == nil {
                cell.nameImage.image = UIImage(named: "picture")
                cell.nameImage.contentMode = .scaleAspectFit
            }
          
        }
        cell.accessoryType = .detailButton
        cell.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
  //      cell.accessoryView = UIImageView(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
       
        cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1) : #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1)
 //       cell.accessoryView = UIImageView(image: UIImage(systemName: "globe", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
    
        return cell
    }
    
    //MARK: UICollectionViewDelegate
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.sharedManager.deleteChoisePart(choiceParts[indexPath.row])
        self.choiceParts = CoreDataManager.sharedManager.fetchAllChoisePart()
        self.selectedItemsTableView!.reloadData()
        if self.choiceParts.count == 0 {
            navigationItem.rightBarButtonItems?.first?.isEnabled = false
            navigationItem.rightBarButtonItems?.last?.isEnabled = false
        }
        self.saveAndClearButton()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.changePart(indexPath)
        self.myIndexPatch = indexPath
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {

//        print("accessoryButtonTapped")
        let part = self.choiceParts[indexPath.row]
        let str = "https://www.google.com/search?q=" + "kupit_" + codRusInEng(text: part.name!.lowercased()) + "_gazel"
//        let str = "http://www.google.com/search?q=" + "купить_" + (part.name?.lowercased())! + "_газель"
        let nextVC = WebController(text: str)
        nextVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(nextVC, animated: true)
      
    }
    
    private func forPickerViewInstal() {
        self.stringPicker = UIPickerView()
        self.pickerLabel = UILabel()
        self.stringPicker?.dataSource = self
        self.stringPicker?.delegate = self
        self.stringPicker?.contentMode = .center
        
    }
    
    //MARK: changePart for user change
    
    func changePart( _ indexPath: IndexPath) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView!.frame = self.view.bounds
        self.blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(self.blurEffectView!)
 
        self.view.addSubview(self.viewShow2)
        
        viewShow2.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        viewShow2.topAnchor.constraint(equalTo: self.view.topAnchor,constant: self.view.frame.height * 0.2).isActive = true
        viewShow2.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true
        viewShow2.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        self.viewShow2.addSubview(bubbleView2)
        
        bubbleView2.trailingAnchor.constraint(equalTo: viewShow2.trailingAnchor, constant: -25).isActive = true
        bubbleView2.leadingAnchor.constraint(equalTo: viewShow2.leadingAnchor, constant: 25).isActive = false
        bubbleView2.topAnchor.constraint(equalTo: viewShow2.topAnchor,constant: 90).isActive = true
        bubbleView2.widthAnchor.constraint(equalTo: viewShow2.widthAnchor, constant: -50).isActive = true
        bubbleView2.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.bubbleView2.addSubview(self.countTextField2)
        self.bubbleView2.addSubview(self.priceTextField2)
        self.bubbleView2.addSubview(self.sellerTextField2)
        
        countTextField2.topAnchor.constraint(equalTo: bubbleView2.topAnchor).isActive = true
        countTextField2.leftAnchor.constraint(equalTo: bubbleView2.leftAnchor, constant: 0).isActive = true
        countTextField2.widthAnchor.constraint(equalTo: bubbleView2.widthAnchor).isActive = true
        countTextField2.heightAnchor.constraint(equalTo: bubbleView2.heightAnchor, multiplier: 1/3).isActive = true
        
        priceTextField2.topAnchor.constraint(equalTo: countTextField2.bottomAnchor).isActive = true
        priceTextField2.leftAnchor.constraint(equalTo: bubbleView2.leftAnchor, constant: 0).isActive = true
        priceTextField2.widthAnchor.constraint(equalTo: bubbleView2.widthAnchor).isActive = true
        priceTextField2.heightAnchor.constraint(equalTo: bubbleView2.heightAnchor, multiplier: 1/3).isActive = true
        
        sellerTextField2.topAnchor.constraint(equalTo: priceTextField2.bottomAnchor).isActive = true
        sellerTextField2.leftAnchor.constraint(equalTo: bubbleView2.leftAnchor, constant: 0).isActive = true
        sellerTextField2.widthAnchor.constraint(equalTo: bubbleView2.widthAnchor).isActive = true
        sellerTextField2.heightAnchor.constraint(equalTo: bubbleView2.heightAnchor, multiplier: 1/3).isActive = true
        
        self.viewShow2.addSubview(self.label2)
        self.viewShow2.addSubview(self.saveButton2)
        self.viewShow2.addSubview(self.cancelButton2)
        
        label2.topAnchor.constraint(equalTo: viewShow2.topAnchor, constant: 16).isActive = true
        label2.centerXAnchor.constraint(equalTo: viewShow2.centerXAnchor).isActive = true
        label2.widthAnchor.constraint(equalTo: viewShow2.widthAnchor, constant: -80).isActive = true
        
        cancelButton2.topAnchor.constraint(equalTo: bubbleView2.bottomAnchor).isActive = true
        cancelButton2.leadingAnchor.constraint(equalTo: viewShow2.leadingAnchor).isActive = true
        cancelButton2.trailingAnchor.constraint(equalTo: saveButton2.leadingAnchor).isActive = true
        cancelButton2.widthAnchor.constraint(equalToConstant: viewShow2.frame.width / 2).isActive = true
        cancelButton2.heightAnchor.constraint(equalTo: sellerTextField2.heightAnchor).isActive = true
        
        saveButton2.topAnchor.constraint(equalTo: bubbleView2.bottomAnchor).isActive = true
        saveButton2.leadingAnchor.constraint(equalTo: cancelButton2.trailingAnchor).isActive = true
        saveButton2.trailingAnchor.constraint(equalTo: viewShow2.trailingAnchor).isActive = true
        saveButton2.widthAnchor.constraint(equalTo: cancelButton2.widthAnchor).isActive = true
        saveButton2.heightAnchor.constraint(equalTo: sellerTextField2.heightAnchor).isActive = true
        
        self.label2.text = self.choiceParts![indexPath.row].name
        self.forPickerViewInstal()
        self.sellerTextField2.inputView = self.stringPicker
        self.sellerTextField2.text = ""
    }
    
    @objc func refreshPicker(notification: Notification) {

        guard let userInfo = notification.userInfo else { return }
        guard let text = userInfo["text"] as? String else { return }
        self.pickerLabel?.text = text

    }
    
}

extension SelectedItemsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerMasiv!.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerMasiv![row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.sellerTextField2.text = self.pickerMasiv![row]
        
    }
}
