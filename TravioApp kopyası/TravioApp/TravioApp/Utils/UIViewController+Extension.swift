//
//  UIViewController+Extension.swift
//  TravioApp
//
//  Created by Tarik Efe on 14.09.2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showLoginAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yeniden Dene", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showVisitAlert(message: String) {
        let alertController = UIAlertController(title: "Bilgi", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func cameraLibraryAlert(title: String, message: String, cameraHandler: (() -> Void)?, libraryHandler: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            cameraHandler?()
        }
        
        let libraryAction = UIAlertAction(title: "Photo Library", style: .default) {
            _ in libraryHandler?()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alertController.addAction(cameraAction)
        }
        
        alertController.addAction(libraryAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}
