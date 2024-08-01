//
//  SegmentedPicker.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

/// A protocol that defines the requirements for types that can be used to control a picker in SwiftUI.
///
/// Types conforming to `PickerControllable` can be used as the selection type for a `Picker` view,
/// providing a standardized way to represent and display picker options.
///
/// - Note: This protocol is particularly useful for enums that represent a fixed set of options
///         for a picker, such as filter categories, sort orders, or view modes.
protocol PickerControllable: Equatable, Hashable, CaseIterable {
    /// The title to be displayed for this option in the picker.
    ///
    /// This property allows you to provide a user-friendly string representation of each case,
    /// which may differ from its raw value or programmatic name.
    var pickerTitle: String { get }
}
extension PickerControllable where Self:RawRepresentable, Self.RawValue == String {
    var pickerTitle: String { rawValue.capitalized }
}

struct SegmentedPicker<SelectionValue: PickerControllable>: View {
    
    // MARK: Data
    @Binding var selectionValue: SelectionValue
    
    // MARK: UI
    private var allCases: Array<SelectionValue> {
        Array(SelectionValue.allCases)
    }
    private var selectionBackgroundPosition: Alignment {
        selectionIndex == 0 ? .leading : .trailing
    }
    private var selectionIndex: Int {
        allCases.firstIndex(of: selectionValue) ?? 0
    }
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    // MARK: Body
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                ForEach(allCases, id: \.self) { value in
                    Button {
                        Haptics.triggerGentleInteractionHaptic()
                        withAnimation {
                            selectionValue = value
                        }
                    } label: {
                        SegmentedControlItem(
                            label: value.pickerTitle,
                            isSelected: selectionValue == value,
                            width: geo.size.width / CGFloat(allCases.count)
                        )
                    }
                }
            }
            .frame(width: geo.size.width)
            
            .background {
                // BKGD rounded Rectangle
                Rectangle()
                    .foregroundColor(brand: .primaryBlue)
                    .cornerRadius(50)
                
                // Selection Rounded Rectangle
                    .overlay(alignment: selectionBackgroundPosition) {
                        Color.brand(.white)
                            .frame(width: geo.size.width / CGFloat(allCases.count))
                            .cornerRadius(50)
                            .padding(4)
                    }
            }
        }
        .frame(height: 48)
        .animation(.smooth, value: selectionBackgroundPosition)
        .opacity(isEnabled ? 1 : 0.5)
    }
    
    // MARK: Supporting Views
    struct SegmentedControlItem: View {
        
        // MARK: Data
        var label: String
        var isSelected: Bool
        
        // MARK: UI
        var width: CGFloat
        var textColor: Color {
            isSelected ? .black : .brand(.lightGray)
        }
        
        var body: some View {
            Text(label)
                .font(.headline)
                .foregroundColor(textColor)
                .padding(.horizontal, 8)
                .frame(width: width, height: 48)
                .lineLimit(1)
        }
    }
    
    
    // MARK: Initialization
    init(selection: Binding<SelectionValue>) {
        self._selectionValue = selection
    }
    
}

fileprivate struct SegmentedPicker_Preview: View {
    
    @State private var selection: FitnessGroup.LocationPrivacy = .global
    
    var body: some View {
        SegmentedPicker(selection: $selection)
            .padding(16)
    }
}

#Preview {
    SegmentedPicker_Preview()
}
