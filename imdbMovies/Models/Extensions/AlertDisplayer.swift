//
//  AlertDisplayer.swift
//  imdbMovie
//
//  Created by Patrick Aloueichek on 2/18/19.
//  Copyright © 2019 Patrick Aloueichek. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDisplayer {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]?)
}

extension AlertDisplayer where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
}
