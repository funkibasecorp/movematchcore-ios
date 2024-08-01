////
////  AccountSetupStep6View.swift
////  FitooZone
////
////  Created by Pankaja Wijesena on 2023-05-22.
////
//
//import SwiftUI
//
//struct AccountSetupStep6View: View {
//    @EnvironmentObject var vm: AccountSetupVM
//    private let units: (String, String) = ("Pound", "Kilogram")
//    @State private var activeUnit = "Kilogram"
//
//    var body: some View {
//        VStack(alignment: .center, spacing: 32) {
//            Text("Select goal weight")
//
//            VStack(alignment: .center, spacing: 40) {
//                MeasurementUnitPicker(units: units, selected: $activeUnit)
//
//                MeasurementInputField(
//                    value: $vm.userGoalWeight,
//                    placeholder: activeUnit == units.1 ? "50" : "150",
//                    unitType: activeUnit == units.1 ? "kg" : "lb."
//                )
//            }
//        }
//        .padding(.top, 80)
//    }
//}
//
//struct AccountSetupStep6View_Previews: PreviewProvider {
//    static var previews: some View {
//        AccountSetupStep6View()
//            .environmentObject(AccountSetupVM())
//            .environmentObject(ThemeManager.shared)
//    }
//}
