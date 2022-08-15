//
//  EditProfileView.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/20/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct EditProfileView: View {
    @AppStorage("Authorization") var auth = false
    @StateObject var viewModel: UploadViewModel
    var bio: String
    var username: String
    var avatar: String
    var email: String
    @State var alertPresented: Bool = false
    @State private var isShowingPicker = false
    @State var usernameInput: String = ""
    @State var emailInput: String = ""
    @State var bioInput: String = ""
    @State var avatarInput: UIImage?
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) private var presentationMode
    init(bio: String, username: String, email: String, avatar: String) {
        self._viewModel = StateObject(wrappedValue: UploadViewModel(delegate: UploadRepository()))
        self.bio = bio
        self.username = username
        self.email = email
        self.avatar = avatar
    }
    var body: some View {
        VStack {
            HStack {
                Button(action:{ presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .leading)
                        .foregroundColor(Color.red)
                }
              
                Spacer()
                
                Text("Edit Profile")
                    .font(.headline)
                    .padding(.top, 5)
                
                Spacer()
                
                Button(action:{
                    
                    if usernameInput.isEmpty {
                        usernameInput = username
                    }
                    
                    if emailInput.isEmpty {
                        emailInput = email
                    }
                    
                    if bioInput.isEmpty {
                        bioInput = bio
                    }
                    
                    viewModel.uploadProfileImage(username: usernameInput, email: emailInput, bio: bioInput, avatar: avatarInput ?? nil, currentAvatar: avatar)

                }) {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.red)
                }
                
                if viewModel.isUploading {
                    ProgressView()
                }
                
            }.padding(.horizontal)
            
            Spacer(minLength: 10)
           
            VStack(spacing: 20) {
                if avatarInput != nil {
                    Image(uiImage: avatarInput!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                } else {
                    WebImage(url: URL(string: avatar))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                }
             
                
                Button(action:{ isShowingPicker = true }) {
                    Text("Change Profile Pciture")
                        .font(.caption2)
                        .foregroundColor(Color.red)
                }
                
            }
                Spacer()
            
                VStack(spacing: 20) {
                    TextField(username, text: $usernameInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    TextField(email, text: $emailInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                    
                    TextField(bio, text: $bioInput)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(colorScheme == .light ? Color.black.opacity(0.07) : Color.white.opacity(0.07))
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
            
            Spacer()
            
            Button(action: { alertPresented.toggle() }) {
                Text("Delete Account")
                    .foregroundColor(Color.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.red)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
            }
            
          
            
        }
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        .sheet(isPresented: $isShowingPicker, content: {
            ImagePicker(image: $avatarInput)
        }).alert("Confirmation", isPresented: $alertPresented, actions: {
            
            Button("No", role: .cancel) {}
            
            Button("Yes", role: .destructive) {
                auth = false
                Task {
                    await viewModel.deleteUser()
                }
            }
            
        })
        .navigationTitle("")
         .navigationBarHidden(true)
        
      
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(bio: "", username: "", email: "", avatar: "")
    }
}
