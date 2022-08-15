//
//  Signup.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI

struct SignupView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var usernameInput: String = ""
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @StateObject var viewModel: AuthViewModel
    init() {
        self._viewModel = StateObject(wrappedValue: AuthViewModel(delegate: AuthRepository()))
    }
    var body: some View {
        VStack {
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    TextField("Username", text: $usernameInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    TextField("Email", text: $emailInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                    
                    SecureField("Password", text: $passwordInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    Button(action: {
                        Task {
                            await viewModel.signup(username: usernameInput, email: emailInput, password: passwordInput)
                        }
                    }) {
                        Text("SignUp")
                            .foregroundColor(Color.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            
                    }
                }
            }
            
           
            
            
            
           
            
            Spacer()
            
        
        }.alert(viewModel.errorMessage, isPresented: $viewModel.isError, actions: {
            Button("Ok", role: .cancel) {
                
            }
        })
        .navigationTitle("Signup")
            .background(colorScheme == .light ? Color.black.opacity(0.05) : Color.white.opacity(0.1))
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
