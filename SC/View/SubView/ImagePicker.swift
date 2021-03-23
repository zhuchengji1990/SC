//
//  ImagePicker.swift
//  BookKeeping
//
//  Created by 沉寂 on 2020/12/15.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    var configuration: PHPickerConfiguration?
    let onImagesPicked: ([UIImage]) -> Void
    
    private var defaultConfiguration: PHPickerConfiguration {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .compatible
        return config
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration ?? defaultConfiguration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_: PHPickerViewController, context _: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            var array = [UIImage]()
            for image in results {
                image.itemProvider.loadObject(ofClass: UIImage.self) { selectedImage, error in
                    if error == nil,
                       let uiImage = selectedImage as? UIImage{
                        array.append(uiImage)
                    }
                }
            }
            
            self.parent.onImagesPicked(array)
            
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
