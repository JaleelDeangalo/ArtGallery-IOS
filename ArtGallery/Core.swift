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
                .navigationTitle("")
                .navigationBarHidden(true)
            
            UploadView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus")
                        Text("Upload")
                    }
                }.navigationTitle("")
                .navigationBarHidden(true)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }.navigationTitle("")
                .navigationBarHidden(true)
            
        }.accentColor(Color.red)
    }
}

struct Core_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}
