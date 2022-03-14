//
//  Comments.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = CommentViewModel()
    @State private var commentInput: String = ""
    var body: some View {
        VStack {
            HStack {
                Button(action:{ presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .frame(width: 15, height: 15, alignment: .leading)
                        .foregroundColor(Color.red)
                }
              
                
                Spacer()
                
                Text("Comments")
                    .font(.headline)
                    .padding(.top, 5)
                
                Spacer()
                
                Button(action:{}) {
                    Image(systemName: "slider.horizontal.3")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.red)
                }
              
            }.padding(.horizontal)
                .padding(10)
                .background(colorScheme == .light ? Color.white : Color.black)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    
                    HStack(spacing: 10) {
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 40, height: 40, alignment: .center)
                            .clipShape(Circle())
                        
                        VStack(spacing: 7) {
                            
                            Text("Username")
                                .font(.caption2)
                            Text("Comment")
                                .font(.caption)
                                .lineLimit(7)
                        }
                        
                        Spacer()
                        
                        VStack(spacing: 7) {
                            Button(action:{}) {
                                Image(systemName: "heart")
                                    .resizable()
                                    .frame(width: 11, height: 11, alignment: .center)
                                    .foregroundColor(Color.primary)
                            }
                            Text("0")
                                .font(.caption2)
                                .foregroundColor(Color.primary)
                        }
                       
                    }.padding(.horizontal)
                    
                }.padding()
                Divider()
            }
            
            HStack {
                TextField("Add Comment", text: $commentInput)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .cornerRadius(10)
                Button(action:{}) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                }
               
            }.padding(.horizontal)
                .background(colorScheme == .light ? Color.white : Color.black)
        }.navigationTitle("")
         .navigationBarHidden(true)
         .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
    
      
    }
}

struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
