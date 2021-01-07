//
//  AlertForAddCar.swift
//  MyGarage
//
//  Created by user on 29.12.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SwiftEntryKit
import TextFieldEffects

class AlertForAddCar: UIView {
    
    weak var delegate: PicerPhotoCarBelegate?
    
    var alertTitlLabel: UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = UIFont.systemFont(ofSize: 17)
        lb.backgroundColor = .clear
        lb.text = "Information about car"
        lb.layer.cornerRadius = 4
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var carImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iconCar")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 0
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return imageView
    }()
    
    let nameTextField: YokoTextField = {
        let tf = YokoTextField()
        tf.placeholderColor = .lightGray
        tf.foregroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.6499227881, green: 0.1495146751, blue: 0.4021521211, alpha: 1)
        tf.placeholder = "Name"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 0.8
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let subNameTextField: YokoTextField = {
        let tf = YokoTextField()
        tf.placeholderColor = .lightGray
        tf.foregroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.6499227881, green: 0.1495146751, blue: 0.4021521211, alpha: 1)
        tf.placeholder = "SubName"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 0.8
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let numberTextField: YokoTextField = {
        let tf = YokoTextField()
        tf.placeholderColor = .lightGray
        tf.foregroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        tf.tintColor = #colorLiteral(red: 0.6499227881, green: 0.1495146751, blue: 0.4021521211, alpha: 1)
        tf.placeholder = "Number"
        tf.font = UIFont(name: "CourierNewPS-BoldMT", size: 17)
        tf.placeholderFontScale = 0.8
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let okButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Save", for: .normal)
        btn.setTitleColor(.systemIndigo, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 1)
        btn.layer.shadowRadius = 1
        btn.addTarget(self, action: #selector(AlertForAddCar.ok(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9222491384, green: 0.9451189637, blue: 0.9811074138, alpha: 1)
        return btn
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(.systemIndigo, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 17)
        // btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        
        btn.layer.masksToBounds = false
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.5
        btn.layer.shadowOffset = CGSize(width: -1, height: 1)
        btn.layer.shadowRadius = 1
        btn.addTarget(self, action: #selector(AlertForAddCar.cancel(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = #colorLiteral(red: 0.9222491384, green: 0.9451189637, blue: 0.9811074138, alpha: 1)
        return btn
    }()
    
    var bgView: UIView = {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.9702147841, green: 0.9619753957, blue: 0.9914200902, alpha: 1)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    var blurView: UIView = {
        let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).withAlphaComponent(0.7)
        bg.translatesAutoresizingMaskIntoConstraints = false
        return bg
    }()
    
    //    override func layoutSubviews() {
    //        super.layoutSubviews()
    //        createConstreint()
    //    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createConstreint()
        self.backgroundColor = .clear
        //        heightAnchor.constraint(equalToConstant: 320).isActive = true
        //       self.layer.cornerRadius = 20
        //        self.translatesAutoresizingMaskIntoConstraints = false
        //       self.nameLabel.text = "No conected"
        //       self.descriptionLabel.text = "Please turn on the internet"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func ok(_ sender: Any) {
        var image = UIImage(named: "iconCar")
        if carImageView.image != nil {
            image = carImageView.image
        }
        
        if let nameTextFild = self.nameTextField.text, let subNameTextFild = self.subNameTextField.text, let numderTextFild = self.numberTextField.text {
            if nameTextFild.count > 0 && subNameTextFild.count > 0 && numderTextFild.count > 0 {
                DispatchQueue.global(qos: .background).async {
                    CoreDataManager.sharedManager.saveCar(image: (image!.pngData()!), name: nameTextFild, subName: subNameTextFild, number: numderTextFild, bool: true, masiv: nil)
                    DispatchQueue.main.async {
                        self.delegate?.reloadCarTable()
                    }
                }
            }
        }
        self.removeFromSuperview()
    }
    
    @objc func cancel(_ sender: Any) {
        //          SwiftEntryKit.dismiss()
        self.removeFromSuperview()
    }
    
    @objc func tapgesture(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            let touchLocation: CGPoint = sender.location(in: sender.view?.superview)
            if carImageView.frame.contains(touchLocation) {
                print("tapped method called")
                delegate?.takePhoto()
            }
        }
    }
}

extension AlertForAddCar {
    private func createConstreint() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(AlertForAddCar.tapgesture(_:)))
        self.carImageView.isUserInteractionEnabled = true
        self.carImageView.addGestureRecognizer(tap)
        
        self.addSubview(blurView)
        blurView.addSubview(bgView)
        bgView.addSubview(carImageView)
        bgView.addSubview(alertTitlLabel)
        bgView.addSubview(nameTextField)
        bgView.addSubview(subNameTextField)
        bgView.addSubview(numberTextField)
        bgView.addSubview(okButton)
        bgView.addSubview(cancelButton)
        
        blurView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        blurView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        blurView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        
        bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        bgView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bgView.widthAnchor.constraint(equalToConstant: self.bounds.width / 5 * 4).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        bgView.layer.cornerRadius = 15
        
        carImageView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 10).isActive = true
        carImageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        carImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        carImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        carImageView.layer.cornerRadius = 38
        
        alertTitlLabel.topAnchor.constraint(equalTo: carImageView.bottomAnchor, constant: 8).isActive = true
        alertTitlLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        alertTitlLabel.widthAnchor.constraint(equalToConstant: 180).isActive = true
        alertTitlLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: alertTitlLabel.bottomAnchor, constant: 20).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        subNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12).isActive = true
        subNameTextField.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        subNameTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        subNameTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        numberTextField.topAnchor.constraint(equalTo: subNameTextField.bottomAnchor, constant: 12).isActive = true
        numberTextField.centerXAnchor.constraint(equalTo: bgView.centerXAnchor).isActive = true
        numberTextField.widthAnchor.constraint(equalToConstant: 200).isActive = true
        numberTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        okButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20).isActive = true
        okButton.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: -60).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 20).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: bgView.centerXAnchor, constant: 60).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
}


