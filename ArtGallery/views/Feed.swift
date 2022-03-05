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
                            
                        
                    }
                }
            }
        }.task {
            
        }
      
    }
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
