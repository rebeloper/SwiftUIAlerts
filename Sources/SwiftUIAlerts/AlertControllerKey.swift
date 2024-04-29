//
//  AlertControllerKey.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public struct AlertControllerKey: EnvironmentKey {
    @MainActor
    public static let defaultValue = AlertController()
}
