//
//  Upload.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/1/22.
//
import SwiftUI

struct UploadView: View {
    @Environment(\.colorScheme) private var colorScheme
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var viewModel: UploadViewModel
    @State private var isShowingPicker = false
    @State private var image: UIImage?
    @State var titleInput: String = ""
    @State var descriptionInput: String = ""
    
    init() {
        self._viewModel = StateObject(wrappedValue: UploadViewModel(delegate: UploadRepository()))
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action:{
                    image = nil
                    titleInput = ""
                    descriptionInput = ""
                }) {
                    Image(systemName: "x.square")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                }
                
                Spacer()
                
                Text("Upload")
                    .font(.headline)
                    .padding(.top,3)
                Spacer()
                
                Button(action: {
                    if image == nil { return }
                    
                    viewModel.uploadImage(image: image!, postDescription: descriptionInput, title: titleInput)
                    
                    image = nil
                    titleInput = ""
                    descriptionInput = ""
                }) {
                    
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                }
            }
            .padding(.horizontal)
            .padding(10)
            .background(colorScheme == .light ? Color.white : Color.black)
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
            }
            
            TextField("Title", text: $titleInput)
                .multilineTextAlignment(.center)
                .padding()
                .background(colorScheme == .light ?  Color.black.opacity(0.05) : Color.white.opacity(0.05))
                .cornerRadius(10)
                .padding(.horizontal)
            
            Spacer()
            
            VStack {
                
                VStack {
                    if viewModel.isLoading { ProgressView() }
                    if image != nil {
                        
                        Button(action:{ isShowingPicker = true }) {
                            
                            Image(uiImage: image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .center)
                                .padding()
                        }
                    } else {
                        
                        Button(action: { isShowingPicker = true }) {
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 200, height: 200, alignment: .center)
                                .padding()
                                .foregroundColor(Color.primary)
                        }
                    }
                }
              
            }
         
            Spacer()
           
            TextField("Description", text: $descriptionInput)
                .multilineTextAlignment(.center)
                .padding()
                .background(colorScheme == .light ? Color.black.opacity(0.05) : Color.white.opacity(0.05))
                .cornerRadius(10)
                .padding(.horizontal)
            
            
            Spacer()
            
        }.background(colorScheme == .light ? Color.black.opacity(0.05) : Color.white.opacity(0.09))
        .sheet(isPresented: $isShowingPicker, content: {
            ImagePicker(image: $image)
        })

    }
}


struct Upload_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
