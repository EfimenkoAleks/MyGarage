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
import SwiftEntryKit

class CarViewController: UIViewController, PicerPhotoCarProtocol, UINavigationControllerDelegate {
    
    var carsTableView: UITableView?
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 2
    var cars = [Car]()

    let cellId = "CarCell"
    weak var delegate: RootControllerDelegate?
    var nameView: AlertForAddCar?
    
    lazy var imagePicker = ImagePicker()
    private weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addTable()
        self.reloadCarTable()
        carsTableView?.register(CarTableViewCell.self, forCellReuseIdentifier: cellId)
        self.setupNavigationBar()
        imagePicker.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(CarViewController.refreshTable(notification:)), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.reloadCarTable()
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev2"), object: nil)
//        self.delegate?.moveLine(tag: self.tagLine)
    }
    
// MARK: для pickerView
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        imagePicker.present(parent: self, sourceType: sourceType)
    }

    func photoButtonTapped() { imagePicker.photoGalleryAsscessRequest() }
    func cameraButtonTapped() { imagePicker.cameraAsscessRequest() }
//---------------------------------------------------
    
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
    
    private func displayMessage(message:String) {
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
        
        let createButton = UIBarButtonItem(image: UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .plain, target: self, action: #selector(CarViewController.createNewCar))

          let internetButton = UIButton(type: .system)
          let image1 = UIImage(named: "internet")
          let imageTemp1 = image1?.withRenderingMode(.alwaysTemplate)
          internetButton.setImage(imageTemp1, for: .normal)
          internetButton.addTarget(self, action: #selector(self.tapped), for: .touchUpInside)

          navigationItem.rightBarButtonItems = [createButton, UIBarButtonItem(customView: internetButton)]
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
                
         //       if #available(iOS 11.0, *) {
        //        navigationController?.navigationBar.prefersLargeTitles = true
        //        }
    }

//    @objc func backButton() {
//        currentUserConst = nil
//    let nextVC = RegistrViewController()
//    self.navigationController?.pushViewController(nextVC, animated: true)
//    self.navigationController?.dismiss(animated: true, completion: nil)
//    }

    private func addTable() {
        carsTableView = UITableView()
        carsTableView!.dataSource = self
        carsTableView!.delegate = self
        carsTableView!.separatorStyle = .none
        carsTableView!.backgroundColor = .white
        carsTableView?.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(carsTableView!)

        carsTableView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        carsTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        carsTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        carsTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    @objc func refreshTable(notification: Notification) {

        print("Received Notification")
        self.reloadCarTable()
    }

    //MARK: Set background for ViewController

    override func viewWillLayoutSubviews() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
    }

    //MARK: PopOverViewController for button

    @objc private func tapped() {
        
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

    
//MARK:     для swiftEntryKit
//     private func setupAttributes() -> EKAttributes {
//        var attributes = EKAttributes.centerFloat
//         attributes.displayDuration = .infinity
//        attributes.windowLevel = .normal
//         attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
//         attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
////        attributes.screenInteraction = .dismiss
//         attributes.entryInteraction = .absorbTouches
//         attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
//
//         attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
//                                              scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
//         attributes.exitAnimation = .init(translate: .init(duration: 0.2))
//         attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
//         attributes.positionConstraints.verticalOffset = 10
//         attributes.statusBar = .dark
//        attributes.position = .bottom
//        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor(.white), EKColor(.systemGray5)], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1)))
//         return attributes
//     }
    
    @objc private func createNewCar() {
        self.nameView = AlertForAddCar(frame: .init(origin: .zero, size: self.view.frame.size))
        guard let nameview = self.nameView else { return }
        nameview.delegate = self
        self.view.addSubview(nameview)

//        SwiftEntryKit.display(entry: nameView, using: self.setupAttributes())
    }
     //---------------------------------------
    func reloadCarTable() {
        if let carFetches = CoreDataManager.sharedManager.fetchAllCars() {
            if carFetches.count > 0 {
                self.cars = carFetches
                self.carsTableView!.reloadData()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refresh"), object: nil)
        print("deinit CarVC")
    }
}

extension CarViewController {

     func takePhoto() {
//        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view

        let takePhoto = UIAlertAction(title: "Camera", style: .default) { (alert : UIAlertAction!) in
             self.cameraButtonTapped()
        }
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .default) { (alert : UIAlertAction!) in
            self.photoButtonTapped()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }

//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//
//    let image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as! UIImage
//        // image is our desired image
//
//
//
//        picker.dismiss(animated: true, completion: nil)
//    }
}

extension CarViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
