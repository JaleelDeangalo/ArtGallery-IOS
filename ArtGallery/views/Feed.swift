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
    @StateObject private var viewModel: FeedViewModel
    @State private var selected: Bool = true
    @State private var timelineSelected: Bool = false
    
    init() {
        self._viewModel = StateObject(wrappedValue: FeedViewModel(delegate: FeedRepository()))
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
                        
                        PostView(post: post)
                            .padding()
                                .background(colorScheme == .light ?  Color.black.opacity(0.05) : Color.white.opacity(0.09))
                            .cornerRadius(10)
                            .padding()

                    }
                }
            }
            
        }.task {
            await viewModel.getPosts()
        }
       
        .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
       
    }
    
}

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
