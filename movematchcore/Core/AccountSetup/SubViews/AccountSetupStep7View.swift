////
////  AccountSetupStep7View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep7View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            Text("Choose training level")
//
//            VStack(alignment: .center, spacing: 16) {
//                ForEach(vm.experience, id: \.id) { experience in
//                    VStack {
//                        Text(experience.title)
//                        Text(experience.text)
//                    }
//                    .onTapGesture {
//                        vm.userExperience = experience
//                    }
//                }
//            }
//        }
//        .padding(.top, 40)
//    }
//}
//
//struct AccountSetupStep7View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep7View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
