////
////  AccountSetupStep1View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep1View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            Text("Choose Gender")
//
//            VStack(alignment: .center, spacing: 16) {
//                ForEach(vm.genders, id: \.id) { gender in
//                    AccountSetupCard(
//                        title: gender.title,
//                        emoji: gender.emoji
//                    )
//                    .onTapGesture {
//                        vm.userGender = gender
//                    }
//                }
//            }
//        }
//        .padding(.top, 80)
//    }
//}
//
//struct AccountSetupStep1View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep1View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
