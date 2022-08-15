//
//  PostView.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/23/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    private var post: Post
    init(post: Post) {
        self.post = post
    }
    var body: some View {
        
        VStack {
            
            HStack(spacing: 10) {
                WebImage(url: URL(string: post.avatar))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                Text(post.username)
                
                Spacer()
                
                Text("2 Hours ago")
                    .foregroundColor(Color.primary)
                    .font(.caption)
                
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
                    
                    /*
                     Button(action:{}){
                         Image(systemName: "heart")
                     }.foregroundColor(.primary)
                     Text("\(post.likesCount.count)")
                     */
                    
                    NavigationLink(destination: CommentsView( postId: post.id)) {
                        Image(systemName: "text.bubble")
                    }.foregroundColor(Color.primary)
                    Text("\(post.commentsCount.count)")
                    
                }
               
            }.padding(.horizontal)
            
        }
        
    }
 }
    

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: Post(id: "", image: "", username: "Test", avatar: "", commentsCount: [""], likesCount: [""], postDescription: "Example", title: "Example_Ttitle", userId: ""))
    }
}
