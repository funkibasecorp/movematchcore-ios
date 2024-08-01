//
//  AccountSetupVM.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-21.
//

import SwiftUI

//class AccountSetupVM: ObservableObject {
//    @Published var setupStep: AccountSetupStep = .step1
//
//    let genders: [Gender] = Gender.getList()
//    let goals: [Goal] = Goal.getList()
//    let experience: [TrainLevel] = TrainLevel.getList()
//    let activities: [Activity] = Activity.getList()
//
//    @Published var userGender: Gender? = nil
//    @Published var userGoal: Goal? = nil
//    @Published var userExperience: TrainLevel? = nil
//    @Published var userBirthday: Date = Date()
//    @Published var selectedActivityIds: [String] = []
//    @Published var userWeight = ""
//    @Published var userGoalWeight = ""
//    @Published var userHeight = ""
//}
//
//enum AccountSetupStep: Int {
//    case step1 = 1
//    case step2 = 2
//    case step3 = 3
//    case step4 = 4
//    case step5 = 5
//    case step6 = 6
//    case step7 = 7
//    case step8 = 8
//
//    var content: some View {
//        Group {
//            switch self {
//            case .step1: AccountSetupStep1View()
//            case .step2: AccountSetupStep2View()
//            case .step3: AccountSetupStep3View()
//            case .step4: AccountSetupStep4View()
//            case .step5: AccountSetupStep5View()
//            case .step6: AccountSetupStep6View()
//            case .step7: AccountSetupStep7View()
//            case .step8: AccountSetupStep8View()
//            }
//        }
//    }
//
//    var nextStep: Self {
//        switch self {
//        case .step1: return .step2
//        case .step2: return .step3
//        case .step3: return .step5
//        case .step4: return .step5
//        case .step5: return .step6
//        case .step6: return .step7
//        case .step7: return .step8
//        case .step8: return .step8
//        }
//    }
//
//    var prevStep: Self {
//        switch self {
//        case .step1: return .step1
//        case .step2: return .step1
//        case .step3: return .step2
//        case .step4: return .step3
//        case .step5: return .step4
//        case .step6: return .step5
//        case .step7: return .step6
//        case .step8: return .step7
//        }
//    }
//}
//
//struct Gender: Identifiable, Hashable, Equatable {
//    let id: String = UUID().uuidString
//    let title: String
//    let emoji: String
//
//    static func getList() -> [Self] {
//        return [
//            .init(title: "Woman", emoji: "emoji_face_woman"),
//            .init(title: "Man", emoji: "emoji_face_man"),
//            .init(title: "Gender neutral", emoji: "emoji_face_neutral")
//        ]
//    }
//}
//
//struct Goal: Identifiable, Hashable, Equatable {
//    let id: String = UUID().uuidString
//    let title: String
//    let emoji: String
//
//    static func getList() -> [Self] {
//        return [
//            .init(title: "Lose weight", emoji: "emoji_wight_scale"),
//            .init(title: "Keep fit", emoji: "emoji_clover"),
//            .init(title: "Get stronger", emoji: "emoji_arm"),
//            .init(title: "Gain muscle mass", emoji: "emoji_dumbbell")
//        ]
//    }
//}
//
//struct Activity: Identifiable, Hashable, Equatable {
//    let id: String = UUID().uuidString
//    let title: String
//    let emoji: String
//    let emojiBg: Gradient
//
//    static func getList() -> [Self] {
//        return [
//            .init(title: "Cardio", emoji: "emoji_cardio", emojiBg: Gradient(colors: [ThemeManager.shared.getColor(\.lightRed)])),
//            .init(title: "Power training", emoji: "emoji_powerlift", emojiBg: ThemeManager.shared.getGradient(\.cardGradient)),
//            .init(title: "Stretch", emoji: "emoji_stretch", emojiBg: Gradient(colors: [ThemeManager.shared.getColor(\.lightBlue)])),
//            .init(title: "Dancing", emoji: "emoji_dancing", emojiBg: Gradient(colors: [ThemeManager.shared.getColor(\.lightRed)])),
//            .init(title: "Yoga", emoji: "emoji_yoga", emojiBg: ThemeManager.shared.getGradient(\.cardGradient))
//        ]
//    }
//}
//
//struct TrainLevel: Identifiable, Hashable, Equatable {
//    let id: String = UUID().uuidString
//    let title: String
//    let text: String
//
//    static func getList() -> [Self] {
//        return [
//            .init(title: "Beginner", text: "I want to start training"),
//            .init(title: "Irregular training", text: "I train 1-2 times a week"),
//            .init(title: "Medium", text: "I train 3-5 times a week"),
//            .init(title: "Advanced", text: "I train more than 5 times a week")
//        ]
//    }
//}
