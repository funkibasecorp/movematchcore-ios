//
//  TogglePicker.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/25/24.
//

import SwiftUI

/// A simple toggle picker list.
struct TogglePicker<Value: PickerControllable>: View  {
    
    @Binding var selection: Value
    
    var body: some View {
        VStack(spacing: 32) {
            ForEach(Array(Value.allCases), id: \.self) { value in
                toggle(value, selection: $selection)
            }
        }
    }
    
    func toggle(_ value: Value, selection: Binding<Value>) -> some View {
        Button {
            Haptics.triggerGentleInteractionHaptic()
            selection.wrappedValue = value
        } label: {
            let isSelected = value == selection.wrappedValue
            let circleColor = Color.brand(isSelected ? .primaryBlue : .lightGray)
            HStack {
                Circle()
                    .stroke(circleColor, lineWidth: 2)
                    .frame(width: 16, height: 16)
                    .overlay {
                        Circle()
                            .foregroundStyle(circleColor)
                            .padding(4)
                            .opacity(isSelected ? 1 : 0)
                        
                    }
                
                Text(value.pickerTitle)
                    .bold()
                    .foregroundColor(brand: .black)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

fileprivate enum Fruit: String, PickerControllable {
    case apple, orange, nectarine, mango, peach
}

fileprivate extension TogglePicker<Fruit> {
    struct _Preview: View {
        @State private var fruit: Fruit = .apple
        
        var body: some View {
            TogglePicker(selection: $fruit)
                .padding(20)
        }
    }
}


#Preview {
    TogglePicker<Fruit>._Preview()
}
