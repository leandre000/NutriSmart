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
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(viewModel.nutritionists) { nutritionist in
                        NutritionistCard(nutritionist: nutritionist) {
                            viewModel.requestAdvice(from: nutritionist)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Nutritionists")
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
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Image(nutritionist.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(nutritionist.name)
                        .font(.headline)
                    
                    Text(nutritionist.specialization)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(nutritionist.rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                        Text("\(String(format: "%.1f", nutritionist.rating))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
            }
            
            Text(nutritionist.bio)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Label("\(nutritionist.experience) years", systemImage: "calendar")
                Spacer()
                Label(nutritionist.languages.joined(separator: ", "), systemImage: "globe")
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            Button(action: onRequestAdvice) {
                HStack {
                    Spacer()
                    Text("Request Advice")
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                .background(nutritionist.available ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .disabled(!nutritionist.available)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
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
                    TextField("Type your message...", text: $messageText)
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
                    Button("Done") {
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

