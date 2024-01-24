//
//  UIViewController.swift
//  Tracker
//
//  Created by admin on 26.12.2023.
//

import UIKit

extension UIViewController {
    var skipKeyboard: UITapGestureRecognizer {
        let skipKeyboard = UITapGestureRecognizer (
            target: self,
            action: #selector(hideKeyboard))
        skipKeyboard.cancelsTouchesInView = false
        view.addGestureRecognizer(skipKeyboard)
        return skipKeyboard
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}
