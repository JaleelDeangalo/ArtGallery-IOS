//
//  Comments.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct CommentsView: View {
    var postId: String
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: CommentViewModel
    @State private var commentInput: String = ""
    
    init(postId: String) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel(delegate: CommentRepository()))
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
                        
                        HStack(spacing: 10) {
                            
                            WebImage(url: URL(string: comment.avatar))
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width: 40, height: 40, alignment: .center)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 7) {
                                
                                Text(comment.username)
                                    .font(.caption2)
                                Text(comment.comment)
                                    .font(.caption)
                                    .lineLimit(7)
                            }
                            
                            Spacer()
                            
                            VStack(spacing: 7) {

                                
                                Text("\(comment.likes.count)")
                                    .font(.caption2)
                                    .foregroundColor(Color.primary)
                                
                            }
                           
                        }.padding()
                       
                        
                 
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
        .navigationTitle("")
         .navigationBarHidden(true)
         .background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
    
      
    }
}

struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(postId: "")
    }
}
