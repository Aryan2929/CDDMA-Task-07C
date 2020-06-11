//
//  ImagePicker.swift
//  Week5
//
//  Created by Aryan Bishnoi on 30/5/20.
//  Copyright © 2020 Aryan Bishnoi. All rights reserved.
//

import Foundation
import UIKit
class PickerController: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Select any option", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    var applyFilter : Bool = false

    func selectImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        
//        let cameraAction = UIAlertAction(title: "Camera", style: .default){
//            UIAlertAction in
//            self.openCamera()
//        }
        let gallaryAction = UIAlertAction(title: "Gallary", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        picker.delegate = self
//        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
//    func openCamera(){
//        alert.dismiss(animated: true, completion: nil)
//        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
//            picker.sourceType = .camera
//            self.viewController!.present(picker, animated: true, completion: nil)
//        }
//    }
    func openGallery(){
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    
}
extension PickerController{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
        print(fileUrl.lastPathComponent) // get file Name
        print(fileUrl.pathExtension)     // get file extension
        
        
        // save your image here into Document Directory
        //saveImage(tempImage, path: fileInDocumentsDirectory("tempImage"))
        guard let image = info[.originalImage] as? UIImage else { return }
        pickImageCallback?(image)
    }
    
//    func saveImage (image: UIImage, path: String ) -> Bool{
//
//        let pngImageData = UIImagePNGRepresentation(image)
//        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
//        let result = pngImageData.writeToFile(path, atomically: true)
//
//        return result
//
//    }
//
//    // Get the documents Directory
//
//    func documentsDirectory() -> String {
//        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
//        return documentsFolderPath
//    }
//    // Get path for a file in the directory
//
//    func fileInDocumentsDirectory(filename: String) -> String {
//        return documentsDirectory().stringByAppendingPathComponent(filename)
//    }
}

