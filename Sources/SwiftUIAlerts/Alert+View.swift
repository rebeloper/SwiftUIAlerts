//
//  Alert+View.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public extension View {
    
    /// Sets up the `alertController` as an `Environment`
    func usesAlertController() -> some View {
        modifier(UsesAlertControllerModifier())
    }
    
    /// Presents a sheet with an `alertController` as an `Environment` when a binding to a Boolean value that you
    /// provide is true.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the sheet that you create in the modifier's
    ///     `content` closure.
    ///   - onDismiss: The closure to execute when dismissing the sheet.
    ///   - content: A closure that returns the content of the sheet.
    func sheetWithAlert<Content: View>(isPresented: Binding<Bool>,
                                       onDismiss: (() -> Void)? = nil,
                                       @ViewBuilder content: @escaping () -> Content) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            content().usesAlertController()
        }
    }
    
    /// Presents a sheet with an `alertController` as an `Environment` using the given item as a data source
    /// for the sheet's content.
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the sheet.
    ///     When `item` is non-`nil`, the system passes the item's content to
    ///     the modifier's closure. You display this content in a sheet that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the sheet and replaces it with a new one
    ///     using the same process.
    ///   - onDismiss: The closure to execute when dismissing the sheet.
    ///   - content: A closure returning the content of the sheet.
    func sheetWithAlert<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                           onDismiss: (() -> Void)? = nil,
                                                           @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self.sheet(item: item, onDismiss: onDismiss) { item in
            content(item).usesAlertController()
        }
    }
#if !os(macOS)
    /// Presents a modal view with an `alertController` as an `Environment` that covers as much of the screen as
    /// possible when binding to a Boolean value you provide is true.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether
    ///     to present the sheet.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure that returns the content of the modal view.
    func fullScreenCoverWithAlert<Content: View>(isPresented: Binding<Bool>,
                                                 onDismiss: (() -> Void)? = nil,
                                                 @ViewBuilder content: @escaping () -> Content) -> some View {
        self.fullScreenCover(isPresented: isPresented, onDismiss: onDismiss) {
            content().usesAlertController()
        }
    }
    
    /// Presents a modal view with an `alertController` as an `Environment` that covers as much of the screen as
    /// possible using the binding you provide as a data source for the
    /// sheet's content.
    /// - Parameters:
    ///   - item: A binding to an optional source of truth for the sheet.
    ///     When `item` is non-`nil`, the system passes the contents to
    ///     the modifier's closure. You display this content in a sheet that you
    ///     create that the system displays to the user. If `item` changes,
    ///     the system dismisses the currently displayed sheet and replaces
    ///     it with a new one using the same process.
    ///   - onDismiss: The closure to execute when dismissing the modal view.
    ///   - content: A closure returning the content of the modal view.
    func fullScreenCoverWithAlert<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                                     onDismiss: (() -> Void)? = nil,
                                                                     @ViewBuilder content: @escaping (Item) -> Content) -> some View {
        self.fullScreenCover(item: item, onDismiss: onDismiss) { item in
            content(item).usesAlertController()
        }
    }
#endif
}
