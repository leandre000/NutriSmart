//
//  ProgressRing.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct ProgressRing: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat
    
    init(progress: Double, color: Color = .blue, lineWidth: CGFloat = 10) {
        self.progress = progress
        self.color = color
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.2), lineWidth: lineWidth)
            
            Circle()
                .trim(from: 0, to: min(progress / 100, 1.0))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)
        }
    }
}

struct NutritionProgressView: View {
    let nutrition: NutritionInfo
    let dailyTarget: NutritionInfo
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 30) {
                ProgressRingItem(
                    label: "Protein",
                    current: nutrition.protein,
                    target: dailyTarget.protein,
                    unit: "g",
                    color: .blue
                )
                
                ProgressRingItem(
                    label: "Carbs",
                    current: nutrition.carbohydrates,
                    target: dailyTarget.carbohydrates,
                    unit: "g",
                    color: .green
                )
                
                ProgressRingItem(
                    label: "Fats",
                    current: nutrition.fats,
                    target: dailyTarget.fats,
                    unit: "g",
                    color: .purple
                )
            }
        }
    }
}

struct ProgressRingItem: View {
    let label: String
    let current: Double
    let target: Double
    let unit: String
    let color: Color
    
    private var percentage: Double {
        min(100, (current / target) * 100)
    }
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                ProgressRing(progress: percentage, color: color, lineWidth: 8)
                    .frame(width: 80, height: 80)
                
                VStack(spacing: 2) {
                    Text("\(Int(percentage))%")
                        .font(.caption)
                        .fontWeight(.bold)
                    Text(unit)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("\(String(format: "%.0f", current))/\(String(format: "%.0f", target))")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

