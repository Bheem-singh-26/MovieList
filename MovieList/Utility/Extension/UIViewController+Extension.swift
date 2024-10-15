//
//  UIViewController+Extension.swift
//  MovieList
//
//  Created by Bheem Singh on 15/10/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))

        self.present(alert, animated: true)
    }
    
}
