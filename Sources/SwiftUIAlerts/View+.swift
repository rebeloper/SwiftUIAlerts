//
//  View+.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public extension View {
    func usesAlertController() -> some View {
        modifier(UsesAlertControllerModifier())
    }
}
