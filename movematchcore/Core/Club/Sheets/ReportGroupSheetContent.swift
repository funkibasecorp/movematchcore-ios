//
//  ReportGroupSheetContent.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/25/24.
//

import SwiftUI

struct ReportGroupSheetContent: View {
    
    // MARK: Data
    @State private var reportReason: ReportReason = .ads
    @State private var otherText: String = ""
    
    // MARK: UI
    @Binding var isPresented: Bool
    private var otherIsSelected: Bool {
        reportReason.isOther
    }
    
    var body: some View {
        SheetContent(title: "Report Group", isPresented: $isPresented) {
            VStack(spacing: 32) {
                TogglePicker(selection: $reportReason)
                TextField("", text: $otherText, axis: .vertical)
                    .lineLimit(5, reservesSpace: true)
                    .disabled(!otherIsSelected)
                    .opacity(otherIsSelected ? 1 : 0.5)
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.brand(.lightGray))
                    }
                    .padding(.leading, 24)
                    .padding(.top, -24)
                
                TextButton("Submit Report", action: reportGroupWasPressed)
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: Methods
    func reportGroupWasPressed() {
        Haptics.triggerGentleInteractionHaptic()
        isPresented = false
    }
}



extension ReportGroupSheetContent {
    struct _Preview: View {
        
        @State private var isPresented: Bool = true
        
        var body: some View {
            Color.gray.ignoresSafeArea()
                .adaptiveSheet(isPresented: $isPresented) {
                    ReportGroupSheetContent(isPresented: $isPresented)
                }
        }
    }
}


#Preview {
    ReportGroupSheetContent._Preview()
}
