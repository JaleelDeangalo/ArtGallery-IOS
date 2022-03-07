//
//  Upload.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//

import SwiftUI

struct UploadView: View {
    @StateObject var viewModel = UploadViewModel()
    @State private var isShowingPicker = false
    @State private var image: UIImage?
    @State var titleInput: String = ""
    @State var descriptionInput: String = ""
    var body: some View {
        VStack {
            
            HStack {
                Button(action:{
                    image = nil
                    titleInput = ""
                    descriptionInput = ""
                }) {
                    Text("cancel")
                        .foregroundColor(Color.primary)
                }
                
                Spacer()
                
                Button(action:{
                    
                }) {
                    Text("upload")
                        .foregroundColor(Color.primary)
                }
            }
            .padding(.horizontal)
            Spacer()
            TextField("Title", text: $titleInput)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    .onTapGesture {
                        isShowingPicker = true
                    }
            } else {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200, height: 200, alignment: .center)
                    .padding()
                    .onTapGesture {
                        isShowingPicker = true
                    }
                
            }
            
            Spacer()
           
            TextField("Description", text: $descriptionInput)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            Spacer()
            
        }.sheet(isPresented: $isShowingPicker, content: {
            ImagePicker(image: $image)
        })

    }
}

struct Upload_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
