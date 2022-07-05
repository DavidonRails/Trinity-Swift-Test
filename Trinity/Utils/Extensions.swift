//
//  Extensions.swift
//  Trinity
//
//  Created by Admin on 2022/7/5.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .`default`, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertCallback(title: String, msg: String, completion: @escaping (UIAlertAction)->(Void)) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .`default`, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
