////
////  AccountSetupStep8View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep8View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            VStack(alignment: .center, spacing: 0) {
//                Text("Choose activities")
//                Text("that interest")
//            }
//
//            VStack(alignment: .center, spacing: 16) {
//                ForEach(vm.activities, id: \.id) { activity in
//                    AccountSetupCard(
//                        title: activity.title,
////                        emoji: activity.emoji,
//                        emojiBgGradient: activity.emojiBg,
//                        isCheck: vm.selectedActivityIds.contains(activity.id)
//                    )
//                    .onTapGesture {
//                        if vm.selectedActivityIds.contains(activity.id) {
//                            vm.selectedActivityIds.removeAll(where: {$0 == activity.id})
//                        } else {
//                            vm.selectedActivityIds.append(activity.id)
//                        }
//                    }
//                }
//            }
//        }
//        .padding(.top, 40)
//    }
//}
//
//struct AccountSetupStep8View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep8View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
