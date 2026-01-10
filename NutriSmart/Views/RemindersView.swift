//
//  RemindersView.swift
//  NutriSmart
//
//  Created on 2025-01-27.
//

import SwiftUI

struct RemindersView: View {
    @StateObject private var viewModel = ReminderViewModel()
    @State private var showingAddReminder = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Habits Section
                        habitsSection
                            .padding(.horizontal)
                        
                        // Reminders Section
                        remindersSection
                            .padding(.horizontal)
                        
                        // Daily Tips
                        dailyTipsSection
                            .padding(.horizontal)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("reminders_habits".localized)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddReminder = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(AppTheme.primaryGreen)
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showingAddReminder) {
                AddReminderView(viewModel: viewModel)
            }
        }
    }
    
    private var habitsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader("habits".localized)
            
            ForEach(viewModel.habits) { habit in
                HabitCard(habit: habit) { dayIndex, completed in
                    viewModel.updateHabit(habit, dayIndex: dayIndex, completed: completed)
                }
            }
        }
    }
    
    private var remindersSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader("reminders".localized)
            
            ForEach(viewModel.reminders) { reminder in
                ReminderCard(reminder: reminder) {
                    viewModel.toggleReminder(reminder)
                } onDelete: {
                    viewModel.removeReminder(reminder)
                }
            }
        }
    }
    
    private var dailyTipsSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            SectionHeader("daily_tips".localized)
            
            ForEach(viewModel.dailyTips.prefix(3)) { tip in
                DailyTipCard(tip: tip)
            }
        }
    }
}

struct HabitCard: View {
    let habit: Habit
    let onUpdate: (Int, Bool) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: habit.icon)
                    .foregroundColor(Color(habit.color))
                    .font(.title2)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(habit.name)
                        .font(.headline)
                    Text(habit.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(habit.streak)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(habit.color))
                    Text("day_streak".localized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            
            // Week Progress
            HStack(spacing: 8) {
                ForEach(Array(habit.currentWeekProgress.enumerated()), id: \.offset) { index, completed in
                    Button(action: {
                        onUpdate(index, !completed)
                    }) {
                        Circle()
                            .fill(completed ? Color(habit.color) : Color.gray.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text(dayInitial(index))
                                    .font(.caption)
                                    .foregroundColor(completed ? .white : .secondary)
                            )
                    }
                }
            }
        }
        .padding(20)
        .cardStyle()
    }
    
    private func dayInitial(_ index: Int) -> String {
        let days = ["S", "M", "T", "W", "T", "F", "S"]
        return days[index]
    }
}

struct ReminderCard: View {
    let reminder: Reminder
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: reminder.type.icon)
                .foregroundColor(Color(reminder.type.color))
                .font(.title3)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(reminder.title)
                    .font(.headline)
                Text(reminder.message)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(reminder.time, style: .time)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Toggle("", isOn: Binding(
                get: { reminder.isEnabled },
                set: { _ in onToggle() }
            ))
            
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(16)
        .cardStyle()
    }
}

struct DailyTipCard: View {
    let tip: DailyTip
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
                .font(.title3)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(tip.title)
                    .font(.headline)
                Text(tip.content)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [AppTheme.accentYellow.opacity(0.15), Color.clear],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cardStyle()
    }
}

struct AddReminderView: View {
    @ObservedObject var viewModel: ReminderViewModel
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var message = ""
    @State private var type: Reminder.ReminderType = .meal
    @State private var time = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("reminder_details".localized)) {
                    TextField("title".localized, text: $title)
                    TextField("message".localized, text: $message)
                    Picker("type".localized, selection: $type) {
                        ForEach([Reminder.ReminderType.meal, .water, .nutritionTip], id: \.self) { t in
                            Text(t.rawValue).tag(t)
                        }
                    }
                    DatePicker("time".localized, selection: $time, displayedComponents: .hourAndMinute)
                }
            }
            .navigationTitle("add_reminder".localized)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save".localized) {
                        let reminder = Reminder(
                            id: UUID(),
                            title: title,
                            message: message,
                            type: type,
                            isEnabled: true,
                            time: time,
                            repeatDays: [1, 2, 3, 4, 5, 6, 7],
                            lastTriggered: nil
                        )
                        viewModel.addReminder(reminder)
                        dismiss()
                    }
                    .disabled(title.isEmpty || message.isEmpty)
                }
            }
        }
    }
}

