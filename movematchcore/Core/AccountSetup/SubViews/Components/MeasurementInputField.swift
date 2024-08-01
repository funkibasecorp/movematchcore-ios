//
//  MeasurementInputField.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-22.
//

import SwiftUI

struct MeasurementInputField: View {
    @Binding var value: String
    let placeholder: String
    let unitType: String

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.clear)
                    .offset(x: -8)
                TextField(placeholder, text: $value)
                    .padding(.all)
                    .keyboardType(.numberPad)
            }
            .frame(width: 96, height: 64)

            Spacer(minLength: 0)

            Text(unitType)
        }
        .frame(width: 130)
    }
}

struct MeasurementInputField_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementInputField(
            value: .constant(""),
            placeholder: "200",
            unitType: "cm"
        )
        .environmentObject(ThemeManager.shared)
    }
}
