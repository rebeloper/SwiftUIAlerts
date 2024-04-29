//
//  AlertButton.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public struct AlertButton: Identifiable {
    public let id = UUID()
    
    public let title: String
    public let role: ButtonRole?
    public let action: (() -> Void)?
    
    public init(title: String, role: ButtonRole? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.role = role
        self.action = action
    }
}
