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
    @StateObject var viewModel = FeedViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Art Gallery")
                    .font(.headline)
                
                Spacer()
                
                HStack {
                    Button(action:{}) {
                        Image(systemName: "square.dashed")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
                    }
                   
                    Button(action:{}) {
                        Image(systemName: "square.dashed.inset.filled")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.red)
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
                                Button(action:{}) {
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
                                    Button(action:{}) {
                                        Image(systemName: "heart")
                                            .foregroundColor(Color.primary)
                                    }
                                    Text("0")
                                    
                                    NavigationLink(destination: CommentsView()) {
                                        Image(systemName: "text.bubble")
                                    }.foregroundColor(Color.primary)
                                    Text("0")
                                    
                                }
                               
                            }.padding(.horizontal)
                        }.padding()
                            .background(colorScheme == .light ?  Color.black.opacity(0.05) : Color.white.opacity(0.09))
                        .cornerRadius(10)
                        .padding()
                        
                    }
                }
            }
        }.onAppear {
            Task {
                await viewModel.getPosts()
            }
        }
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        
            
      
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
