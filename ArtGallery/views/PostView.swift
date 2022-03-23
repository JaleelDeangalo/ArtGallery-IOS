//
//  PostView.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/23/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    @ObservedObject var viewModel: FeedViewModel
    let post: Post
    var body: some View {
        
        VStack {
            HStack(spacing: 10) {
                WebImage(url: URL(string: viewModel.postAvatar))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(viewModel.postUsername)
                
                Spacer()
                
                NavigationLink(destination: UserProfile(userId: post.userId)) {
                    
                    Image(systemName: "ellipsis.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.primary)
                }
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
        
            
            WebImage(url: URL(string: post.image))
                .resizable()
                .frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .padding(.horizontal)
            
            HStack {
                Text(post.postDescription)
                    .font(.subheadline)
                Spacer()
                HStack(spacing: 8) {
                    Button(action:{
                        Task {
                            switch viewModel.checkIfLiked(currentUserId: viewModel.currentUserId, post: post) {
                                
                            case false:
                                await viewModel.likePost(id: post.id)
                            case true:
                                await viewModel.unlikePost(id: post.id)
                                
                            }
                        }
                    }) {
                        Image(systemName: viewModel.checkIfLiked(currentUserId: viewModel.currentUserId, post: post) ? "heart.fill" : "heart")
                            .foregroundColor( viewModel.checkIfLiked(currentUserId: viewModel.currentUserId, post: post) ? Color.red : Color.primary)
                    }
                    Text("\(post.likesCount.count)")
                    
                    NavigationLink(destination: CommentsView(currentUserId: viewModel.currentUserId, postId: post.id)) {
                        Image(systemName: "text.bubble")
                    }.foregroundColor(Color.primary)
                    Text("\(post.commentsCount.count)")
                    
                }
               
            }.padding(.horizontal)
        }.onAppear {
            Task {
                await viewModel.getSelectedUserPosts(id: post.userId)
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(viewModel: FeedViewModel(), post: Post(id: "", image: "", username: "username", avatar: "", commentsCount: ["",""], likesCount: ["",""], postDescription: "example", title: "example", userId: ""))
    }
}
