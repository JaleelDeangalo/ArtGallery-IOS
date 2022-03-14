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
    @StateObject var viewModel = ProfileViewModel()
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
                if viewModel.avatar == "" {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                    
                } else {
                    WebImage(url: URL(string: viewModel.avatar))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                        
                }
             
                Text(viewModel.username == "" ? "Username" : viewModel.username)
                    .font(.headline)
                    .foregroundColor(Color.primary)
                
                Text(viewModel.bio == "" ? "Bio" : viewModel.bio)
                    .font(.caption)
                    .foregroundColor(Color.primary)
                
                HStack(spacing: 20) {
                    VStack {
                        Text(String(viewModel.followers))
                        Text("Followers")
                            .font(.subheadline)
                    }
                 
                    
                    VStack {
                        Text(String(viewModel.following))
                        Text("Following")
                            .font(.subheadline)
                    }
                    
                }
               
            }
            
            Button(action:{}) {
                Text("Edit Profile")
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 40)
            }.padding(.top, 5)
          Spacer()
            
        }.background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
