//
//  ImagePicker.swift
//  Stylepoll
//
//  Created by Romesh Singhabahu on 04/10/2020.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var showImagePicker: Bool
    @Binding var pickedImage: Image
    @Binding var imageData: Data
   
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) ->  ImagePicker.UIViewControllerType {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        return
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        //Coordinator(self)
        Coordinator.init(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parentImagePicker: ImagePicker
        
        init(_ imagePicker: ImagePicker) {
            self.parentImagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as!
            UIImage
            
            parentImagePicker.pickedImage = Image(uiImage: uiImage)
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5) {
                parentImagePicker.imageData = mediaData
                print(parentImagePicker.imageData)
            }
            
            parentImagePicker.showImagePicker = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parentImagePicker.showImagePicker = false
        }
        
    }
    
}
