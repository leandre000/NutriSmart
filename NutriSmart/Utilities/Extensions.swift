//
//  Extensions.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

extension Date {
    func isSameDay(as date: Date) -> Bool {
        Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

extension Color {
    static let primaryBackground = Color(.systemBackground)
    static let secondaryBackground = Color(.secondarySystemBackground)
}

extension String {
    var localized: String {
        LanguageManager.shared.localized(self)
    }
}

