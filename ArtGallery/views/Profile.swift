//
//  Profile.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel: ProfileViewModel
    init() {
        self._viewModel = StateObject(wrappedValue: ProfileViewModel(delegate: ProfileRepository()))
    }
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: Settings()) {
                    Image(systemName: "gear")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                }
               
                
            }.padding(.horizontal)
            
            VStack(spacing: 20) {
                if viewModel.user.avatar == "" {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                    
                } else {
                    WebImage(url: URL(string: viewModel.user.avatar))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                        
                }
             
                
                
                Text(viewModel.user.username)
                    .font(.headline)
                    .foregroundColor(Color.primary)
                
                
                Text(viewModel.user.bio)
                    .font(.caption)
                    .foregroundColor(Color.primary)
                
                HStack(spacing: 20) {
                    VStack {
                        Text(String(viewModel.user.followers.count))
                        Text("Followers")
                            .font(.subheadline)
                    }
                 
                    
                    VStack {
                        Text(String(viewModel.user.following.count))
                        Text("Following")
                            .font(.subheadline)
                    }
                    
                }
                
               
            }
            
            
            NavigationLink(destination: EditProfileView(bio: viewModel.user.bio, username: viewModel.user.username, email: viewModel.user.email, avatar: viewModel.user.avatar)) {
                Text("Edit Profile")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }.padding(.top, 5)
            
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(viewModel.user.myPosts) { post in
                            
                            WebImage(url: URL(string: post.image))
                                .resizable()
                                .frame(width: 300, height: 150, alignment: .center)
                                .cornerRadius(10)
                        }
                    }
                }
            
        }.task {
            await viewModel.getUser()
        }.background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
