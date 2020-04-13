//
//  QrCodeController.swift
//  MyGarage
//
//  Created by user on 04.03.2020.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import Parse

class QrCodeController: UIViewController {
    
    weak var delegate: ViewLIneProtocol?
    let tagLine = 1
    var video = AVCaptureVideoPreviewLayer()
    //1 Настраиваем сесию
    let session = AVCaptureSession()
    
    //    lazy var createButton: UIButton = {
    //           let button = UIButton(type: .system)
    //           button.translatesAutoresizingMaskIntoConstraints = false
    //           button.tintColor = .black
    //        button.setImage(UIImage(systemName: "qrcode", withConfiguration: UIImage.SymbolConfiguration(scale: .large)), for: .normal)
    //           button.contentMode = .scaleAspectFill
    //        button.addTarget(self, action: #selector(QrCodeController.startRunnig), for: .touchUpInside)
    //           return button
    //       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInit()
        self.setupVideo()
        self.setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
              NotificationCenter.default.post(name: NSNotification.Name(rawValue: "lineWiev1"), object: nil)
        self.delegate?.moveLine(tag: self.tagLine)
        print("tag \(self.tagLine)")
    }
    
    private func setupNavBar() {
        let imageLog = UIImage(named: "log-out")
        let imageTempLog = imageLog?.withRenderingMode(.alwaysTemplate)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: imageTempLog, style: .plain, target: self, action: #selector(QrCodeController.backButton))
        
        let imageCod = UIImage(systemName: "qrcode", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: imageCod, style: .plain, target: self, action: #selector(QrCodeController.startRunnig))
        
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
    
    private func setupInit() {
        HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
        navigationController?.navigationBar.backgroundColor = MySettings.shared.gcolorNavBar
    }
    
    func setupVideo() {
        
        // 2 Настраиваем устройство видео
        //работает только на реальном устройстве
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        // 3 Настраиваем инпут
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }
        //4 настроим output
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        //5
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
    }
    
    @objc func startRunnig() {
        view.layer.addSublayer(video)
        session.startRunning()
    }
}

extension QrCodeController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Перейти", style: .default, handler: { (action) in
                    print(object.stringValue!)
                    
                    let nextVC = WebController(text: object.stringValue!)
                    
                    self.view.layer.sublayers?.removeLast()
                    self.session.stopRunning()
                    
                    nextVC.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Копировать", style: .default, handler: { (action) in
                    UIPasteboard.general.string = object.stringValue
                    print(object.stringValue!)
                    
                    // чтоб вернутся на основной екран после нажатия на кнопку копировать
                                       self.view.layer.sublayers?.removeLast()
                                       self.session.stopRunning()
                    
                }))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
