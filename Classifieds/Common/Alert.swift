//
//  Alert.swift
//  Classifieds
//
//  Created by Fatima on 26/11/2021.
//

import UIKit

class Alert {
    static func showErrorMessage(message: String) {
        guard !message.isEmpty else { return }
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        Helper.topController()?.present(alert, animated: true, completion: nil)
    }
}
