//
//  AlertController.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public class AlertController: ObservableObject {
    
    @Published var alertDetails: AlertDetails?
    
    public func present(_ type: AlertType = .alert, title: String, message: String, buttons: [AlertButton] = []) {
        self.alertDetails = AlertDetails(type: type, title: title, message: message, buttons: buttons.count == 0 ? [AlertButton(title: "OK")] : buttons)
    }
    
    public func present(_ type: AlertType = .alert, title: String = "Error", error: Error, buttons: [AlertButton] = []) {
        self.alertDetails = AlertDetails(type: type, title: title, message: error.localizedDescription, buttons: buttons.count == 0 ? [AlertButton(title: "OK")] : buttons)
    }
}
