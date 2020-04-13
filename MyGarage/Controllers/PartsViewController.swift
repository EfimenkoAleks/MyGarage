//
//  PartsViewController.swift
//  MyGarage
//
//  Created by mac on 03.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import Parse

protocol ViewLIneProtocol: class {
    func moveLine(tag: Int)
}

class PartsViewController: UIViewController, MenuVCProtocol {

    private var categoryCollectionView: UICollectionView?
    private var categoryMasiv = [String]()
    
    private var partCollectionView: UICollectionView?
    private var partMasiv = [String]()
    private var filtredPartMasiv = [String]()
    private var items = [UIBarButtonItem]()

    var cart: BadgeButtonItem?
//    weak var delegate: ViewLIneProtocol?
//    let tagLine = 0
    var countPart = 0
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
 
    // для панели транзишен
    private let transition = PanelTransition()
    
    var blurEffectView: UIVisualEffectView?
    
    let viewPlus: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    let viewShow: UIView = {
         let view = UIView()
         view.backgroundColor = UIColor.white
         view.translatesAutoresizingMaskIntoConstraints = false
         view.layer.cornerRadius = 50
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
     
     let saveButton: UIButton = {
         let btn = UIButton(type: .system)
         btn.setTitle("Save", for: .normal)
         btn.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
         btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
         btn.layer.cornerRadius = 8
         btn.translatesAutoresizingMaskIntoConstraints = false
         btn.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
         
         btn.addTarget(self, action: #selector(PartsViewController.forSavebutton), for: .touchUpInside)
         return btn
     }()
     
     let cancelButton: UIButton = {
         let btn = UIButton(type: .system)
         btn.setTitle("Cancel", for: .normal)
         btn.setTitleColor(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1), for: .normal)
         btn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 17)
         btn.layer.cornerRadius = 8
         btn.translatesAutoresizingMaskIntoConstraints = false
         btn.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
         
         btn.addTarget(self, action: #selector(PartsViewController.forCancelbutton), for: .touchUpInside)
         return btn
     }()
     
     var label: UILabel = {
         let lb = UILabel()
         lb.textAlignment = .center
         lb.font = UIFont.systemFont(ofSize: 25)
         lb.backgroundColor = .clear
         lb.layer.cornerRadius = 10
         lb.layer.masksToBounds = true
         lb.numberOfLines = 0
         lb.translatesAutoresizingMaskIntoConstraints = false
         return lb
     }()
     
     var bubbleView: UIView = {
         let view = UIView()
         view.backgroundColor = .clear
         view.layer.cornerRadius = 8
         view.layer.masksToBounds = true
         view.translatesAutoresizingMaskIntoConstraints = false
         return view
     }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUser()
        
        if currentUserConst != nil {
            self.setupInit()
            self.partMasiv = partsNames[0]
            self.addColection()
            self.setupNavigationBarButton()
            
            // Setup the Seatch Controller
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search"
            navigationItem.searchController = searchController
            definesPresentationContext = true
        } else {
            self.backButton()
        }
        
        if UserDefaults.standard.value(forKey: "kLastMonthDate") == nil {
                   HelperMethods.shared.setFirstMonthAndYear()
               }
               
        DispatchQueue.global(qos: .utility).async {
                   HelperMethods.shared.newMonth()
               }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev0"), object: nil)
//        self.delegate?.moveLine(tag: self.tagLine)
//        print("tag \(self.tagLine)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let arrayCount = CoreDataManager.sharedManager.fetchAllChoisePart() else { return }
        self.countPart = arrayCount.count
        self.cart!.setBadge(with: self.countPart)
    }
    
    private func setupInit() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.categoryMasiv = categoriParts
    }
    
    private func addColection() {
        
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout1.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        layout1.itemSize = CGSize(width: self.view.frame.width / 4, height: self.view.frame.width / 4)
        layout1.scrollDirection = .horizontal
        
        let rect1 = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 80)
        categoryCollectionView = UICollectionView(frame: rect1, collectionViewLayout: layout1)
        categoryCollectionView!.dataSource = self
        categoryCollectionView!.delegate = self
        categoryCollectionView!.backgroundColor = UIColor.clear
        categoryCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryCollectionView!)
        categoryCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        categoryCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        categoryCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        categoryCollectionView?.heightAnchor.constraint(equalToConstant: 150).isActive = true
        categoryCollectionView?.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.reuseId)
        categoryCollectionView?.showsHorizontalScrollIndicator = false
        
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout2.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        layout2.itemSize = CGSize(width: self.view.frame.width / 3 - 4, height: self.view.frame.width / 3 - 4 )
        layout2.minimumLineSpacing = 4
        layout2.minimumInteritemSpacing = 4
        
        let rect2 = CGRect(x: 0, y: 260, width: self.view.frame.width, height: self.view.frame.height - 350)
        partCollectionView = UICollectionView(frame: rect2, collectionViewLayout: layout2)
        partCollectionView!.dataSource = self
        partCollectionView!.delegate = self
        partCollectionView!.backgroundColor = UIColor.clear
        partCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(partCollectionView!)
        partCollectionView?.topAnchor.constraint(equalTo: self.categoryCollectionView!.bottomAnchor, constant: 10).isActive = true
        partCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        partCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        partCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        partCollectionView?.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.reuseId)
        partCollectionView?.showsVerticalScrollIndicator = false
        
        let color1 = UIColor.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        let color2 = UIColor.init(red: 0.998, green: 1, blue: 1, alpha: 1)
        let color3 = UIColor.init(red: 0.921, green: 0.921, blue: 0.921, alpha: 1)
        HelperMethods.shared.setBackGround(view: self.view, color1: color1, color2: color2, color3: color3)
    
    }
    
    private func setupNavigationBarButton() {

         let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
         let imageMenu = UIImage(systemName: "ellipsis", withConfiguration: scaleConfig)!
         let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
         let menu = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(PartsViewController.showMenu(_:)))
         
         self.cart = BadgeButtonItem(with: UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .plain, target: self, action: #selector(PartsViewController.shopCase))
         
         navigationItem.rightBarButtonItems = [self.cart!, menu]
        
        let imageLog = UIImage(named: "log-out")
        let imageTempLog = imageLog?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempLog, style: .plain, target: self, action: #selector(PartsViewController.backButton))
         
         let buttonPlus = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
         buttonPlus.setImage(UIImage(systemName: "plus", withConfiguration: scaleConfig)!, for: .normal)
         buttonPlus.addTarget(self, action: #selector(PartsViewController.createNewPart), for: .touchUpInside)
        
        self.viewPlus.addSubview(buttonPlus)
         navigationItem.titleView = self.viewPlus
        self.viewPlus.centerXAnchor.constraint(equalTo: navigationItem.titleView!.centerXAnchor).isActive = true
         self.viewPlus.centerYAnchor.constraint(equalTo: navigationItem.titleView!.centerYAnchor).isActive = true
        self.viewPlus.widthAnchor.constraint(equalToConstant: 40).isActive = true
         self.viewPlus.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.viewPlus.layer.borderWidth = 1
        self.viewPlus.layer.borderColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).withAlphaComponent(0.1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
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
    
    private func setUser() {
        
        let name = UserDefaults.standard.value(forKey: "kUserName") as! String
        let password = UserDefaults.standard.value(forKey: "kUserPassword") as! String
        
        currentUserConst = User(name: name, password: password)
    }

    func transitionToSelected() {
         
         print("Received Notification transitionTo")
        let nextVC = SelectedItemsViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
     }
     
     func transitionToReport() {
         
         print("Received Notification transitionTo")
        let nextVC = SparePartsReportsViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
     }
     
     func transitionToTopOffer() {
         
         print("Received Notification transitionTo")
        let nextVC = TopOfferViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
     }
    
    @objc func shopCase() {
        let nextVC = SelectedItemsViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func showController(name: String) {
        switch name {
        case "Selected Parts":
            self.transitionToSelected()
        case "Spare parts reports":
            self.transitionToReport()
        default:
            self.transitionToTopOffer()
        }
    }
    
    // для панели транзишен

     @objc func showMenu(_ sender: Any) {
        let child = MenuViewController()
        child.delegate = self
        child.transitioningDelegate = transition
        child.modalPresentationStyle = .custom

        present(child, animated: true)
    }
    
      @objc func createNewPart() {
          
          let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
          self.blurEffectView = UIVisualEffectView(effect: blurEffect)
          self.blurEffectView!.frame = self.view.bounds
          self.blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
          self.view.addSubview(self.blurEffectView!)

          self.view.addSubview(self.viewShow)
          
          viewShow.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
          viewShow.topAnchor.constraint(equalTo: self.view.topAnchor,constant: self.view.frame.height * 0.2).isActive = true
          viewShow.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -50).isActive = true
          viewShow.heightAnchor.constraint(equalToConstant: 150).isActive = true
          
          self.viewShow.addSubview(bubbleView)
          
          bubbleView.trailingAnchor.constraint(equalTo: viewShow.trailingAnchor, constant: -25).isActive = true
          bubbleView.leadingAnchor.constraint(equalTo: viewShow.leadingAnchor, constant: 25).isActive = false
          bubbleView.topAnchor.constraint(equalTo: viewShow.topAnchor,constant: 50).isActive = true
          bubbleView.widthAnchor.constraint(equalTo: viewShow.widthAnchor, constant: -50).isActive = true
          bubbleView.heightAnchor.constraint(equalToConstant: 100).isActive = true
          
          self.bubbleView.addSubview(self.nameTextField)
          
          nameTextField.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
          nameTextField.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor).isActive = true
          nameTextField.widthAnchor.constraint(equalTo: bubbleView.widthAnchor).isActive = true
          nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
          self.viewShow.addSubview(self.label)
          self.viewShow.addSubview(self.saveButton)
          self.viewShow.addSubview(self.cancelButton)
          
          label.topAnchor.constraint(equalTo: viewShow.topAnchor).isActive = true
          label.centerXAnchor.constraint(equalTo: viewShow.centerXAnchor).isActive = true
          label.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
          
          cancelButton.bottomAnchor.constraint(equalTo: viewShow.bottomAnchor).isActive = true
          cancelButton.leadingAnchor.constraint(equalTo: viewShow.leadingAnchor).isActive = true
          cancelButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor).isActive = true
          cancelButton.widthAnchor.constraint(equalToConstant: viewShow.frame.width / 2).isActive = true
          cancelButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true

          saveButton.bottomAnchor.constraint(equalTo: viewShow.bottomAnchor).isActive = true
          saveButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor).isActive = true
          saveButton.trailingAnchor.constraint(equalTo: viewShow.trailingAnchor).isActive = true
          saveButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
          saveButton.heightAnchor.constraint(equalTo: nameTextField.heightAnchor).isActive = true
    
          self.label.text = "New repair"
        
      }
    
    @objc func forSavebutton() {
        
        if self.nameTextField.text!.count > 0 {
            //        self.nameTextField.text = ""
            let count = "1"
            let seller = "Other"
            CoreDataManager.sharedManager.saveChoicePart(name: self.nameTextField.text!, count: count, price: nil, seller: seller)
            
            if self.countPart == 0 {
                self.countPart = 1
                self.cart!.setBadge(with: self.countPart)
            } else {
                self.countPart = self.countPart + 1
                self.cart!.setBadge(with: self.countPart)
            }
            
            self.viewShow.removeFromSuperview()
            self.nameTextField.text = ""
            self.blurEffectView?.effect = nil
            self.blurEffectView?.removeFromSuperview()
        }
    }
    
    @objc func forCancelbutton() {
          self.viewShow.removeFromSuperview()
          self.nameTextField.text = ""
          self.blurEffectView?.effect = nil
          self.blurEffectView?.removeFromSuperview()
      }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SelectedParts"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SparePartsReports"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "TopOffer"), object: nil)
        print("deinit PartsVC")
    }

}

extension PartsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
       //MARK: UICollectionViewDataSourse
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.categoryCollectionView {
            return self.categoryMasiv.count
        } else {
            if isFiltering {
                return filtredPartMasiv.count
            }
            return self.partMasiv.count
        }
        
    }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            if collectionView == self.categoryCollectionView {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: FirstCell.reuseId, for: indexPath) as? FirstCell)!
                
                let categories = self.categoryMasiv[indexPath.row]
                cell.configure(with: categories)
      
                cell.layer.shadowOpacity = 0.7
                cell.layer.shadowRadius = 5.0
                
                return cell
            } else {
                let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseId, for: indexPath) as? SecondCell)!
                var part: String
                if isFiltering {
                    part = self.filtredPartMasiv[indexPath.row]
                        cell.configure(with: part)
                    return cell
                } else {
                    part = self.partMasiv[indexPath.row]
                        cell.configure(with: part)
                    return cell
                }
            }
        }
        
        //MARK: UICollectionViewDelegate
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            
            if collectionView == categoryCollectionView {
                self.partMasiv = partsNames[indexPath.item]
                self.partCollectionView?.reloadData()
                self.partCollectionView?.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
            } else {
            var name: String
            if isFiltering {
                name = self.filtredPartMasiv[indexPath.item]
            } else {
                print(indexPath)
                name = self.partMasiv[indexPath.item]
            }
            
 // проверка сохранён обьект или нет
            let saver = CoreDataManager.sharedManager.fetchAllChoisePart()
            for nameSaver in saver! {
                if nameSaver.name == name {
                    return
                }
            }
 //------------------
            
            CoreDataManager.sharedManager.saveChoicePart(name: name, count: "1", price: nil, seller: "Other")

                if self.countPart == 0 {
                    self.countPart = 1
                    self.cart!.setBadge(with: self.countPart)
                } else {
                    self.countPart = self.countPart + 1
                    self.cart!.setBadge(with: self.countPart)
                }
                
                guard let cell = partCollectionView!.cellForItem(at: indexPath) as? SecondCell else { return }

            let cardViewFrame = cell.partImageView.superview!.convert(cell.partImageView.frame, to: nil)
            let copiOfCardView = UIView(frame: cardViewFrame)
            copiOfCardView.layer.cornerRadius = 12.0
            view.addSubview(copiOfCardView)
            copiOfCardView.backgroundColor = UIColor(patternImage: UIImage(named: name + ".jpg")!)

            UIView.animate(withDuration: 1.0, animations: {
                copiOfCardView.transform = CGAffineTransform(scaleX: 2, y: 2)
                copiOfCardView.transform = CGAffineTransform(scaleX: -2, y: -2)
                copiOfCardView.frame = CGRect(x: 0, y: 0, width: cell.partImageView.frame.width / 7, height: cell.partImageView.frame.width / 7)
            }) { (extended) in
                copiOfCardView.removeFromSuperview()
            }
            }

        }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//         if collectionView == partCollectionView {
//            return 2
//         } else {
//            return 10
//        }
//    }
        
        //MARK: UICollectionViewDelegateFlowLayout
        
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let width = (self.partCategoriCollectionView!.bounds.width / 2) - 15
    //        let height = width * (4 / 3)
    //
    ////        var height: CGFloat
    ////        if indexPath.item % 2 == 0 {
    ////            height = width * (5 / 3)
    ////        } else {
    ////            height = width * (4 / 3)
    ////        }
    //
    //        return CGSize(width: width, height: height)
    //    }
        
    }

extension PartsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        self.filtredPartMasiv = self.partMasiv.filter({ (part: String) -> Bool in
            return part.lowercased().contains(searchText.lowercased())
        })
        partCollectionView?.reloadData()
    }
}

    




//MARK: Composit Layout
//----------------------------------------------------------------------------------------------------

//class PartsViewController: UIViewController {
//
////    enum SectionKind: Int, CaseIterable {
////        case category, part
////        var columnCount: Int {
////            switch self {
////            case .part:
////                return 2
////            case .category:
////            return 3
////            }
////        }
////    }
//
//    var sections = HelperMethods.shared.createMSection(numberItem: 0)
//    var scrollTo = 0
//
//    var dataSource: UICollectionViewDiffableDataSource<MSection, String>! = nil
//    var collectionView: UICollectionView!
//
//      override func viewDidLoad() {
//          super.viewDidLoad()
//
//          view.backgroundColor = .purple
//          setupCollectionView()
//      }
//
//      func setupCollectionView() {
//          collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//          collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//          collectionView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
//          view.addSubview(collectionView)
//          collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.reuseId)
//        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.reuseId)
//
//        createDataSource()
//        reloadData()
//
//        collectionView.delegate = self
//      }
//
////    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
////        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Error \(cellType)")}
////        return cell
////    }
//
//    // MARK: - Manage the data in UICV
//
//    func createDataSource() {
//     dataSource = UICollectionViewDiffableDataSource<MSection, String>(collectionView: collectionView
//        , cellProvider: { (collectionView, indexPath, part) -> UICollectionViewCell? in
//            switch self.sections[indexPath.section].type {
//
//            case "CategoriParts":
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCell.reuseId, for: indexPath) as? FirstCell
//                cell?.configure(with: part + ".jpg")
//                return cell
//            default:
//                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseId, for: indexPath) as? SecondCell
//                cell?.configure(with: part + ".jpg")
//                return cell
//            }
//     })
//    }
//
//    func reloadData() {
//        var snapShot = NSDiffableDataSourceSnapshot<MSection, String>()
//        snapShot.appendSections(sections)
//
//        for section in sections {
//            snapShot.appendItems(section.items, toSection: section)
//        }
//        dataSource?.apply(snapShot)
//
//    }
//
//    //MARK: - Setup Layout
//
//  func createLayout() -> UICollectionViewLayout {
//      let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
//          let section = self.sections[sectionIndex]
//
//          switch section.type {
//          case "CategoriParts":
//              return self.createCategorySection()
//          default:
//              return self.createPartSection()
//          }
//      }
//    let config = UICollectionViewCompositionalLayoutConfiguration()
//    config.interSectionSpacing = 50
//    layout.configuration = config
//      return layout
//  }
//
//    private func createCategorySection() -> NSCollectionLayoutSection {
//
//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//              let item = NSCollectionLayoutItem(layoutSize: itemSize)
//              item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
//            let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(160), heightDimension: .estimated(144))
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//    //        group.interItemSpacing = .fixed(spasing)
//              let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
//    //        section.interGroupSpacing = spasing
//              section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 12, bottom: 0, trailing: 12)
//
//
//    //        let layoutSectionHeader = createSectionHeadr()
//    //        layoutSectionHeader.contentInsections = NSDirectionEdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 0)
//    //        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]
//
//              return section
//          }
//
//
//    private func createPartSection() -> NSCollectionLayoutSection {
//
//        let spasing = CGFloat(20)
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
//          let item = NSCollectionLayoutItem(layoutSize: itemSize)
//    //      item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.45))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
//        group.interItemSpacing = .fixed(spasing)
//          let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = spasing
//          section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spasing, bottom: 0, trailing: spasing)
//
//          return section
//      }
//
//
//}
//
//// MARK: - UICollectionViewDelegate
//
//extension PartsViewController: UICollectionViewDelegate {
//
////    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
////
////
////        self.collectionView?.scrollToItem(at: IndexPath(item: scrollTo, section: 0), at: .left, animated: false)
////
////    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if indexPath.section == 0 {
//            self.sections = HelperMethods.shared.createMSection(numberItem: indexPath.item)
//            self.createDataSource()
//            self.reloadData()
//            scrollTo = indexPath.item
//
//        }
//        print(indexPath)
////        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//
//
//}
//
//// MARK: - SwiftUI
////import SwiftUI
////struct AdvancedProvider: PreviewProvider {
////    static var previews: some View {
////        ContainterView().edgesIgnoringSafeArea(.all)
////    }
////
////    struct ContainterView: UIViewControllerRepresentable {
////
////        let tabBar = MainTabBarController()
////        func makeUIViewController(context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) -> MainTabBarController {
////            return tabBar
////        }
////
////        func updateUIViewController(_ uiViewController: AdvancedProvider.ContainterView.UIViewControllerType, context: UIViewControllerRepresentableContext<AdvancedProvider.ContainterView>) {
////
////        }
////    }
////}

