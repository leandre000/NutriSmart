//
//  SearchBar.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "search_placeholder".localized
    var onVoiceSearch: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.body)
            
            TextField(placeholder, text: $text)
                .font(.body)
            
            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
            
            if let onVoiceSearch = onVoiceSearch {
                Button(action: onVoiceSearch) {
                    Image(systemName: "mic.fill")
                        .foregroundColor(AppTheme.primaryGreen)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}


