//
//  View+.swift
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
}
