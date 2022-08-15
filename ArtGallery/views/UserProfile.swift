//
//  UserProfile.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/21/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) private var colorScheme
    private var userId: String
    private var selectedUserAvatar: String
    private var selectedUsername: String
    private var selectedUserBio: String
    
    init(userId: String, selectedUserAvatar: String, selectedUsername: String, selectedUserBio: String) {
        self.userId = userId
        self.selectedUserAvatar = selectedUserAvatar
        self.selectedUsername = selectedUsername
        self.selectedUserBio = selectedUserBio
    }
    var body: some View {
        VStack {
            
            VStack {
                HStack {
                    
                    Button(action:{ presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: .leading)
                            .foregroundColor(Color.red)
                    }
                    
                    Spacer()
                   
                    
                }.padding(.horizontal)
                
                VStack(spacing: 20) {
                    
                        WebImage(url: URL(string: selectedUserAvatar))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: .center)
                 
                    Text(selectedUsername)
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    
                    Text(selectedUserBio)
                        .font(.caption)
                        .foregroundColor(Color.primary)
                    
                  /*
                   HStack(spacing: 20) {
                       VStack {
                           Text(String(viewModel.selectedUserFollowers.count))
                           Text("Followers")
                               .font(.subheadline)
                       }
                    
                       
                       VStack {
                           Text(String(viewModel.selectedUserFollowing.count))
                           Text("Following")
                               .font(.subheadline)
                       }
                       
                   }
                   */
                   
                }
            }
            
         
            Spacer()
        }
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(userId: "", selectedUserAvatar: "", selectedUsername: "", selectedUserBio: "")
    }
}
