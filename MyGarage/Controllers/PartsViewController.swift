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

// https://www.linkedin.com/pulse/uicollectionviewdiffabledatasource-decodable-james-rochabrun

protocol ViewLIneProtocol: class {
    func moveLine(tag: Int)
}

class PartsViewController: UIViewController, MenuVCProtocol {

    private var categoryMasiv = [String]()
    weak var delegate: MenuVCProtocol?
    private var sideMenuTableView: MenuViewTab!
    private var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<MSection, MPart>?
    private var partMasiv = [String]()
    private var filtredPartMasiv = [String]()
    private var items = [UIBarButtonItem]()
    private lazy var slideInMenuPading: CGFloat = self.view.frame.width * 0.30
    private var isSlideInMenuPresented = false

    var cart: BadgeButtonItem?
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
//            self.addColection()
            view.backgroundColor = .systemGroupedBackground
//            bgImageView.frame = view.frame
//            self.view.addSubview(bgImageView)
            
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
    
    private func setupInit() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.categoryMasiv = categoriParts
    }
    
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
        
//        let imageLog = UIImage(named: "log-out")
//        let imageTempLog = imageLog?.withRenderingMode(.alwaysTemplate)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempLog, style: .plain, target: self, action: #selector(PartsViewController.backButton))
         
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
        case "Last price":
            self.transitionToTopOffer()
        default:
            self.backButton()
        }
    }
    
    // для панели транзишен
    
//    private func createSlideMenu() {
//        conteinerView.edgeTo(view)
//        menuView.pinMenuTo(conteinerView, with: slideInMenuPading)
//        self.createTableSlideMenu()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(PartsViewController.tapGectureRecognizerSideMenu(_:)))
//        self.menuView.isUserInteractionEnabled = true
//        self.menuView.addGestureRecognizer(tap)
//    }

    @objc func showMenu(_ sender: Any) {
//        self.createSlideMenu()
//        if !isSlideInMenuPresented {
//
////            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
////                self.conteinerView.frame.origin.x = self.isSlideInMenuPresented ? 0 : self.view.frame.width - self.slideInMenuPading
////
////            }) { (finished) in
////                print("Animation finished: \(finished)")
//                self.isSlideInMenuPresented = true
////            }
//            self.slideMenuAnimated(translation: 0)
//        } else {
//            self.slideMenuAnimated(translation: -self.view.frame.width)
//            self.isSlideInMenuPresented = false
//        }
//
                let child = MenuViewController()
                child.delegate = self
                child.transitioningDelegate = transition
                child.modalPresentationStyle = .custom

                present(child, animated: true)
    }
    
//    private func slideMenuAnimated(translation: CGFloat) {
////        let force: CGFloat = 1
////        let translate = CGAffineTransform(translationX: 100 * force, y: 0)
////        let scale = CGAffineTransform(scaleX: 3 * force, y: 0 * force)
////        self.conteinerView.transform = translate.concatenating(scale)
//
//        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
//
//            let translate = CGAffineTransform(translationX: translation, y: 0)
//            let scale = CGAffineTransform(scaleX: 1, y: 1)
//            self.conteinerView.transform = translate.concatenating(scale)
//
//        }, completion: nil)
//    }
    
//    @objc func tapGectureRecognizerSideMenu(_ sender: UITapGestureRecognizer) {
////        if sender.location(in: self.menuView) == sender. {
//        self.slideMenuAnimated(translation: -self.view.frame.width)
//        self.isSlideInMenuPresented = false
////        }
//    }
    
//    private func createTableSlideMenu() {
//        sideMenuTableView = MenuViewTab()
// //       menuView.addSubview(sideMenuTableView)
//
//        self.sideMenuTableView.translatesAutoresizingMaskIntoConstraints = false
//        self.menuView.addSubview(sideMenuTableView)
//        sideMenuTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
//        sideMenuTableView.trailingAnchor.constraint(equalTo: self.menuView.trailingAnchor).isActive = true
//        sideMenuTableView.leadingAnchor.constraint(equalTo: self.menuView.leadingAnchor).isActive = true
//        sideMenuTableView.bottomAnchor.constraint(equalTo: self.menuView.bottomAnchor).isActive = true
//
//        self.sideMenuTableView.table.delegate = self
//        self.sideMenuTableView.table.dataSource = self
//
//    }
    
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
    
    @objc func addToBag(sender: UIButton) {
        var name: String
        let buttonPosition: CGPoint = sender.convert(CGPoint.init(x: 5.0, y: 5.0), to:self.collectionView)
        guard let indexPath = self.collectionView.indexPathForItem(at: buttonPosition) else { return }
                   if isFiltering {
                    name = self.filtredPartMasiv[indexPath.item]
                   } else {
                    print(indexPath)
        //               name = self.partMasiv[indexPath.item]
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
    
    private func createBg() {
        let bgImageView = UIView(frame: view.frame)
        self.view.addSubview(bgImageView)
    }

    //MARK: Composit Layout
    
    var sectionsArray = HelperMethods.shared.createMSection(numberItem: 0)
    var itemsArray = HelperMethods.shared.createMPart(array: partsNames[0])
    var scrollTo = 0

    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createCompositionLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseId)
        collectionView.register(FirstCell.self, forCellWithReuseIdentifier: FirstCell.reuseId)
        collectionView.register(SecondCell.self, forCellWithReuseIdentifier: SecondCell.reuseId)
        
        createDataSource()
        reloadData()
        
        collectionView.delegate = self
    }

    //    private func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
    //        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else { fatalError("Error \(cellType)")}
    //        return cell
    //    }

        // MARK: - Manage the data in UICV

        func createDataSource() {
         dataSource = UICollectionViewDiffableDataSource<MSection, MPart>(collectionView: collectionView
            , cellProvider: { (collectionView, indexPath, part) -> UICollectionViewCell? in
                switch self.sectionsArray[indexPath.section].type {

                case "CategoriParts":
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCell.reuseId, for: indexPath) as? FirstCell
                    cell?.configure(with: part.partName)
                    return cell
                default:
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCell.reuseId, for: indexPath) as? SecondCell
                    cell?.configure(with: part.partName)
                    cell?.cartButton.addTarget(self, action: #selector(PartsViewController.addToBag(sender:)), for: .touchUpInside)
                    return cell
                }
         })
            dataSource?.supplementaryViewProvider = {
                collectionView, kind, indexPath in
                guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeader.reuseId, for: indexPath) as? SectionHeader else {
                    return nil }
                guard let firstPart = self.dataSource?.itemIdentifier(for: indexPath) else { return nil }
                guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: firstPart) else {return nil }
                if section.title.isEmpty { return nil }
                sectionHeader.title.text = section.title
                return sectionHeader
            }
        }

        func reloadData() {
            var snapShot = NSDiffableDataSourceSnapshot<MSection, MPart>()
            snapShot.appendSections(sectionsArray)

            for section in sectionsArray {
                snapShot.appendItems(section.items, toSection: section)
            }
            dataSource?.apply(snapShot, animatingDifferences: true)

        }

        //MARK: - Setup Layout

      func createCompositionLayout() -> UICollectionViewLayout {
          let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
              let section = self.sectionsArray[sectionIndex]

              switch section.type {
              case "CategoriParts":
                  return self.createCategorySection()
              default:
                  return self.createPartSection()
              }
          }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 50
        layout.configuration = config
          return layout
      }

        private func createCategorySection() -> NSCollectionLayoutSection {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                  let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 4, bottom: 0, trailing: 4)
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(self.view.bounds.size.width / 5), heightDimension: .estimated(self.view.bounds.size.width / 5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //        group.interItemSpacing = .fixed(spasing)
                  let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
        //        section.interGroupSpacing = spasing
            section.contentInsets = NSDirectionalEdgeInsets.init(top: 12, leading: 8, bottom: 0, trailing: 8)

        //        let layoutSectionHeader = createSectionHeadr()
        //        layoutSectionHeader.contentInsections = NSDirectionEdgeInsets.init(top: 0, leading: 5, bottom: 0, trailing: 0)
        //        layoutSection.boundarySupplementaryItems = [layoutSectionHeader]

            let header = createSectionHeader()
            section.boundarySupplementaryItems = [header]
                  return section
              }

        private func createPartSection() -> NSCollectionLayoutSection {

 //           let spasing = CGFloat(20)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(self.view.bounds.size.width / 9))
              let item = NSCollectionLayoutItem(layoutSize: itemSize)
              item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(2.0))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            group.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 0, bottom: 50, trailing: 0)
 //           group.interItemSpacing = .fixed(spasing)
              let section = NSCollectionLayoutSection(group: group)
 //           section.interGroupSpacing = spasing
              section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 6, bottom: 0, trailing: 6)

            let header = createSectionHeader()
            section.boundarySupplementaryItems = [header]
              return section
          }
    
    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return layoutSectionHeader
    }


}

private extension UIView {
    
    func edgeTo(_ view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func pinMenuTo(_ view: UIView, with constant: CGFloat) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension PartsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch self.sectionsArray[indexPath.section].type {
            
        case "CategoriParts":
            guard let id = self.dataSource?.itemIdentifier(for: indexPath) else { return }
            guard var snaphost = self.dataSource?.snapshot() else { return }
            
            snaphost.deleteItems(self.itemsArray)
            
            guard let itemIndex = snaphost.indexOfItem(id) else { return }
            self.itemsArray = HelperMethods.shared.createMPart(array: partsNames[itemIndex])
            snaphost.appendItems(self.itemsArray, toSection: self.sectionsArray.last)
            
            dataSource?.apply(snaphost, animatingDifferences: true)
            
            collectionView.deselectItem(at: indexPath, animated: true)
        default:
           print("default")
        }
    }
}

extension NSDiffableDataSourceSnapshot {

    mutating func deleteItems(_ items: [ItemIdentifierType], at section: Int) {

        // a Delete Items in section

        deleteItems(items)

      let sectionIdentifier = sectionIdentifiers[section]

      // c Check if its empty

      guard numberOfItems(inSection: sectionIdentifier) == 0 else { return }

      // d Delete Section

      deleteSections([sectionIdentifier])

    }
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
