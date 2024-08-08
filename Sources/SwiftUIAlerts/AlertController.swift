//
//  AlertController.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

@Observable
public class AlertController {
    
    var alertDetails: AlertDetails?
    
    /// Presents an alert / confirmation dialog
    /// - Parameters:
    ///   - type: Type, defaults to `.alert`
    ///   - title: Title, defaults to empty String
    ///   - message: Message, defaults to empty String
    ///   - buttons: Buttons, defaults to on OK button
    public func present(_ type: AlertType = .alert, title: String = "", message: String = "", buttons: [AlertButton] = [AlertButton(.ok)]) {
        if type == .alert, title == "", message == "" {
            fatalError("Alerts should have at least a title or a message")
        }
        self.alertDetails = AlertDetails(type: type, title: title, message: message, buttons: buttons)
    }
    
    /// Presents an error alert
    /// - Parameters:
    ///   - type: Type, defaults to `.alert`
    ///   - title: Title, defaults to "Error"
    ///   - error: Error
    ///   - buttons: Buttons, defaults to on OK button
    public func present(_ type: AlertType = .alert, title: String = "Error", error: Error, buttons: [AlertButton] = [AlertButton(.ok)]) {
        self.alertDetails = AlertDetails(type: type, title: title, message: error.localizedDescription, buttons: buttons)
    }
}
