//
//  ErrorHandler.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import Foundation
import SwiftUI

enum AppError: LocalizedError {
    case dataLoadingFailed
    case mealNotFound
    case invalidBudget
    case networkError
    
    var errorDescription: String? {
        switch self {
        case .dataLoadingFailed:
            return "Failed to load data. Please restart the app."
        case .mealNotFound:
            return "Meal not found."
        case .invalidBudget:
            return "Invalid budget amount. Please enter a valid number."
        case .networkError:
            return "Network error. Please check your connection."
        }
    }
}

struct ErrorView: View {
    let error: AppError
    let retryAction: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text(error.localizedDescription)
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let retry = retryAction {
                Button(action: retry) {
                    Text("retry".localized)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}


