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
                Text("Art Gallery").font(.subheadline)
                
                Spacer()
                
                Button(action:{}) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.primary)
                }
            }.padding(.horizontal)
            
            ScrollView(showsIndicators: false) {
                
                LazyVStack {
                    ForEach(viewModel.posts) { post in
                        
                        HStack {
                            WebImage(url: URL(string: post.avatar))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .aspectRatio(contentMode: .fill)
                            
                            Spacer()
                            
                            Text(post.username)
                            
                        }
                        
                        WebImage(url: URL(string: post.image))
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .aspectRatio(contentMode: .fill)
                    
                        
                    }
                }
            }
        }
      
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
