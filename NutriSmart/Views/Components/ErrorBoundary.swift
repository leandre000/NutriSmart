//
//  ErrorBoundary.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct ErrorBoundary<Content: View>: View {
    @State private var hasError = false
    @State private var error: Error?
    let content: () -> Content
    
    var body: some View {
        if hasError {
            ErrorView(
                error: error as? AppError ?? .dataLoadingFailed,
                retryAction: {
                    hasError = false
                    error = nil
                }
            )
        } else {
            content()
                .onAppear {
                    // Catch any errors
                }
        }
    }
}


