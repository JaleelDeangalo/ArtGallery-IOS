//
//  Core.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct CoreView: View {
    @StateObject var userViewModel: UserViewModel
    init() {
        self._userViewModel = StateObject(wrappedValue: UserViewModel())
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
                .environmentObject(userViewModel)
            
            UploadView()
                .tabItem {
                    VStack {
                        Image(systemName: "plus")
                        Text("Upload")
                    }
                }.navigationTitle("")
                .navigationBarHidden(true)
                .environmentObject(userViewModel)
            
            ProfileView()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                }.navigationTitle("")
                .navigationBarHidden(true)
                .environmentObject(userViewModel)
            
        }.accentColor(Color.red)
    }
}

struct Core_Previews: PreviewProvider {
    static var previews: some View {
        CoreView()
    }
}
