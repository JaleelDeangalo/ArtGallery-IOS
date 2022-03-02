//
//  Core.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct CoreView: View {
    init() {
        UITabBar.appearance().isTranslucent = false
    }
    var body: some View {
        TabView {
            
            FeedView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Feed")
                    }
                }
            
            UploadView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus")
                        Text("Upload")
                    }
                }
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }
            
        }
    }
}

struct Core_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}
