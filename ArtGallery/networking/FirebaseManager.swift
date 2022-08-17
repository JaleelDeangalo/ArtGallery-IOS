//
//  FirebaseManager.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/4/22.
//
import Foundation
import Firebase
import FirebaseStorage
final class FirebaseManager: NSObject {
    static let shared = FirebaseManager()
    
    let storage: Storage
    
    override init() {
        FirebaseApp.configure()
        self.storage = Storage.storage()
        super.init()
    }
    
}
