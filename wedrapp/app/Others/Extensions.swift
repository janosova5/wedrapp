//
//  Extensions.swift
//  weatherAppJunior
//
//  Created by ljanosova on 7.1.19.
//  Copyright © 2019 ljanosova. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWith(message: String, title: String = C.Strings.errorTitle.rawValue) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension Double {
    
    func toCelsius() -> Int {
        return Int(self - 273.15)
    }
}

extension UIColor {
    
    static let darkGreen = UIColor(red: 36/255, green: 46/255, blue: 51/255, alpha: 1)
    static let juicyGreen = UIColor(red: 0/255, green: 145/255, blue: 147/255, alpha: 1)
    static let lightGreen = UIColor(red: 195/255, green: 221/255, blue: 221/255, alpha: 1)
}
