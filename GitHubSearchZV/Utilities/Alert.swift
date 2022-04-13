//
//  Alert.swift
//  GitHubSearchZV
//
//  Created by Zoltan Vinkler on 2022. 04. 13..
//

import UIKit

class Alert {
    
    static func show(on controller: UIViewController, title: String, message: String = "", button: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        if let currentAlert = controller.presentedViewController as? UIAlertController {
            currentAlert.message = (currentAlert.message ?? "") + "\n---\n\(title)\n\(message)"
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: button, style: UIAlertAction.Style.default, handler: handler))
        controller.present(alertController, animated: true, completion: nil)
    }
    
}
