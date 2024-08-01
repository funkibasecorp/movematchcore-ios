import SwiftUI

struct Login: View {
    @State private var showSignup: Bool = false
    @StateObject private var authViewModel = AuthViewModel()
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Spacer(minLength: 0)
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
            
            Text("Please sign in to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email", value: $authViewModel.signInEmail)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $authViewModel.signInPassword)
                    .padding(.top, 5)
                
                Button("Forgot Password?") {
                    showForgotPasswordView.toggle()
                }
                .font(.callout)
                .fontWeight(.heavy)
                .tint(.purple)
                .hSpacing(.trailing)
                
                // Login Button
                GradientButton(title: "Login", icon: "arrow.right", color: .purple) {
                    Task {
                        await authViewModel.logInWithEmail(email: authViewModel.signInEmail, password: authViewModel.signInPassword)
                        if authViewModel.currentUser != nil {
                            print("User found: \(String(describing: authViewModel.currentUser))")
                        } else {
                            print("No user")
                        }
                    }
                }
                .hSpacing(.trailing)
                // Disabling Until the Data is Entered
                .disableWithOpacity(authViewModel.signInEmail.isEmpty || authViewModel.signInPassword.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Don't have an account?")
                    .foregroundStyle(.gray)
                
                Button("Sign Up") {
                    showSignup.toggle()
                }
                .fontWeight(.bold)
                .tint(.purple)
            }
            .font(.callout)
            .hSpacing()
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        // Asking Email ID For Sending Reset Link
        .sheet(isPresented: $showForgotPasswordView) {
            ForgotPassword(showResetView: $showResetView)
                .presentationDetents([.height(300)])
        }
        // Resetting New Password
        .sheet(isPresented: $showResetView) {
            PasswordResetView()
                .presentationDetents([.height(350)])
        }
        // OTP Prompt
        .sheet(isPresented: $askOTP, onDismiss: {
            otpText = ""
        }) {
            OTPView(otpText: $otpText)
                .presentationDetents([.height(350)])
        }
        // Show Sign-Up Screen
        .sheet(isPresented: $showSignup) {
            SignUp(showSignup: $showSignup)
        }
    }
}

struct ForgotPassword: View {
    @Binding var showResetView: Bool
    /// View Properties
    @State private var emailID: String = ""
    /// Environment Properties
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content: {
            /// Back Button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Forgot Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                .padding(.top, 5)
            
            Text("Please enter your Email ID so that we can send the reset link.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                /// Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                
                /// SignUp Button
                GradientButton(title: "Send Link", icon: "arrow.right", color: .purple) {
                    /// YOUR CODE
                    /// After the Link sent
                    Task {
                        dismiss()
                        try? await Task.sleep(for: .seconds(0))
                        /// Showing the Reset View
                        showResetView = true
                    }
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(emailID.isEmpty)
            }
            .padding(.top, 20)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        /// Since this is going to be a Sheet.
        .interactiveDismissDisabled()
    }
}

import SwiftUI

struct OTPView: View {
    @Binding var otpText: String
    // Environment Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Back Button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 15)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                .padding(.top, 5)
            
            Text("A 6-digit code has been sent to your Email ID.")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom OTP TextField
                OTPVerificationView(otpText: $otpText)
                
                // Send Link Button
                GradientButton(title: "Verify OTP", icon: "arrow.right", color: .purple) {
                    // YOUR CODE
                }
                .hSpacing(.trailing)
                // Disabling Until the Data is Entered
                .disableWithOpacity(otpText.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        // Since this is going to be a Sheet.
        .interactiveDismissDisabled()
    }
}

import SwiftUI

struct PasswordResetView: View {
    // View Properties
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    // Environment Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Back Button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                .padding(.top, 5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                
                CustomTF(sfIcon: "lock", hint: "Confirm Password", isPassword: true, value: $confirmPassword)
                    .padding(.top, 5)
                
                // Send Link Button
                GradientButton(title: "Reset Password", icon: "arrow.right", color: .purple) {
                    // YOUR CODE
                    // Reset Password
                }
                .hSpacing(.trailing)
                // Disabling Until the Data is Entered
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty || password != confirmPassword)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        // Since this is going to be a Sheet.
        .interactiveDismissDisabled()
    }
}

struct SignUp: View {
    @Binding var showSignup: Bool
    // View Properties
    @State private var emailID: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var askOTP: Bool = false
    @State private var otpText: String = ""
    
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Back Button
            Button(action: {
                showSignup = false
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("SignUp")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(.purple)
                .padding(.top, 25)
            
            Text("Please sign up to continue")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                // Custom Text Fields
                CustomTF(sfIcon: "at", hint: "Email ID", value: $authViewModel.signInEmail)
                
                CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                    .padding(.top, 5)
                
                CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $authViewModel.signInPassword)
                    .padding(.top, 5)
                
                Text("By signing up, you're agreeing to our **[Terms & Condition](https://apple.com)** and **[Privacy Policy](https://apple.com)**")
                    .font(.caption)
                    .tint(.purple)
                    .foregroundStyle(.gray)
                    .frame(height: 50)
                
                // SignUp Button
                GradientButton(title: "Continue", icon: "arrow.right", color: .purple) {
                    Task {
                        await authViewModel.createAccountWithEmail()
//                        askOTP.toggle()
                    }
                }
                .hSpacing(.trailing)
                .disableWithOpacity(authViewModel.signInEmail.isEmpty || authViewModel.signInPassword.isEmpty || fullName.isEmpty)
            }
            .padding(.top, 20)
            
            Spacer(minLength: 0)
            
            HStack(spacing: 6) {
                Text("Already have an account?")
                    .foregroundStyle(.gray)
                
                Button("Login") {
                    showSignup = false
                }
                .fontWeight(.bold)
                .tint(.purple)
            }
            .font(.callout)
            .hSpacing()
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $askOTP, onDismiss: {
            // Reset OTP if You Want
            // otpText = ""
        }) {
            if #available(iOS 16.4, *) {
                OTPView(otpText: $otpText)
                    .presentationDetents([.height(350)])
                    .presentationCornerRadius(30)
            } else {
                OTPView(otpText: $otpText)
                    .presentationDetents([.height(350)])
            }
        }
    }
}


struct OTPVerificationView: View {
    /// - View Properties
    @Binding var otpText: String
    /// - Keyboard State
    @FocusState private var isKeyboardShowing: Bool
    var body: some View {
        HStack(spacing: 0){
            /// - OTP Text Boxes
            /// Change Count Based on your OTP Text Size
            ForEach(0..<6,id: \.self){index in
                OTPTextBox(index)
            }
        }
        .background(content: {
            TextField("", text: $otpText.limit(6))
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                /// - Hiding it Out
                .frame(width: 1, height: 1)
                .opacity(0.001)
                .blendMode(.screen)
                .focused($isKeyboardShowing)
        })
        .contentShape(Rectangle())
        /// - Opening Keyboard When Tapped
        .onTapGesture {
            isKeyboardShowing = true
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done"){
                    isKeyboardShowing = false
                }
                .tint(.purple)
                .fontWeight(.heavy)
                .hSpacing(.trailing)
            }
        }
    }
    
    // MARK: OTP Text Box
    @ViewBuilder
    func OTPTextBox(_ index: Int)->some View{
        ZStack{
            if otpText.count > index{
                /// - Finding Char At Index
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            }else{
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            /// - Highlighting Current Active Box
            let status = (isKeyboardShowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? .purple : Color.gray,lineWidth: status ? 3 : 0.5)
                /// - Adding Animation
                .animation(.easeInOut(duration: 0.2), value: isKeyboardShowing)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: Binding <String> Extension
extension Binding where Value == String{
    func limit(_ length: Int)->Self{
        if self.wrappedValue.count > length{
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}

struct GradientButton: View {
    var title: String
    var icon: String
    var color: Color
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15) {
                Text(title)
                Image(systemName: icon)
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background(.linearGradient(colors: [color, color.opacity(0.8)], startPoint: .top, endPoint: .bottom), in: .capsule)
        })
    }
}

struct CustomTF: View {
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    /// Hides TextField
    var isPassword: Bool = false
    @Binding var value: String
    /// View Properties
    @State private var showPassword: Bool = false
    /// When Switching Between Hide/Reveal Password Field, The Keyboard is Closing, to avoid that using the FocusState
    @FocusState private var passwordState: HideState?
    
    enum HideState {
        case hide
        case reveal
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 8, content: {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                /// Since I Need Same Width to Align TextFields Equally
                .frame(width: 30)
                /// Slightly Bringing Down
                .offset(y: 2)
            
            VStack(alignment: .leading, spacing: 8, content: {
                if isPassword {
                    Group {
                        /// Revealing Password when users wants to show Password
                        if showPassword {
                            TextField(hint, text: $value)
                                .focused($passwordState, equals: .reveal)
                        } else {
                            SecureField(hint, text: $value)
                                .focused($passwordState, equals: .hide)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                }
                
                Divider()
            })
            .overlay(alignment: .trailing) {
                /// Password Reveal Button
                if isPassword {
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                        passwordState = showPassword ? .reveal : .hide
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        })
    }
}



#Preview {
    Login()
}
