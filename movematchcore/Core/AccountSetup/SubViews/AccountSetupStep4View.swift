////
////  AccountSetupStep4View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep4View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//    private let units: (String, String) = ("Feet", "Centimetre")
//    @State private var activeUnit = "Centimetre"
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            Text("Select height")
//
//            VStack(alignment: .center, spacing: 40) {
//                MeasurementUnitPicker(units: units, selected: $activeUnit)
//
//                MeasurementInputField(
//                    value: $vm.userHeight,
//                    placeholder: activeUnit == units.1 ? "200" : "5",
//                    unitType: activeUnit == units.1 ? "cm" : "ft."
//                )
//            }
//        }
//        .padding(.top, 80)
//    }
//}
//
//struct AccountSetupStep4View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep4View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
