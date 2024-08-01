//
//  ActionSheet.swift
//  SpotMatch
//
//  Created by Jake Sax on 7/22/24.
//

import SwiftUI

fileprivate struct ActionSheetModifier: ViewModifier {
    
    @Binding var isPresented: Bool
    var onDismiss: (() -> Void)? = nil
    var actionButtons: [ActionSheetButton.Configuration]
    
    func body(content: Content) -> some View {
        content
            .adaptiveSheet(isPresented: $isPresented, onDismiss: onDismiss) {
                SheetContent(title: "Select Action", isPresented: $isPresented) {
                    VStack(spacing: 20) {
                        ForEach(actionButtons) { button in
                            ActionSheetButton(button: button)
                        }
                    }.padding(.horizontal, 20)
                }
            }
    }

}

struct ActionSheetButton: View {
    
    var button: Configuration
    var useRedBKGD: Bool {
        button.role == .cancel || button.role == .destructive
    }
    
    var body: some View {
        Button(action: button.action) {
            HStack(spacing: 16) {
                IconButton(
                    button.icon,
                    bkgdColor: useRedBKGD ? .red : .brand(.primaryBlue),
                    iconColor: .white,
                    action: nil
                )
           
                Text(button.text)
                    .font(.body)
                    .foregroundStyle(useRedBKGD ? .red : .black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Icon(.chevronRight, size: 20)
                    .foregroundStyle(.gray)
            }
        }
    }
}
extension ActionSheetButton {
  
    /// A configuration object for buttons in an action sheet.
    ///
    /// This struct encapsulates all the necessary information to create and configure
    /// a button within an action sheet, including its text, icon, role, and associated action.
    struct Configuration: Identifiable {
        /// A unique identifier for the button configuration.
        let id = UUID()
        
        /// The text to be displayed on the button.
        let text: String
        
        /// The icon to be displayed alongside the text on the button.
        let icon: Brand.Icon
        
        /// The role of the button, which can affect its appearance and behavior.
        ///
        /// - Note: This property is optional. If `nil`, the button will have a default role.
        let role: ButtonRole?
        
        /// The action to be performed when the button is tapped.
        let action: () -> Void
        
        /// Creates a new button configuration for use in an action sheet.
        ///
        /// - Parameters:
        ///   - text: The text to be displayed on the button.
        ///   - icon: The icon to be displayed alongside the text.
        ///   - role: The role of the button. Defaults to `nil` for a standard button.
        ///   - action: A closure that will be executed when the button is tapped.
        internal init(
            text: String,
            icon: Brand.Icon,
            role: ButtonRole? = nil,
            action: @escaping () -> Void
        ) {
            self.text = text
            self.icon = icon
            self.role = role
            self.action = action
        }
    }
}


extension View {
    /// Presents a custom action sheet when a binding to a Boolean value becomes `true`.
    ///
    /// Use this function to display a custom action sheet with configurable buttons. The action sheet
    /// is presented modally and can be dismissed by tapping outside the sheet or by programmatically
    /// setting the `isPresented` binding to `false`.
    ///
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether to present the action sheet.
    ///   - onDismiss: A closure to execute when dismissing the action sheet. Defaults to `nil`.
    ///   - actionButtons: An array of `ActionSheetButtonConfiguration` objects that
    ///   define the buttons to be displayed in the action sheet.
    ///
    /// Example usage:
    /// ```swift
    /// struct ContentView: View {
    ///     @State private var showActionSheet = false
    ///
    ///     var body: some View {
    ///         Button("Show Action Sheet") {
    ///             showActionSheet = true
    ///         }
    ///         .customActionSheet(isPresented: $showActionSheet, actionButtons: [
    ///             ActionSheetButtonConfiguration(text: "Option 1", icon: .some(.icon1)) {
    ///                 print("Option 1 selected")
    ///             },
    ///             ActionSheetButtonConfiguration(text: "Option 2", icon: .some(.icon2)) {
    ///                 print("Option 2 selected")
    ///             }
    ///         ])
    ///     }
    /// }
    /// ```
    func customActionSheet(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        actionButtons: [ActionSheetButton.Configuration]
    ) -> some View {
        self
            .modifier(
                ActionSheetModifier(
                    isPresented: isPresented,
                    onDismiss: onDismiss,
                    actionButtons: actionButtons
                )
            )
    }
}

// MARK: - Previews
extension ActionSheetModifier {
    struct _Preview: View {
        
        @State private var isPresented: Bool = true
        
        var body: some View {
            VStack {
                Button(action: {isPresented.toggle()} ) {
                    Text("show/hide sheet")
                        .font(.largeTitle)
                        .bold()
                }
                Circle()
            }
            .customActionSheet(
                isPresented: $isPresented,
                onDismiss: {
                    print("dismiss")
                },
                actionButtons: [
                    .init(text: "Join Group", icon: .plus, action: { print("join group")}),
                    .init(text: "Share Group", icon: .share, action: { print("share group")}),
                    .init(text: "Report Group", icon: .exclamationTriangleFill, role: .destructive, action: { print("report group")})
                ]
            )
        }
    }
}

#Preview {
    ActionSheetModifier._Preview()
}
