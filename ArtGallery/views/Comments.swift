//
//  Comments.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct CommentsView: View {
    @StateObject var viewModel = CommentViewModel()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Comments_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView()
    }
}
