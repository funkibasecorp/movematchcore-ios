//
//  AccountSetupNavBar.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-22.
//

//import SwiftUI
//
//struct AccountSetupNavBar: View {
//    @EnvironmentObject var vm: AccountSetupVM
//    @Environment(\.dismiss) private var dismissView
//    @State private var isNavToAccountSetupComplete = false
//
//    var body: some View {
//        HStack(alignment: .center, spacing: 0) {
//            Button(action: {
//                if vm.setupStep == .step1 {
//                    dismissView()
//                } else {
//                    withAnimation {
//                        vm.setupStep = vm.setupStep.prevStep
//                    }
//                }
//            }, label: {
//                Text(":)")
//            })
//
//            Spacer()
//
//            Button(action: {
//                isNavToAccountSetupComplete.toggle()
//            }, label: {
//                Text("Skip")
//                    
//            })
//        }
//        .overlay(
//            Text("Step \(vm.setupStep.rawValue) of 8")
//                .frame(minHeight: 40)
//        )
//    }
//}
//
//struct AccountSetupNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupNavBar()
//            .padding(.horizontal, 16)
//            .frame(maxHeight: .infinity, alignment: .top)
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
