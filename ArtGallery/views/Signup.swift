//
//  Signup.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct SignupView: View {
    @State var usernameInput: String = ""
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @StateObject var viewModel: AuthViewModel
    init() {
        self._viewModel = StateObject(wrappedValue: AuthViewModel())
    }
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10){
                TextField("Username", text: $usernameInput)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                
                TextField("Email", text: $emailInput)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                    
                
                SecureField("Password", text: $passwordInput)
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.horizontal)
                
                Button(action: {
                    Task {
                        await viewModel.signup(username: usernameInput, email: emailInput, password: passwordInput)
                    }
                }) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(20)
                        
                }
            }
            
            
            
           
            
            Spacer()
            
        
        }.navigationTitle("Signup")
    }
}

struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
