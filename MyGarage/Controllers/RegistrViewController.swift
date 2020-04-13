//
//  RegistrViewController.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Parse

class RegistrViewController: UIViewController, ButtonDelegate {
    
//    let logedInVC = LogedInViewController()
    
    let signUpButtonView: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("SignUp", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 44)
//        btn.layer.cornerRadius = 8
//        btn.layer.borderWidth = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        
        btn.addTarget(self, action: #selector(RegistrViewController.singIn), for: .touchUpInside)
        return btn
    }()
    
    let logInButtonView: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("LogIn", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 44)
//        btn.layer.cornerRadius = 8
//        btn.layer.borderWidth = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        
        btn.addTarget(self, action: #selector(RegistrViewController.logIn), for: .touchUpInside)
        return btn
    }()
    
    var signUpView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var logInView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: RootControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

//        let backItem = UIBarButtonItem()
//        backItem.title = "Registr"
//        navigationItem.backBarButtonItem = backItem
        
     self.setupView()
    }
    
    func setupView() {
        HelperMethods.shared.setBackGround(view: self.view, color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color3: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        
        let beckgButton = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        HelperMethods.shared.setBackGround(view: beckgButton, color1: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color3: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        let beckgButton1 = UIView(frame: CGRect(x: 0, y: 0, width: 250, height: 80))
        HelperMethods.shared.setBackGround(view: beckgButton1, color1: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1), color2: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color3: #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))
        
        self.view.addSubview(signUpView)
        signUpView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -300).isActive = true
        signUpView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signUpView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        signUpView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        signUpView.addSubview(beckgButton)
        signUpView.addSubview(signUpButtonView)
        signUpButtonView.centerXAnchor.constraint(equalTo: signUpView.centerXAnchor).isActive = true
        signUpButtonView.centerYAnchor.constraint(equalTo: signUpView.centerYAnchor).isActive = true
        
        self.view.addSubview(logInView)
        logInView.topAnchor.constraint(equalTo: signUpView.bottomAnchor, constant: 50).isActive = true
        logInView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        logInView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        logInView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        logInView.addSubview(beckgButton1)
        logInView.addSubview(logInButtonView)
        logInButtonView.centerXAnchor.constraint(equalTo: logInView.centerXAnchor).isActive = true
        logInButtonView.centerYAnchor.constraint(equalTo: logInView.centerYAnchor).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sv = UIViewController.displaySpinner(onView: self.view)
        let currentUser = PFUser.current()
        if currentUser != nil {
            loadHomeScreen()
        }
        UIViewController.removeSpinner(spinner: sv)
    }
    
    private func loadHomeScreen() {
        SceneDelegate.shared.setRootController(rootController: MainTabBarController())
    }
    
    @objc func singIn() {
        let nextVC = SignUpViewController()
        nextVC.delegate = self
        self.navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
    @objc func logIn() {
         let nextVC = LogedInViewController()
         nextVC.delegate = self
         self.navigationController?.present(nextVC, animated: true, completion: nil)
    }
    
    func onButtonTap() {
          self.loadHomeScreen()
      }

    
}

