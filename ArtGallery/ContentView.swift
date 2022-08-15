//
//  ContentView.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI

struct ContentView: View {
    @AppStorage("Authorization") var auth = false
    var body: some View {
        NavigationView {
            switch auth {
            case true:
                CoreView()
            case false:
                LoginView()
            }
        }.navigationViewStyle(StackNavigationViewStyle())

    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
