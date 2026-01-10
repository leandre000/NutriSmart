//
//  NutritionistView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct NutritionistView: View {
    @StateObject private var viewModel = NutritionistViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(viewModel.nutritionists) { nutritionist in
                            NutritionistCard(nutritionist: nutritionist) {
                                viewModel.requestAdvice(from: nutritionist)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("nutritionists".localized)
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $viewModel.isChatActive) {
                if let nutritionist = viewModel.selectedNutritionist {
                    ChatView(viewModel: viewModel, nutritionist: nutritionist)
                }
            }
        }
    }
}

struct NutritionistCard: View {
    let nutritionist: Nutritionist
    let onRequestAdvice: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 16) {
                SafeImage(nutritionist.imageName, placeholder: "person.circle.fill", contentMode: .fill)
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(AppTheme.primaryGreen, lineWidth: 3)
                    )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(nutritionist.name)
                        .font(.headline)
                        .fontWeight(.bold)
                    
                    Text(nutritionist.specialization)
                        .font(.subheadline)
                        .foregroundColor(AppTheme.primaryGreen)
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(nutritionist.rating) ? "star.fill" : "star")
                                .foregroundColor(AppTheme.accentYellow)
                                .font(.caption)
                        }
                        Text("\(String(format: "%.1f", nutritionist.rating))")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            
            Text(nutritionist.bio)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            HStack(spacing: 20) {
                Label("\(nutritionist.experience) " + "years".localized, systemImage: "calendar.fill")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Label(nutritionist.languages.joined(separator: ", "), systemImage: "globe")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Button(action: onRequestAdvice) {
                HStack {
                    Spacer()
                    Text("request_advice".localized)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .primaryButtonStyle()
            }
            .disabled(!nutritionist.available)
            .opacity(nutritionist.available ? 1.0 : 0.6)
        }
        .padding(20)
        .cardStyle()
    }
}

struct ChatView: View {
    @ObservedObject var viewModel: NutritionistViewModel
    let nutritionist: Nutritionist
    @State private var messageText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Messages
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.chatMessages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                        }
                        .padding()
                    }
                    .onChange(of: viewModel.chatMessages.count) { _ in
                        if let lastMessage = viewModel.chatMessages.last {
                            withAnimation {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                }
                
                // Input
                HStack(spacing: 12) {
                    TextField("type_message".localized, text: $messageText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.sendMessage(messageText)
                        messageText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(.blue)
                            .font(.title3)
                    }
                    .disabled(messageText.isEmpty)
                }
                .padding()
                .background(Color(.systemGray6))
            }
            .navigationTitle(nutritionist.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("done".localized) {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
            }
            
            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .padding()
                    .background(message.isFromUser ? Color.blue : Color(.systemGray5))
                    .foregroundColor(message.isFromUser ? .white : .primary)
                    .cornerRadius(16)
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.7, alignment: message.isFromUser ? .trailing : .leading)
            
            if !message.isFromUser {
                Spacer()
            }
        }
    }
}

