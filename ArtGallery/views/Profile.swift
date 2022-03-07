//
//  Profile.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack {
            
            VStack(spacing: 20) {
                if viewModel.avatar == "" {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                } else {
                    WebImage(url: URL(string: viewModel.avatar))
                        .resizable()
                        .frame(width: 100, height: 100, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
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
            
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
