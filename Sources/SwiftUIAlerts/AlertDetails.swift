//
//  AlertDetails.swift
//
//
//  Created by Alex Nagy on 29.04.2024.
//

import Foundation

public struct AlertDetails {
    public let type: AlertType
    public let title: String
    public let message: String
    public let buttons: [AlertButton]
}
