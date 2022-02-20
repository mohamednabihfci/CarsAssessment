//
//  UIViewController+Extensions.swift
//  CarsAssessment
//
//  Created by AboNabih on 2/20/22.
//

import UIKit

extension UIViewController {

    func showAlert(msg: String, hander:(() -> Void)?) {
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            hander?()
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
