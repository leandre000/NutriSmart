//
//  SettingsView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var languageManager = LanguageManager.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                Form {
                    Section(header: Text("language".localized)) {
                        ForEach(AppLanguage.allCases) { language in
                            Button(action: {
                                withAnimation(.friendlySpring) {
                                    languageManager.currentLanguage = language
                                }
                            }) {
                                HStack {
                                    Text(language.nativeName)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    if languageManager.currentLanguage == language {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(AppTheme.primaryGreen)
                                            .font(.title3)
                                    }
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("about".localized)) {
                        HStack {
                            Text("version".localized)
                            Spacer()
                            Text("2.0.0")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                        }
                        
                        HStack {
                            Text("build".localized)
                            Spacer()
                            Text("2")
                                .foregroundColor(.secondary)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .navigationTitle("settings".localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done".localized) {
                        dismiss()
                    }
                    .foregroundColor(AppTheme.primaryGreen)
                }
            }
        }
    }
}

extension String {
    static let about = "about"
    static let version = "version"
    static let build = "build"
    static let settings = "settings"
}

