//
//  AlertController.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public class AlertController: ObservableObject {
    
    @Published var alertDetails: AlertDetails?
    
    /// Presents an alert / confirmation dialog
    /// - Parameters:
    ///   - type: Type, defaults to `.alert`
    ///   - title: Title
    ///   - message: Message
    ///   - buttons: Buttons, defaults to on OK button
    @MainActor public func present(_ type: AlertType = .alert, title: String, message: String, buttons: [AlertButton] = [AlertButton(title: "OK")]) {
        self.alertDetails = AlertDetails(type: type, title: title, message: message, buttons: buttons)
    }
    
    /// Presents an error alert
    /// - Parameters:
    ///   - type: Type, defaults to `.alert`
    ///   - title: Title
    ///   - error: Error
    ///   - buttons: Buttons, defaults to on OK button
    @MainActor public func present(_ type: AlertType = .alert, title: String = "Error", error: Error, buttons: [AlertButton] = [AlertButton(title: "OK")]) {
        self.alertDetails = AlertDetails(type: type, title: title, message: error.localizedDescription, buttons: buttons)
    }
}
