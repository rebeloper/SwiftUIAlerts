//
//  EnvironmentValues+.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import SwiftUI

public extension EnvironmentValues {
    
    /// Environment to present alerts / confrimation dialogs
    var alertController: AlertController {
        get {
            return self[AlertControllerKey.self]
        }
        set {
            self[AlertControllerKey.self] = newValue
        }
    }
}
