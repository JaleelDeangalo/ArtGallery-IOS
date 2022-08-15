//
//  Login.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI

struct LoginView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel: AuthViewModel
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
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
                    
                    Button(action: {}) {
                        Text("Forgot password?")
                            .font(.caption2)
                            .foregroundColor(Color.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                    }
                   
                }
          
                
                Button(action: {
                    Task {
                        await viewModel.login(email: emailInput, password: passwordInput)
                    }
                }) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.red)
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                }
            }
            
            
            
           
            
            Spacer()
            
            NavigationLink(destination: SignupView()) {
                Text("Don't have an account? Signup")
                    .foregroundColor(.red)
            }
        }.alert(viewModel.errorMessage, isPresented: $viewModel.isError, actions: {
            Button("Ok", role: .cancel) {}
        })
        .navigationTitle("Login")
        .background(colorScheme == .light ? Color.black.opacity(0.05) : Color.white.opacity(0.1))
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

