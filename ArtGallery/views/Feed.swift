//
//  Feed.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject private var userViewModel: UserViewModel
    @StateObject var viewModel: FeedViewModel
    @State private var selected: Bool = true
    @State private var timelineSelected: Bool = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: FeedViewModel())
    }
    var body: some View {
        VStack {
            HStack {
                Text("Art Gallery")
                    .font(.headline)
                
                Spacer()
                
                HStack {
                    Button(action:{
                        selected.toggle()
                        timelineSelected.toggle()
                    }) {
                        if timelineSelected {
                            Image(systemName: "square.dashed")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                            
                        } else {
                            Image(systemName: selected ? "square.dashed.inset.filled" : "square.dashed")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        }
                        
                    }
                   
                    Button(action:{
                        timelineSelected.toggle()
                        selected.toggle()
                    }) {
                        
                        
                        if selected {
                            Image(systemName: "square.dashed")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        } else {
                            Image(systemName: timelineSelected ? "square.dashed.inset.filled" : "square.dashed")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.red)
                        }
                   
                    }
                   
                }
            }
            .padding(.horizontal)
            .padding(10)
            .background(colorScheme == .light ? Color.white : Color.black)
         
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        
                        VStack {
                            HStack(spacing: 10) {
                                WebImage(url: URL(string: post.avatar))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                Text(post.username)
                                
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
                        }.redacted(reason: viewModel.isLoading ? .placeholder : [])
                        .padding()
                            .background(colorScheme == .light ?  Color.black.opacity(0.05) : Color.white.opacity(0.09))
                        .cornerRadius(10)
                        .padding()
                        
                    }
                }
            }
        }
        .onReceive(viewModel.$posts, perform: { _ in
            Task {
                await viewModel.getPosts()
            }
        })
        
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
