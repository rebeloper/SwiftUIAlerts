//
//  AlertControllerModifier.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

struct AlertControllerModifier: ViewModifier {
    
    @Environment(\.alertController) private var alertController
    @State private var isAlertPresented = false
    @State private var isConfirmationDialogPresented = false
    
    func body(content: Content) -> some View {
        content
            .alert(alertController.alertDetails?.title ?? "", isPresented: $isAlertPresented, actions: buttons, message: message)
            .confirmationDialog(alertController.alertDetails?.title ?? "", isPresented: $isConfirmationDialogPresented, actions: buttons, message: message)
            .onChange(of: alertController.alertDetails) { _, newValue in
                guard let newValue else { return }
                switch newValue.type {
                case .alert:
                    isAlertPresented = true
                case .confirmationDialog:
                    isConfirmationDialogPresented = true
                }
            }
            .onChange(of: isAlertPresented) { _, newValue in
                if !newValue {
                    alertController.alertDetails = nil
                }
            }
            .onChange(of: isConfirmationDialogPresented) { _, newValue in
                if !newValue {
                    alertController.alertDetails = nil
                }
            }
    }
    
    func buttons() -> some View {
        ForEach(alertController.alertDetails?.buttons ?? []) { button in
            Button(button.title, role: button.role) {
                button.action?()
            }
        }
    }
    
    func message() -> some View {
        Text(alertController.alertDetails?.message ?? "")
    }
}
