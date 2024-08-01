//
//  HomeView.swift
//  spotmatch
//
//  Created by Chris Jones on 5/13/24.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State private var moderateProgress: Double = 0.50
    @State private var vigorousProgress: Double = 0.45

    // Sample data for the donut chart
    private var exerciseData = [
        (name: "Aerobic", count: 90),
        (name: "Recovery", count: 340),
        (name: "Flexibility", count: 20),
        (name: "Strength", count: 40)
    ]
    

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Welcome Header
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        VStack(alignment: .leading) {
                            Text("Welcome,")
                                .font(.title3)
                                .foregroundColor(.gray)
                            Text("Chris")
                                .font(.title)
                                .bold()
                        }
                        Spacer()
                        NotificationButton()
                    }
                    .padding()

                    // Fitness Test Header View
                    FitnessTestHeaderView()

                    // Exercises Completed
                    VStack(alignment: .leading) {
                        Text("Exercises completed")
                            .font(.headline)
                        
                        // Donut Chart
                        VStack {
                            Chart {
                                ForEach(exerciseData, id: \.name) { exercise in
                                    SectorMark(
                                        angle: .value("Count", exercise.count),
                                        innerRadius: .ratio(0.65),
                                        angularInset: 1.0
                                    )
                                    .cornerRadius(30.0)
                                    .foregroundStyle(by: .value("Type", exercise.name))
                                    .annotation(position: .overlay) {
                                        Text("\(exercise.count)")
                                            .font(.headline)
                                            .foregroundStyle(.white)
                                    }
                                }
                            }
                            .frame(height: 300)
                            .chartBackground { proxy in
                                VStack {
                                    Text("⚖️")
                                        .font(.system(size: 40))
                                    Text("Balanced")
                                        .font(.system(size: 20))
                                }
                            }
                        }
                        .padding()
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // Daily Goal Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily Goal")
                            .font(.headline)

                        HStack {
                            CircularProgressView(progress: $moderateProgress, title: "MODERATE EXERCISE MINUTES", currentMinutes: 23, totalMinutes: 30)
                                .padding()
                                
                            CircularProgressView(progress: $vigorousProgress, title: "VIGOROUS EXERCISE MINUTES", currentMinutes: 4, totalMinutes: 10)
                                .padding()
                        }
                    }
                    .padding(.horizontal)

                    // Frequency Section
                    VStack(alignment: .leading) {
                        Text("Your frequency of performing fitness activities is 30% more than last week")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        HStack {
                            Rectangle()
                                .fill(Color.purple)
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 30, height: 10)
                            Rectangle()
                                .fill(Color(.systemGray4))
                                .frame(width: 30, height: 10)
                        }
                    }
                    .frame(width: .infinity, height: 75)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

                    // Workouts Completed This Week
                    VStack(alignment: .leading) {
                        Text("3/7 Workouts completed this week")
                            .font(.headline)
                        HStack {
                            ForEach(0..<7) { day in
                                VStack {
                                    Text(dayName(for: day))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Image(systemName: day < 3 ? "star.fill" : "star")
                                        .foregroundColor(day < 3 ? .blue : .gray)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                .padding(.vertical)
                .padding(.bottom, 50) // Added padding at the bottom
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }

    func dayName(for index: Int) -> String {
        let days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
        return days[index]
    }
}

struct NotificationButton: View {
    var body: some View {
        NavigationLink(destination: NotificationView()) {
            ZStack {
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(40)
                    .overlay(
                        Circle()
                            .fill(Color.yellow)
                            .frame(width: 20, height: 20)
                            .overlay(
                                Text("2")
                                    .font(.caption)
                                    .foregroundColor(.black)
                            )
                            .offset(x: 15, y: -15)
                    )
            }
        }
    }
}

struct CircularProgressView: View {
    @Binding var progress: Double
    var title: String
    var currentMinutes: Int
    var totalMinutes: Int

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .bold()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(Color.purple)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.purple)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: progress)
                
                VStack {
                    Text("\(Int(progress * 100))%")
                        .font(.title)
                        .bold()
                }
            }
            .frame(width: 150, height: 125)
            
            Spacer()
            
            Text("\(currentMinutes)/\(totalMinutes) Minutes")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    HomeView()
}
