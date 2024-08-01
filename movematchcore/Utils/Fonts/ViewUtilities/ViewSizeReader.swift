//
//  ViewSizeReader.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

/// A custom SwiftUI view that reads the size of its child view.
/// This view uses preference keys to propagate size information up the view hierarchy.
struct ViewSizeReader<Content: View>: View {
    
    /// Binding to store the size of the child view.
    @Binding var size: CGSize
    /// The View to be measured.
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        content()
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: SizePreferenceKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(SizePreferenceKey.self) { preferences in
                self.size = preferences
            }
    }
}

/// A preference key to track the size of a view for `ViewSizeReader`.
fileprivate struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    
    /// The default value for the preference key.
    static var defaultValue: Value = .zero
    
    /// Combines the old value with the next value (not used in this implementation)
    static func reduce(value: inout Value, nextValue: () -> Value) {
        _ = nextValue()
    }
}

struct ViewSizeReader_Preview: View {
    
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            Text(size.debugDescription)
            ViewSizeReader(size: $size) {
                Circle()
                    .frame(width: 80, height: 120)
            }
        }
    }
}


#Preview {
    ViewSizeReader_Preview()
}
