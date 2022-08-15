
//  ImagePicker.swift
//  ArtGallery
//
//  Created by Jaleel Gilbert on 3/6/22.
//
import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let imagePicker: ImagePicker
        
        init(imagePicker: ImagePicker) {
            self.imagePicker = imagePicker
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                  
            if let image = info[.editedImage] as? UIImage {
                imagePicker.image = image
            } else {
                // error in picking image
            }
            
            picker.dismiss(animated: true)
        }
    }
    
}


