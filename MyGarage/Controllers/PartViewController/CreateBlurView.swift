//
//  CreateBlurView.swift
//  MyGarage
//
//  Created by user on 06.01.2021.
//  Copyright © 2021 mac. All rights reserved.
//

import Foundation
import UIKit

class AlertView: UIView {
    
    var blurEffectView: UIVisualEffectView?
    var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    weak var delegate: BageDelegate?
    
    //      let viewPlus: UIView = {
    //          let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    //          view.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    //          view.translatesAutoresizingMaskIntoConstraints = false
    //          view.layer.cornerRadius = 20
    //          return view
    //      }()
    
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
        
        btn.addTarget(self, action: #selector(AlertView.forSavebutton), for: .touchUpInside)
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
        
        btn.addTarget(self, action: #selector(AlertView.forCancelbutton), for: .touchUpInside)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.createNewPart()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func forSavebutton() {
        
        if self.nameTextField.text!.count > 0 {
            let count = "1"
            let seller = "Other"
            CoreDataManager.sharedManager.saveChoicePart(name: self.nameTextField.text!, count: count, price: nil, seller: seller)
            
            self.viewShow.removeFromSuperview()
            self.nameTextField.text = ""
            self.blurEffectView?.effect = nil
            self.blurEffectView?.removeFromSuperview()
            
            self.delegate?.setBage()
            self.removeFromSuperview()
        }
    }
    
    @objc func forCancelbutton() {
        self.viewShow.removeFromSuperview()
        self.nameTextField.text = ""
        self.blurEffectView?.effect = nil
        self.blurEffectView?.removeFromSuperview()
        self.removeFromSuperview()
    }
    
    func createNewPart() {
        
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        self.blurEffectView!.frame = self.bounds
        self.blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.blurEffectView!)
        
        self.addSubview(self.viewShow)
        
        viewShow.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        viewShow.topAnchor.constraint(equalTo: self.topAnchor,constant: self.frame.height * 0.2).isActive = true
        viewShow.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
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
}
