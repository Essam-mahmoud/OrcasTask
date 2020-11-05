
import UIKit
import MBProgressHUD

protocol Loadable {
  func showLoadingInticator(_ message: String, isAppFreezed: Bool)
  func hideLoadingInticator()
  func hideLoadingInticator(withErrorMessage message: String)
}

extension Loadable {
  func hideLoadingInticator(withErrorMessage message: String) {
     
  }
}

extension Loadable where Self: UIViewController {
   
  func showLoadingInticatorFlash(_ message: String, delay: Double, isAppFreezed: Bool = false) {
     
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.center = self.view.center
    hud.label.text = message
    hud.label.numberOfLines = 0
    hud.contentColor = UIColor.init(hex: "4137AE")
    hud.customView = nil
    hud.mode = MBProgressHUDMode.customView
    hud.show(animated: true)
    hud.hide(animated: true, afterDelay: delay)
    hud.isUserInteractionEnabled = false
    UIApplication.shared.endIgnoringInteractionEvents()
    if isAppFreezed {
      UIApplication.shared.beginIgnoringInteractionEvents()
    }

  }
   
  func showLoadingInticator(_ message: String = "Loading".localizedString, isAppFreezed: Bool = false) {
    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
    hud.label.text = message
    hud.contentColor = UIColor.init(hex: "4137AE")
    hud.isUserInteractionEnabled = false
    if isAppFreezed {
      UIApplication.shared.beginIgnoringInteractionEvents()
    }
  }
   
  func hideLoadingInticator() {
    MBProgressHUD.hide(for: self.view, animated: true)
    UIApplication.shared.endIgnoringInteractionEvents()
  }
   
  func hideLoadingInticator(withErrorMessage message: String) {
    hideLoadingInticator()
    let alert = UIAlertController(title: "Error".localizedString, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Oki".localizedString, style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

extension UITableViewCell: Loadable {
   
  func showLoadingInticator(_ message: String = "", isAppFreezed: Bool = false) {
    let hud = MBProgressHUD.showAdded(to: self.contentView, animated: true)
    hud.label.text = message
    hud.contentColor = UIColor.App.primary
    hud.isUserInteractionEnabled = false
  }
   
  func hideLoadingInticator() {
    MBProgressHUD.hide(for: self.contentView, animated: true)
  }
}

extension UICollectionViewCell: Loadable {
   
  func showLoadingInticator(_ message: String = "", isAppFreezed: Bool = false) {
    let hud = MBProgressHUD.showAdded(to: self.contentView, animated: true)
    hud.label.text = message
    hud.contentColor = UIColor.App.primary
    hud.isUserInteractionEnabled = false
  }
   
  func hideLoadingInticator() {
    MBProgressHUD.hide(for: self.contentView, animated: true)
  }
}
