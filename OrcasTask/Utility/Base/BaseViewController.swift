//
//  BaseViewController.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import UIKit

protocol NavigationControllerHelpers {
    func setNavigationBarBackgroundImage(image: String)
    func setLargeNavigationBarBackground(with image: String)
    func navigationBar(color: UIColor?)
    func changeAllBarBackButton(color: UIColor?)
    func setNavigationBarTitle(text: String, color: UIColor?)
    func setupNavBar()
    func navigationBarClearColor()
    func hideNavigationBar(hideBar: Bool, hideBackButton: Bool)
    func removeNavigationBorder()
    func setImageViewNavigationBar(image: String)
}

protocol NavigationBarButtons {
    func initBackPresent( color: UIColor?)
    func initBackPuch( color: UIColor?)
    func initSkipBarButton()
    func initBackButton(title: String, color: UIColor)
}

protocol TransactionsMethods {
    func presentMainStoryboard()
    func rootToMainStoryboard()
}

protocol BaseActions {
    func onPopup()
    func onDismiss()
    func onDismissKeyboard()
    func onDismissKeyboardGesture(sender: UITapGestureRecognizer)
}

class BaseViewController: UIViewController ,Loadable{
    
    //MARK: - Properties
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var refreshControl = UIRefreshControl()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Helpers
    func setup() {
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func pullToRefresh(add view: UIView) {
        // set up the refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handleRefreshControlAction), for: .valueChanged)
        view.addSubview(refreshControl)
    }
    
    @objc func handleRefreshControlAction() {
        refreshControl.endRefreshing()
        print("Refresh")
        
    }
    
    private func onDisconnect() {
        let alert = UIAlertController(title: "Error".localizedString, message: "No internet connection".localizedString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done".localizedString, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func hideLoadingInticatorAlert(withErrorMessage: String){
        hideLoadingInticator()
        let alert = UIAlertController(title: "Error".localizedString, message: "No internet connection".localizedString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done".localizedString, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension BaseViewController: ServiceDelegate {
    func didReceiveDataSuccessfully(data: Any?, identifier: String) {
        hideLoadingInticator()
    }
    
    func didFailToReceiveData(error: Error?, identifer: String) {
        guard let error = error else { hideLoadingInticator(); return }
        hideLoadingInticator()
        let noInternetWithMandatoryConnection = MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.NoInternet(mandatory: true))
        let expiredSession = MCError.NetworkFaild(reason: MCError.NetworkFaildReasons.ExpiredSession(mandatory: true))
        _ = MCError.BackendFaild(reason: "Your request is currently unavailable".localizedString)
        
        
        
        if error.localizedDescription ==  noInternetWithMandatoryConnection.localizedDescription {
            self.hideLoadingInticatorAlert(withErrorMessage: "لا يوجد اتصال بالانترنت ,حاول مرة اخري")
            
        }else if error.localizedDescription == MCError.phoneNotVerified.localizedDescription {
            print("phoneNotVerified  phoneNotVerified  phoneNotVerified")
            
        }else if error.localizedDescription == MCError.underMaintenance.localizedDescription {
            hideLoadingInticator()
            
        }else if error.localizedDescription ==  expiredSession.localizedDescription {
            //            if identifer == Endpoint.user.login.path {
            //
            //            }else {
            hideLoadingInticator()
            //               // LogoutUser()
            //            }
            
            
        }else {
            self.hideLoadingInticatorAlert(withErrorMessage: error.localizedDescription)
        }
    }
}

// MARK: - navigation bar
extension BaseViewController: NavigationControllerHelpers {
    
    func setNavigationBarBackgroundImage(image: String) {
        if let img = UIImage(named: image) {
            navigationController?.navigationBar.setBackgroundImage(img.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
    }
    
    func setLargeNavigationBarBackground(with image: String) {
        if let image = UIImage(named: image) {
            self.navigationController?.navigationBar.barTintColor = UIColor(patternImage: image)
        }
    }
    
    func navigationBar(color: UIColor?) {
        hideNavigationBar(hideBar: false, hideBackButton: false)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = color
    }
    
    func changeAllBarBackButton(color: UIColor?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = color
        
        if let font = UIFont(name: "SFProDisplay-Medium", size: 18) {
            backItem.setTitleTextAttributes([NSAttributedString.Key.font:font], for: .normal)
        }else {
            print("Font Not available")
        }
        
        /*Changing color*/
        backItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.App.primary], for: .normal)
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "Icon_Arrow-Left")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "Icon_Arrow-Left")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    func setNavigationBarTitle(text: String, color: UIColor?) {
        let lbl = UILabel()
        lbl.text = text
        lbl.textColor = color ?? .red
        if let font = UIFont(name: "SFProDisplay-Medium", size: 18) {
            lbl.font = font
        }
        self.navigationItem.titleView = lbl
    }
    
    func setupNavBar() {
        var darkMode = false
        var preferredStatusBarStyle : UIStatusBarStyle {
            return darkMode ? .default : .lightContent
        }
        
        // Change navigation bar color
        navigationController?.navigationBar.isTranslucent = false
        //        navigationController?.navigationBar.barTintColor = UIColor.remeny.primary
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 15) ?? UIFont.systemFont(ofSize: 15),NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func navigationBarClearColor() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func hideNavigationBar(hideBar: Bool, hideBackButton: Bool) {
        self.navigationController?.isNavigationBarHidden = hideBar
        self.navigationItem.hidesBackButton = hideBackButton
    }
    
    func removeNavigationBorder() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setImageViewNavigationBar(image: String) {
        let image = UIImage(named: image)
        let imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 0, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
    }
    
}


extension BaseViewController: NavigationBarButtons {
    func initBackPuch(color: UIColor?) {
        var imageName = "back"
        if Language.currentLanguage() == "ar" {
            imageName = "backAr"
        }
        
        let image = UIImage.init(named: imageName)
        
        let btn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(self.onPopup))
        btn.tintColor = color ?? .white
        navigationItem.leftBarButtonItem = btn
    }
    
    func initBackPresent(color: UIColor? = UIColor.init(hex: "4137AE")) {
        var imageName = "back"
        if Language.currentLanguage() == "ar" {
            imageName = "backAr"
        }
        
        let image = UIImage.init(named: imageName)
        
        let btn = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(self.onDismiss))
        btn.tintColor = color
        navigationItem.leftBarButtonItem = btn
    }
    
    func initSkipBarButton() {
        let button = UIButton.init(type: .custom)
        button.setTitle("Skip".localizedString, for: .normal)
        button.addTarget(self, action: #selector(onDismiss), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func initBackButton(title: String, color: UIColor) {
        let button = UIButton(type: .system)
        
        var image = "Icon_Arrow-Left"
        if Language.currentLanguage() == "ar" {
            image = "backAr"
        }
        
        button.setImage(UIImage(named: image), for: .normal)
        button.setTitle(title.localizedString, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        button.tintColor = color
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(onDismiss), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
}

extension BaseViewController: BaseActions {
    @objc func onPopup() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func onDismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func onDismissKeyboardGesture(sender: UITapGestureRecognizer) {
        onDismissKeyboard()
    }
    
}


extension BaseViewController: TransactionsMethods {
    @objc func presentMainStoryboard() {
        
    }
    
    func rootToMainStoryboard() {
        //        guard let vc = UIViewController.viewController(withStoryboard: .Main, AndContollerID: "MainTB") else { return }
        //        appDelegate.window?.rootViewController = vc
        //        appDelegate.window?.makeKeyAndVisible()
    }
}
