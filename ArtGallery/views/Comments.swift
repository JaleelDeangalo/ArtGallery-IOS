//
//  Comments.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentsView: View {
    var currentUserId: String = ""
    var postId: String = ""
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CommentViewModel
    @State private var commentInput: String = ""
    
    init(currentUserId: String, postId: String) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel())
        self.currentUserId = currentUserId
        self.postId = postId
    }
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
              
            }
                .padding(10)
                .padding(.horizontal)
                .background(colorScheme == .light ? Color.white : Color.black)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    
                    ForEach(viewModel.comments) { comment in
                        
                        CommentView(viewModel: viewModel, comment: comment, currentUserId: currentUserId).padding(.horizontal)
                            .padding()
                            .onAppear {
                                Task {
                                    await viewModel.getSelectedUserComment(id: comment.user)
                                }
                            }
                        
                        Divider()
                    }
                  
                }.padding()
            }
          
            
            HStack {
                TextField("Add Comment", text: $commentInput)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .cornerRadius(10)
                Button(action:{
                    Task {
                        if commentInput.isEmpty { return }
                        await viewModel.postComment(postId: postId, comment: commentInput)
                        commentInput = ""
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                }
               
            }.padding(.horizontal)
                .background(colorScheme == .light ? Color.white : Color.black)
        }.task {
            await viewModel.readComments(postId: postId)
        }
        .onReceive(viewModel.$comments, perform: { _ in
            Task {
                await viewModel.readComments(postId: postId)
            }
        })
        .navigationTitle("")
         .navigationBarHidden(true)
         .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
    
      
    }
}

struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(currentUserId: "", postId: "")
    }
}
