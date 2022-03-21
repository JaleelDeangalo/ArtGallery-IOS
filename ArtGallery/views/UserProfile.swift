//
//  UserProfile.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/21/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserProfile: View {
    var userId: String
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel: UserViewModel
    init(userId: String) {
        self.userId = userId
        self._viewModel = StateObject(wrappedValue: UserViewModel())
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
                    
                        WebImage(url: URL(string: viewModel.selectedUserAvatar))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100, alignment: .center)
                 
                    Text(viewModel.selectedUsername)
                        .font(.headline)
                        .foregroundColor(Color.primary)
                    
                    Text(viewModel.selectedUserBio)
                        .font(.caption)
                        .foregroundColor(Color.primary)
                    
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
                   
                }
            }
            
         
            Spacer()
        }.onAppear {
            Task {
                await viewModel.getSelectedUser(id: userId)
            }
        }
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(userId: "")
    }
}
