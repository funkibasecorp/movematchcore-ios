////
////  AccountSetupStep3View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep3View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 100) {
//            Text("Select Birthdate")
//
//            DatePicker(
//                "Select your birthdate",
//                selection: $vm.userBirthday,
//                displayedComponents: [.date]
//            )
//            .tint(ThemeManager.shared.getColor(\.purple2))
//        }
//        .padding(.top, 80)
//    }
//}
//
//struct AccountSetupStep3View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep3View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
