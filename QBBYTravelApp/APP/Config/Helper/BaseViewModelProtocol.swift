//
//  BaseViewModelProtocol.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import Toast_Swift

protocol BaseViewModelProtocol: AnyObject {
    func showError(message: String)
    func showAlert(message: String)
    func showLoader()
    func hideLoader()
    func showToast(message: String)
    func showErrorScreen(msg: String, isSplash: Bool, completion: @escaping () -> Void)
    func showPositionalToast(message: String, position: ToastPosition)
    var viewController: UIViewController { get }
}
extension BaseViewModelProtocol {
    func showError(message: String) {}
    func showAlert(message: String) {}
    func showLoader() {}
    func hideLoader() {}
    func showToast(message: String) {}
    func showErrorScreen(msg: String, isSplash: Bool, completion: @escaping () -> Void) {}
    func showPositionalToast(message: String, position: ToastPosition) {}
    var viewController: UIViewController { return UIViewController() }
    
}
extension UIViewController: BaseViewModelProtocol {
    
    var viewController: UIViewController {
        return self
    }
    func showToast(message: String) {
        var style = ToastStyle()
        style.messageAlignment = .center
        style.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        style.messageFont = UIFont.oswaldRegular(size: 14)
        style.messageColor = UIColor.WhiteColor
        
        ToastManager.shared.style = style
        ToastManager.shared.position = .bottom
        self.view.makeToast(message, duration: 4)
    }
    
    func showPositionalToast(message: String, position: ToastPosition) {
        if message.isEmpty {
            return
        }
        var style = ToastStyle()
        
        style.messageAlignment = .center
        style.backgroundColor = UIColor.white
        style.messageFont = UIFont.oswaldRegular(size: 12)
        style.messageColor = UIColor.black
        
        ToastManager.shared.style = style
        ToastManager.shared.position = position
        
        self.view.makeToast(message, duration: 1.5)
        
    }
    func showLoader() {
        Loader.showAdded(to: self.view, animated: true)
    }
    
    func hideLoader() {
        Loader.hide(for: self.view, animated: true)
    }
}

