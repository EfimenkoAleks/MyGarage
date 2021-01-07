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

class PartsViewController: UIViewController, MenuVCProtocol, BageDelegate {
    
    //MARK: Создание переменных
    private var categoryMasiv = [String]()
    weak var delegate: MenuVCProtocol?
    private var sideMenuTableView: MenuViewTab!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<MSection, MPart>?
    private var partMasiv = [String]()
    var filtredPartMasiv = [String]()
    private var items = [UIBarButtonItem]()
    private lazy var slideInMenuPading: CGFloat = self.view.frame.width * 0.30
    private var isSlideInMenuPresented = false
    var alertAddPart: AlertView?
    
    var cart: BadgeButtonItem?
    var countPart = 0
    var sectionsArray = HelperMethods.shared.createMSection(numberItem: 0)
    var itemsArray = HelperMethods.shared.createMPart(array: partsNames[0])
    var scrollTo = 0
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUser()
        
        if currentUserConst != nil {
            self.setupInit()
            self.partMasiv = partsNames[0]
            //            self.addColection()
            view.backgroundColor = .systemGroupedBackground
            self.setupCollectionView()
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
    // Текущий юзер
    private func setUser() {
        
        let name = UserDefaults.standard.value(forKey: "kUserName") as! String
        let password = UserDefaults.standard.value(forKey: "kUserPassword") as! String
        
        currentUserConst = User(name: name, password: password)
    }
    
    private func setupInit() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.categoryMasiv = categoriParts
    }
    //MARK: Setup navigationBar
    
    private func setupNavigationBarButton() {
        
        let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
        let imageMenu = UIImage(systemName: "sidebar.left", withConfiguration: scaleConfig)!
        let imageTemp = imageMenu.withRenderingMode(.alwaysTemplate)
        let menu = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(PartsViewController.showMenu(_:)))
        
        self.cart = BadgeButtonItem(with: UIImage(systemName: "cart", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), style: .plain, target: self, action: #selector(PartsViewController.shopCase))
        
        let plusConfig = UIImage.SymbolConfiguration(scale: .large)
        let imagePlus = UIImage(systemName: "plus", withConfiguration: plusConfig)!
        let plusTemp = imagePlus.withRenderingMode(.alwaysTemplate)
        let plus = UIBarButtonItem(image: plusTemp, style: .plain, target: self, action: #selector(PartsViewController.createNewPart))
        
        navigationItem.rightBarButtonItems = [plus, self.cart!]
        navigationItem.leftBarButtonItem = menu
        
        //         let buttonPlus = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        //         buttonPlus.setImage(UIImage(systemName: "plus", withConfiguration: scaleConfig)!, for: .normal)
        //         buttonPlus.addTarget(self, action: #selector(PartsViewController.createNewPart), for: .touchUpInside)
        //        self.viewPlus.addSubview(buttonPlus)
        //
        ////         navigationItem.titleView = self.viewPlus
        //        self.view.addSubview(self.viewPlus)
        //        self.viewPlus.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //        self.viewPlus.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.bounds.size.height / 2.58).isActive = true
        //        self.viewPlus.widthAnchor.constraint(equalToConstant: 40).isActive = true
        //         self.viewPlus.heightAnchor.constraint(equalToConstant: 40).isActive = true
        //        self.viewPlus.layer.borderWidth = 1
        //        self.viewPlus.layer.borderColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        
        // Создание навигейшен титла
        let imageView = UIImageView(image: UIImage(named: "ingenir.fill"))
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        let label = UILabel()
        label.text = "Parts"
        label.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 22)
        label.textColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .horizontal
        stackView.frame.size = CGSize(width: imageView.frame.size.width + label.frame.size.width, height: max(imageView.frame.size.height, label.frame.size.height))
        stackView.spacing = 8
        
        navigationItem.titleView = stackView
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1).withAlphaComponent(0.1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
    }
    // Выход из текущего профеля
    func backButton() {
        
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
    //MARK: Переходы на другие контроллры
    
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
        case "Last price":
            self.transitionToTopOffer()
        default:
            self.backButton()
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
        
        self.alertAddPart = AlertView(frame: CGRect(origin: .zero, size: self.view.frame.size))
        guard let alertPart = self.alertAddPart else { return }
        alertPart.delegate = self
        self.view.addSubview(self.alertAddPart!)
    }
    // Устанавливаем бейдж
    func setBage() {
        if self.countPart == 0 {
            self.countPart = 1
            self.cart!.setBadge(with: self.countPart)
        } else {
            self.countPart = self.countPart + 1
            self.cart!.setBadge(with: self.countPart)
            print("\(self.countPart)")
        }
    }
    
    // Добавление запчасти в корзину
    
    @objc func addToBag(sender: UIButton) {
        var name: String
        let buttonPosition: CGPoint = sender.convert(CGPoint.init(x: 5.0, y: 5.0), to:self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: buttonPosition) else { return }
        if isFiltering {
            name = self.filtredPartMasiv[indexPath.item]
        } else {
            print(indexPath)
            name = itemsArray[indexPath.item].partName
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
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SelectedParts"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "SparePartsReports"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "TopOffer"), object: nil)
        print("deinit PartsVC")
    }
    
    //    enum SectionKind: Int, CaseIterable {
    //        case category, part
    //        var columnCount: Int {
    //            switch self {
    //            case .part:
    //                return 2
    //            case .category:
    //            return 3
    //            }
    //        }
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
        collectionView?.reloadData()
    }
}
