//
//  CarViewController.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import Parse


//class CarNavigationController: UINavigationController { }

class CarViewController: UIViewController {
    
    var carsTableView: UITableView?
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 2
    var cars = [Car]()

    let cellId = "CarCell"
    weak var delegate: RootControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTable()

        self.reloadMyTable()

        carsTableView?.register(CarTableViewCell.self, forCellReuseIdentifier: cellId)
  
        self.setupNavigationBar()

//        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.myviewTapped))
//                tapGesture.numberOfTapsRequired = 2
//                tapGesture.numberOfTouchesRequired = 1
//                viewTap.addGestureRecognizer(tapGesture)
//                viewTap.isUserInteractionEnabled = true

        NotificationCenter.default.addObserver(self, selector: #selector(CarViewController.refreshTable(notification:)), name: NSNotification.Name(rawValue: "refresh"), object: nil)
      
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.reloadMyTable()
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev2"), object: nil)
//        self.delegate?.moveLine(tag: self.tagLine)
    }
    
    @objc func backButton() {
           
           let sv = UIViewController.displaySpinner(onView: self.view)
           PFUser.logOutInBackground { (error: Error?) in
               UIViewController.removeSpinner(spinner: sv)
               if (error == nil){
                   SceneDelegate.shared.setRootController(rootController: UINavigationController(rootViewController: RegistrViewController()))
               }else{
                   if let descrip = error?.localizedDescription{
                       self.displayMessage(message: descrip)
                   }else{
                       self.displayMessage(message: "error logging out")
                   }
                   
               }
           }
       }
    
    func displayMessage(message:String) {
           let alertView = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
           let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
           }
           alertView.addAction(OKAction)
           if let presenter = alertView.popoverPresentationController {
               presenter.sourceView = self.view
               presenter.sourceRect = self.view.bounds
           }
           self.present(alertView, animated: true, completion:nil)
       }
    
    private func setupNavigationBar() {
        
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        
        //        let image = UIImage(named: "back")
        //        let imageTemp = image?.withRenderingMode(.alwaysTemplate)
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(CarViewController.backButton))
         
                let imageCar = UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
                let imageTempCar = imageCar?.withRenderingMode(.alwaysTemplate)
                let backButton = UIBarButtonItem(image: imageTempCar, style: .plain, target: self, action: #selector(CarViewController.backButton))
                navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
              
                //  настройки навигатион контролера
         //       navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //        navigationController?.navigationBar.shadowImage = UIImage()
        //        navigationController?.navigationBar.tintColor = .black
        //        navigationController?.navigationBar.barStyle = .black
        //        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        //        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                
                let imageView = UIImageView(image: UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(scale: .large)))
                imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
                let label = UILabel()
                label.text = "My car"
                label.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 22)
                label.textColor = .black
                
                let stackView = UIStackView(arrangedSubviews: [imageView, label])
                stackView.axis = .horizontal
                stackView.frame.size = CGSize(width: imageView.frame.size.width + label.frame.size.width, height: max(imageView.frame.size.height, label.frame.size.height))
                stackView.spacing = 20
                
                navigationItem.titleView = stackView
        
        let createButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .plain, target: self, action: #selector(setupBarButton))

          let internetButton = UIButton(type: .system)
          let image1 = UIImage(named: "internet")
          let imageTemp1 = image1?.withRenderingMode(.alwaysTemplate)
          internetButton.setImage(imageTemp1, for: .normal)
        //  internetButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
          internetButton.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)

          navigationItem.rightBarButtonItems = [createButton, UIBarButtonItem(customView: internetButton)]
          
        let imageLog = UIImage(named: "log-out")
               let imageTempLog = imageLog?.withRenderingMode(.alwaysTemplate)
               navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempLog, style: .plain, target: self, action: #selector(CarViewController.backButton))
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).withAlphaComponent(0.1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
                
         //       if #available(iOS 11.0, *) {
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        }
 //               title = "Cars"

           //     navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"carForBar")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(setupBarButton))
    }

//    @objc func backButton() {
//
//        currentUserConst = nil
//
//    let nextVC = RegistrViewController()
//    self.navigationController?.pushViewController(nextVC, animated: true)
//    self.navigationController?.dismiss(animated: true, completion: nil)
//    }

    private func addTable() {
        carsTableView = UITableView()
        carsTableView!.dataSource = self
        carsTableView!.delegate = self
        carsTableView!.separatorStyle = .none
        carsTableView!.backgroundColor = UIColor.clear
        carsTableView?.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(carsTableView!)

        carsTableView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        carsTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        carsTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        carsTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    @objc func refreshTable(notification: Notification) {

        print("Received Notification")
        self.reloadMyTable()
    }

    //MARK: SetapButton for left button

//    private func setButton() {
//        let button =  UIButton(type: .custom)
//        button.setImage(UIImage(named: "internet")?.withRenderingMode(.alwaysTemplate), for: .normal)
//        button.frame = CGRect(x: 0, y: 0, width: 80, height: 31)
//        button.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)
//        button.imageView?.contentMode = .scaleAspectFit
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton
//    }

    @objc func setupBarButton(){
        let alert1 = UIAlertController(title: "Name", message: "Enter name", preferredStyle: UIAlertController.Style.alert)

        alert1.addTextField { (textField) in
            textField.placeholder = "name"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "subname"
        }
        alert1.addTextField { (textField) in
            textField.placeholder = "number"
        }

        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { (action) in

            if let nameTextFild = alert1.textFields?[0].text, let subNameTextFild = alert1.textFields?[1].text, let numderTextFild = alert1.textFields?[2].text {
                if nameTextFild.count > 0 && subNameTextFild.count > 0 && numderTextFild.count > 0 {
                    CoreDataManager.sharedManager.saveCar(name: nameTextFild, subName: subNameTextFild, number: numderTextFild, bool: true, masiv: nil)

                self.reloadMyTable()
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)

        alert1.addAction(saveAction)
        alert1.addAction(cancelAction)
        present(alert1, animated: true, completion: nil)
    }

    //MARK: Set background for ViewController

    override func viewWillLayoutSubviews() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
    }

    //MARK: PopOverViewController for button

    @objc private func tapped() {

//        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopOverForCar") else {

        let popVC = PopOverForCar()
        popVC.modalPresentationStyle = .popover
        let popOverVC  = popVC.popoverPresentationController
            popOverVC?.delegate = self
        popOverVC?.sourceView = self.navigationItem.rightBarButtonItems?.last?.customView

        popOverVC?.sourceRect = CGRect(x: (self.navigationItem.rightBarButtonItems?.last?.customView?.bounds.midX)!, y: (self.navigationItem.rightBarButtonItems?.last?.customView?.bounds.maxY)!, width: 0, height: 0)

        popVC.preferredContentSize = CGSize(width: 200, height: 250)
//        popVC.hidesBottomBarWhenPushed = true
        self.present(popVC, animated: true)

 //       guard let popVC = storyboard?.instantiateInitialViewController() as? PopOverForCar else { return }
    }

//    private func updateLayout(with size: CGSize) {
//        self.carsTableView.frame = CGRect.init(origin: .zero, size: size)
//         HelperMethods.shared.setBackGround(view: self.view, tableView: self.carsTableView, size: size)
//        DispatchQueue.main.async {
//            self.carsTableView.reloadData()
//        }
//    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refresh"), object: nil)
        print("deinit CarVC")
    }

}

extension CarViewController: UITableViewDataSource, UITableViewDelegate {

    //MARK: UICollectionViewDataSourse

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! CarTableViewCell
        cell.nameLabel.text = cars[indexPath.row].name
        print(cars[indexPath.row].name ?? "name nil")
        cell.subNameLabel.text = cars[indexPath.row].subName
        print(cars[indexPath.row].subName ?? "subName nil")
        cell.numberLabel.text = cars[indexPath.row].number
        print(cars[indexPath.row].number ?? "number nil")

        cell.backgroundColor = indexPath.row%2 == 0 ? #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1) : #colorLiteral(red: 0.840382874, green: 0.9280859828, blue: 0.9567258954, alpha: 1)
        cell.layer.borderWidth = 1

        return cell
    }

    //MARK: UICollectionViewDelegate

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        CoreDataManager.sharedManager.delete(cars[indexPath.row])
        self.cars = CoreDataManager.sharedManager.fetchAllCars()!
        self.carsTableView!.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 48
//    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let car = self.cars[indexPath.row]
        let dictionary = ["name": car.name, "subName": car.subName, "number": car.number]
        UserDefaults.standard.set(dictionary, forKey: "kdictionaryCar")
        UserDefaults.standard.synchronize()

//        AppDelegate.shared.rootViewController.showCarDetail()
        
        let nextVC = CarDetailViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)

    //    performSegue(withIdentifier: "CarDetail", sender: car)
    }

    //MARK: Rotate Cell

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let degree: Double = 90
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 1, 0, 0)
        cell.layer.transform = rotationTransform

        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)

//        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
//        cell.layer.transform = translationTransform
//        UIView.animate(withDuration: 1, delay: 0.2 * Double(indexPath.row), options: .curveEaseInOut, animations: {
//            cell.layer.transform = CATransform3DIdentity
//        }, completion: nil)
    }

//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: { (contex) in
//            self.updateLayout(with: size)
//        }, completion: nil)
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "CarDetail" {
//            if let carDetail = segue.destination as? CarDetailViewController {
//                if let car = sender as? Car {
//                    carDetail.titleCar = car.number!
//                    carDetail.curentCar = car
//                }
//            }
//        }
//    }

    func reloadMyTable() {
        if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
            if carFetches.count > 0 {
                self.cars = carFetches
                self.carsTableView!.reloadData()
            }
        }
    }

//    @objc func myviewTapped(sender: UITapGestureRecognizer) {
//                guard sender.view != nil else { return }
//
//                    if sender.state == .ended {
//                       self.reloadMyTable()
//                }
//    }

}

extension CarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}
