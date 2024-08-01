////
////  AccountSetupStep2View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep2View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            Text("Choose main goal")
//
//            VStack(alignment: .center, spacing: 16) {
//                ForEach(vm.goals, id: \.id) { goal in
//                    AccountSetupCard(
//                        title: goal.title,
//                        emoji: goal.emoji
//                    )
//                    .onTapGesture {
//                        vm.userGoal = goal
//                    }
//                }
//            }
//        }
//        .padding(.top, 80)
//    }
//}
//
//struct AccountSetupStep2View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep2View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
