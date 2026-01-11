//
//  MalnutritionRiskView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct MalnutritionRiskView: View {
    @StateObject private var viewModel: MalnutritionRiskViewModel
    @Environment(\.dismiss) var dismiss
    let user: User
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: MalnutritionRiskViewModel(user: user))
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isAssessmentComplete, let assessment = viewModel.currentAssessment {
                    assessmentResultView(assessment)
                } else if viewModel.questions.isEmpty {
                    EmptyStateView(
                        title: "assessment_unavailable".localized,
                        message: "assessment_unavailable_desc".localized,
                        systemImage: "exclamationmark.triangle"
                    )
                } else {
                    assessmentQuestionsView
                }
            }
            .navigationTitle("risk_assessment".localized)
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
    
    private var assessmentQuestionsView: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Progress indicator
                ProgressView(value: Double(viewModel.currentQuestionIndex + 1), total: Double(viewModel.questions.count))
                    .padding(.horizontal)
                    .tint(.blue)
                
                if viewModel.currentQuestionIndex < viewModel.questions.count {
                    let question = viewModel.questions[viewModel.currentQuestionIndex]
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Question \(viewModel.currentQuestionIndex + 1) of \(viewModel.questions.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(question.question)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 8)
                        
                        ForEach(question.options) { option in
                            Button(action: {
                                withAnimation(.spring(response: 0.3)) {
                                    viewModel.answerQuestion(questionId: question.id, optionScore: option.score)
                                }
                            }) {
                                HStack {
                                    Text(option.text)
                                        .foregroundColor(.primary)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .padding(.vertical)
        }
    }
    
    private func assessmentResultView(_ assessment: MalnutritionRiskAssessment) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                // Risk Level Card
                VStack(spacing: 16) {
                    Image(systemName: assessment.riskLevel.icon)
                        .font(.system(size: 60))
                        .foregroundColor(riskColor(assessment.riskLevel))
                    
                    Text(assessment.riskLevel.rawValue + " " + "risk".localized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(riskColor(assessment.riskLevel))
                    
                    Text("score".localized + ": \(assessment.score)/100")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(riskColor(assessment.riskLevel).opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)
                
                // Risk Factors
                if !assessment.factors.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("risk_factors".localized)
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(assessment.factors) { factor in
                            RiskFactorCard(factor: factor)
                                .padding(.horizontal)
                        }
                    }
                }
                
                // Recommendations
                VStack(alignment: .leading, spacing: 12) {
                    Text("recommendations".localized)
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(Array(assessment.recommendations.enumerated()), id: \.offset) { index, recommendation in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 28, height: 28)
                                .background(Color.blue)
                                .clipShape(Circle())
                            
                            Text(recommendation)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                
                Button(action: {
                    withAnimation {
                        viewModel.resetAssessment()
                    }
                }) {
                    Text("retake_assessment".localized)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
    }
    
    private func riskColor(_ level: MalnutritionRiskAssessment.RiskLevel) -> Color {
        switch level {
        case .low: return .green
        case .medium: return .orange
        case .high: return .red
        }
    }
}

struct RiskFactorCard: View {
    let factor: RiskFactor
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.circle.fill")
                .foregroundColor(severityColor)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(factor.category.rawValue)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Text(factor.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    private var severityColor: Color {
        switch factor.severity {
        case 1...2: return .green
        case 3...4: return .orange
        default: return .red
        }
    }
}


