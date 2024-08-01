////
////  AccountSetupView.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-21.
////
//
//import SwiftUI
//
//struct AccountSetupView: View {
//    @StateObject var vm = AccountSetupVM()
//    @State private var isNavToAccountSetupComplete = false
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 0) {
//            AccountSetupNavBar()
//
//            vm.setupStep.content
//                .transition(.opacity)
//
//            Spacer(minLength: 0)
//
//            Button(vm.setupStep == .step2 ? "Start Training" : "Continue") {
//                if vm.setupStep == .step8 {
//                    isNavToAccountSetupComplete.toggle()
//                } else {
//                    withAnimation {
//                        vm.setupStep = vm.setupStep.nextStep
//                    }
//                }
//            }
//        }
//
//        .environmentObject(vm)
//    }
//}
//
//struct AccountSetupView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            AccountSetupView()
//                .environmentObject(ThemeManager.shared)
//        }
//    }
//}
