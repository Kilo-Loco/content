//
//  AlertService.swift
//  migrating-to-combine
//
//  Created by Kilo Loco on 10/13/20.
//

import UIKit

enum AlertService {
    
    static func showAlert(with message: String, in viewController: UIViewController?) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(
            .init(title: "OK", style: .cancel)
        )
        viewController?.present(alert, animated: true)
    }
}
