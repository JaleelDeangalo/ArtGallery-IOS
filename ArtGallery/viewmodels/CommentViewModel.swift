//
//  File.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import Foundation

final class CommentViewModel: ObservableObject {
    
    @Published var comment: String = ""
    @Published var userId: String = ""
    
    
}
