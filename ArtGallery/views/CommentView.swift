//
//  CommentView.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/23/22.
//
import SwiftUI
import SDWebImageSwiftUI

struct CommentView: View {
    var body: some View {
      
        HStack(spacing: 10) {
            
            /*
            
            WebImage(url: URL(string: viewModel.commentAvatar))
                .resizable()
                .aspectRatio( contentMode: .fill)
                .frame(width: 40, height: 40, alignment: .center)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 7) {
                
                Text(viewModel.commentUsername)
                    .font(.caption2)
                Text(comment.comment)
                    .font(.caption)
                    .lineLimit(7)
            }
            
            Spacer()
            
            VStack(spacing: 7) {
                Button(action:{
                    Task {
                        switch viewModel.checkIfLiked(currentUserId: currentUserId, comment: comment) {
                            
                        case false:
                            await viewModel.likeComment(commentId: comment.id)
                        case true:
                            await viewModel.unlikeComment(commentId: comment.id)
                        }
                    }
                }) {
                    Image(systemName: viewModel.checkIfLiked(currentUserId: currentUserId, comment: comment) ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 11, height: 11, alignment: .center)
                        .foregroundColor(viewModel.checkIfLiked(currentUserId: currentUserId, comment: comment) ? Color.red : Color.primary)
                }
                Text("\(comment.likes.count)")
                    .font(.caption2)
                    .foregroundColor(Color.primary)
                
            }
            */
           
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
