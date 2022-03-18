//
//  Login.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: AuthViewModel
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    
    init() {
        self._viewModel = StateObject(wrappedValue: AuthViewModel())
    }
    var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 10){
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
                        await viewModel.login(email: emailInput, password: passwordInput)
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
            
            NavigationLink(destination: SignupView()) {
                Text("Don't have an account? Signup")
                    .foregroundColor(.blue)
            }
        }.navigationTitle("Login")
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
