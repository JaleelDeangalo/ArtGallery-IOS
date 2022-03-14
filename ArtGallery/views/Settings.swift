//
//  Settings.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/12/22.
//

import SwiftUI

struct Settings: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.presentationMode) var presentationMode
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
                
                Text("Settings")
                    .font(.headline)
                    .foregroundColor(Color.primary)
                    .padding(.top, 5)
                
                Spacer()
            }.padding(.horizontal)
            Spacer()
            
        }.background(colorScheme == .light ? Color.black.opacity(0.05) :  Color.white.opacity(0.09))
        .navigationTitle("")
        .navigationBarHidden(true)
         
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
