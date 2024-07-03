//
//  UsesAlertControllerModifier.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

struct UsesAlertControllerModifier: ViewModifier {
    
    @State private var alertController = AlertController()
    
    func body(content: Content) -> some View {
        content
            .modifier(AlertControllerModifier())
            .environment(\.alertController, alertController)
    }
}

struct UsesAlertControllerInModalModifier: ViewModifier {
    
    @Environment(\.alertController) private var alertController
    
    func body(content: Content) -> some View {
        content
            .environment(\.alertController, alertController)
    }
}
