//
//  UIViewControllerExtension.swift
//  glamera
//
//  Created by Smart Zone on 12/23/19.
//  Copyright © 2019 Kerolos Rateeb. All rights reserved.
//

import UIKit

extension UIViewController {
    class func viewController(withStoryboard storyboard: Storyboard , AndContollerID id: String? = nil) -> UIViewController? {
        
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        let controller: UIViewController?
        if let contollerID  = id {
            controller = storyboard.instantiateViewController(withIdentifier: contollerID)
        } else {
            controller = storyboard.instantiateInitialViewController()
        }
        return controller
    }
    
    class func withIdentifier(identifier:String) -> UIViewController {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        return storyBoard.instantiateViewController(withIdentifier:identifier)
    }
    
    
    func goTo<T:UIViewController>(viewControllerClass:T.Type, storyboardName:String = "Main",withIdentifier Identifier:String)->T? {
        if let vc = UIStoryboard.init(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: Identifier) as? T {
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            return vc
        }
        return nil
    }
    
}
