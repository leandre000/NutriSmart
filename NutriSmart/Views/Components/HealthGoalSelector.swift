//
//  HealthGoalSelector.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct HealthGoalSelector: View {
    @Binding var selectedGoal: HealthGoal
    let goals: [HealthGoal]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(goals, id: \.self) { goal in
                Button(action: {
                    selectedGoal = goal
                }) {
                    HStack {
                        Image(systemName: goal.icon)
                            .foregroundColor(selectedGoal == goal ? .white : .blue)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(goal.rawValue)
                                .font(.headline)
                                .foregroundColor(selectedGoal == goal ? .white : .primary)
                            
                            Text(goal.description)
                                .font(.caption)
                                .foregroundColor(selectedGoal == goal ? .white.opacity(0.9) : .secondary)
                                .lineLimit(2)
                        }
                        
                        Spacer()
                        
                        if selectedGoal == goal {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .background(selectedGoal == goal ? Color.blue : Color(.systemGray6))
                    .cornerRadius(12)
                }
            }
        }
    }
}

