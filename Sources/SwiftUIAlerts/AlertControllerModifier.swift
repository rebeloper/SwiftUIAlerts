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
            .onReceive(of: alertController.alertDetails) { newValue in
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

private struct ContinousObservationModifier<T>: ViewModifier {
    
    init(_ value: T?, perform: @escaping (T?) async -> ()) {
        withContinousObservation(of: value, perform: perform)
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    func withContinousObservation(of value: @escaping @autoclosure () -> T?, perform: @escaping (T?) async -> Void) {
        let _ = withObservationTracking {
            Task { @MainActor in
                await perform(value())
            }
        } onChange: {
            Task { @MainActor in
                withContinousObservation(of: value(), perform: perform)
            }
        }
    }
}

private extension View {
    
    /// Adds a modifier for this view that fires an action when a specific
    /// `@Observable` optional value changes.
    /// - Parameters:
    ///   - value: The optional value to check against when determining whether
    ///     to run the closure.
    ///   - perform: An async closure to run when the optional value changes.
    /// - Returns: A view that fires an action when the specified optional value changes.
    func onReceive<T>(of value: T?, perform: @escaping (T?) async -> ()) -> some View {
        self.modifier(ContinousObservationModifier(value, perform: perform))
    }
    
    /// Adds a modifier for this view that fires an action when a specific
    /// `@Observable` value changes.
    /// - Parameters:
    ///   - value: The value to check against when determining whether
    ///     to run the closure.
    ///   - perform: An async closure to run when the value changes.
    /// - Returns: A view that fires an action when the specified value changes.
    func onReceive<T>(of value: T, perform: @escaping (T) async -> ()) -> some View {
        self.modifier(ContinousObservationModifier(value, perform: { value in
            guard let value else { return }
            await perform(value)
        }))
    }
}
