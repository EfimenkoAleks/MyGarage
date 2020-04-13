//
//  SignUpViewController.swift
//  MyGarage
//
//  Created by mac on 04.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tf.layer.cornerRadius = 6
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
//    let emailTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "Email"
//        tf.keyboardType = .emailAddress
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        tf.layer.cornerRadius = 6
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let signRegisterButtonView: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Sign Up", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 6
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        btn.addTarget(self, action: #selector(SignUpViewController.handleLogin), for: .touchUpInside)
        return btn
    }()
    
    @objc let dismissButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(UIImage(systemName: "clear", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.01087320689, green: 0.5540488362, blue: 0.8131138682, alpha: 1)
        btn.layer.cornerRadius = 6
//        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        btn.addTarget(self, action: #selector(SignUpViewController.dismisButton), for: .touchUpInside)
        return btn
    }()
    
//    convenience init(localPDFUrl: URL) {
//
//            self.init()   // вызывает по умолчанию    super.init(nibName: nil, bundle: nil)
//
//        self.nameTextField.text = ""
//        self.passwordTextField.text = ""
//        }
    
    weak var delegate: ButtonDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(dismissButton)
        self.nameTextField.text = ""
        self.passwordTextField.text = ""
        self.setupView()
        
//        let image = UIImage(named: "back")
//        let imageTemp = image?.withRenderingMode(.alwaysTemplate)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTemp, style: .plain, target: self, action: #selector(SignUpViewController.backButton))
    }
    
@objc func dismisButton() {
self.dismiss(animated: true, completion: nil)
}
    
    private func setupView() {
        
        HelperMethods.shared.setBackGround(view: self.view, color1: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), color2: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), color3: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        
        self.view.addSubview(nameTextField)
        nameTextField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 40).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: 250).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.view.addSubview(signRegisterButtonView)
        signRegisterButtonView.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 70).isActive = true
        signRegisterButtonView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        signRegisterButtonView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        signRegisterButtonView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func loadHomeScreen() {
let nextVC = MainTabBarController()
self.navigationController?.pushViewController(nextVC, animated: true)
self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleLogin() {
        
        let user = PFUser()
        user.username = nameTextField.text
        user.password = passwordTextField.text
//        user.email = emailTextField.text
        let sv = UIViewController.displaySpinner(onView: self.view)
        user.signUpInBackground { (success, error) in
            UIViewController.removeSpinner(spinner: sv)
            if success{
                UserDefaults.standard.set(self.nameTextField.text, forKey: "kUserName")
                UserDefaults.standard.set(self.passwordTextField.text, forKey: "kUserPassword")
//                self.loadHomeScreen()
                self.delegate?.onButtonTap()
                self.dismiss(animated: true, completion: nil)
            }else{
                if let descrip = error?.localizedDescription{
                    self.displayErrorMessage(message: descrip)
                }
            }
        }
        
    }
    
    func displayErrorMessage(message:String) {
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

}

