//
//  WebController.swift
//  MyGarage
//
//  Created by mac on 19.02.2020.
//  Copyright © 2020 mac. All rights reserved.
//
// https://www.spaceotechnologies.com/create-web-browser-wkwebview-ios-tutorial/
// https://tproger.ru/articles/localizations-in-swift/

import Foundation
import WebKit

class WebController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView?
    var strContent: String?
    
    init(text: String) {
        super.init(nibName: nil, bundle: nil)
        self.strContent = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView!.navigationDelegate = self
        view = webView
//        self.createWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        webView?.navigationDelegate = self
        self.setupBgColor()
        self.setupInitData()
        self.createToolBar()
//        tabBarController?.tabBar.tabsVisiblti(false)
//        tabBarController?.setTabBarVisible(visible: false, animated: true)
 //       self.toolBarHeight(visible: false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.toolbar.isHidden = false
 
//        UIView.animate(withDuration: 0.2, animations: {
//            self.tabBarController?.tabBar.alpha = 0
//        }) { ( _ ) in
//            self.tabBarController?.tabBar.isHidden = true
//        }
        
    }
    
    private func setupBgColor() {
         HelperMethods.shared.setBackGround(view: self.view, color1: MySettings.shared.gcolor1, color2: MySettings.shared.gcolor2, color3: MySettings.shared.gcolor3)
    }
    
    private func setupInitData() {
        var strForUrl = "https://www.google.com"
        if let url = self.strContent {
            strForUrl = url
        }
        
        print("\(strForUrl)")
        let url = URL(string: strForUrl)
        let myRequest = URLRequest(url: url!)
        webView!.load(myRequest)
        webView!.allowsBackForwardNavigationGestures = true
    }
    
    func removeUnderline(searchText: String) -> String {
        let escapedSearchText = searchText.replacingOccurrences(of: " ", with: "_")
        return escapedSearchText
    }
    
    private func createWebView() {
//        view.addSubview(webView!)
        webView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        webView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        webView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        webView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
       
    }
    
        private func createToolBar() {
    
            self.navigationController?.isToolbarHidden = false
            self.navigationController?.toolbar.backgroundColor = .clear
            self.navigationController?.toolbar.barTintColor = #colorLiteral(red: 0.9665722251, green: 0.9766036868, blue: 0.9875525832, alpha: 1).withAlphaComponent(0.96)
//            self.navigationController?.toolbar.barTintColor = HelperMethods.shared.hexStringToUIColor(hex: "#74b9ff")
            var items = [UIBarButtonItem]()
    
            let scaleConfig = UIImage.SymbolConfiguration(scale: .large)
            let imageback = UIImage(systemName: "chevron.left.2", withConfiguration: scaleConfig)!
            let imageTemp1 = imageback.withRenderingMode(.alwaysTemplate)
            let back = UIBarButtonItem(image: imageTemp1, style: .plain, target: self, action: #selector(WebController.backButton))
            
            let imageForvard = UIImage(systemName: "chevron.right.2", withConfiguration: scaleConfig)!
            let imageTemp2 = imageForvard.withRenderingMode(.alwaysTemplate)
            let forvard = UIBarButtonItem(image: imageTemp2, style: .plain, target: self, action: #selector(WebController.forvardButton))
            
            let imageReload = UIImage(systemName: "arrow.clockwise", withConfiguration: scaleConfig)!
            let imageTemp3 = imageReload.withRenderingMode(.alwaysTemplate)
            let reload = UIBarButtonItem(image: imageTemp3, style: .plain, target: self, action: #selector(WebController.forvardButton))
    
            items.append(back)
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            items.append(forvard)
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            items.append(reload)
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            items.append( UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil))
            self.toolbarItems = items
        }
    
    @objc func backButton() {
        if webView!.canGoBack {
            webView?.goBack()
        }
    }
    
    @objc func forvardButton() {
        if webView!.canGoForward {
           webView?.goForward()
        }
    }
    
    @objc func reloadButton() {
        webView?.reload()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
           self.toolbarItems![0].isEnabled = false
           self.toolbarItems![2].isEnabled = false
       }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.canGoBack {
            self.toolbarItems![0].isEnabled = true
        } else if webView.canGoForward {
            self.toolbarItems![2].isEnabled = true
        }
    }
    
//    deinit {
//        navigationController?.toolbar.isHidden = true
//    }
    
//    func toolBarHeight(visible:Bool, animated:Bool) {
//        let frame = navigationController?.toolbar.frame
//        let height = frame!.size.height
//        let offsetY = (visible ? -height : height)
//        UIView.animate(withDuration: animated ? 0.3 : 0.0) {
//            self.navigationController?.toolbar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
//         self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
//            self.view.setNeedsDisplay()
//            self.view.layoutIfNeeded()
//        }
//    }
    
}

//extension UITabBar {
//    func tabsVisiblti( _ isVisiblty: Bool) {
//        if isVisiblty {
//            self.isHidden = false
//            self.layer.zPosition = 0
//        } else {
//            self.isHidden = true
//            self.layer.zPosition = -1
//        }
//    }
//}

//extension UITabBarController {
//       func setTabBarVisible(visible:Bool, animated:Bool) {
//           let frame = self.tabBar.frame
//           let height = frame.size.height
//           let offsetY = (visible ? -height : height)
//        UIView.animate(withDuration: animated ? 0.3 : 0.0) {
//            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
//            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height + offsetY)
//               self.view.setNeedsDisplay()
//               self.view.layoutIfNeeded()
//           }
//       }
//}
