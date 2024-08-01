//
//  MeasurementUnitPicker.swift
//  FitooZone
//
//  Created by Pankaja Wijesena on 2023-05-22.
//

import SwiftUI

struct MeasurementUnitPicker: View {
    let units: (String, String)
    @Binding var selected: String
    private var leftUnit: String { units.0 }
    private var rightUnit: String { units.1 }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack(alignment: .center, spacing: 0) {
                    if selected == rightUnit {
                        Spacer(minLength: 0)
                    }
                    Capsule()
                        .fill(ThemeManager.shared.getColor(\.backgroundSecondary))
                        .frame(width: geo.size.width / 2)
                    if selected == leftUnit {
                        Spacer(minLength: 0)
                    }
                }
                HStack(alignment: .center, spacing: 0) {
                    capsule(unit: leftUnit)
                    capsule(unit: rightUnit)
                }
            }
        }
        .padding(.all, 4)
        .frame(width: 252, height: 40, alignment: .leading)
        .clipShape(Capsule())
    }

    func capsule(unit: String) -> some View {
        Capsule()
            .fill(Color.clear)
            .overlay(
                Text(unit)
            )
            .onTapGesture {
                withAnimation {
                    selected = unit
                }
            }
    }
}

struct MeasurementUnitPicker_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementUnitPicker(
            units: ("Feet", "Centimetre"),
            selected: .constant("Centimetre")
        )
        .environmentObject(ThemeManager.shared)
    }
}
