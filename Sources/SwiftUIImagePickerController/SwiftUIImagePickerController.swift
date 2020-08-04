//
//  SwiftUIImagePicker.swift
//  CameraAccess
//
//  Created by Tomoaki Yagishita on 2020/08/03.
//  Copyright © 2020 SmallDeskSoftware. All rights reserved.
//

import Foundation
import SwiftUI

public struct SwiftUIImagePickerController: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Binding var metaData: NSDictionary?
    @Binding var showCameraView: Bool
    
    public init(image: Binding<UIImage?>, metaData: Binding<NSDictionary?>, showCameraView: Binding<Bool>) {
        self._image = image
        self._metaData = metaData
        self._showCameraView = showCameraView
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            viewController.sourceType = .camera
        }

        return viewController
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: SwiftUIImagePickerController
        
        init(_ parent: SwiftUIImagePickerController) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // user picked an image
            if let uiImage = info[.originalImage] as? UIImage {
                if let metaData = info[.mediaMetadata] as? NSDictionary{
                    self.parent.metaData = metaData
                }
                self.parent.image = uiImage
            }
            self.parent.showCameraView = false
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.showCameraView = false
        }
    }
    
}
