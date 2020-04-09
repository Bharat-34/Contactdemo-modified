//
//  EmbeddedContactPicker.swift
//  Contactdemo
//
//  Created by Bharat on 08/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import Foundation
import SwiftUI
import Contacts


struct EmbeddedContactPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = EmbeddedContactPickerViewController
    
    var pickedContact:((CNContact)->())?
    
    final class Coordinator: NSObject, EmbeddedContactPickerViewControllerDelegate {
        
        var parent : EmbeddedContactPicker
        
        init(_ parent: EmbeddedContactPicker){
            self.parent = parent
        }
        
        
        func embeddedContactPickerViewController(_ viewController: EmbeddedContactPickerViewController, didSelect contact: CNContact) {
            parent.pickedContact?(contact)
         }
        

        func embeddedContactPickerViewControllerDidCancel(_ viewController: EmbeddedContactPickerViewController) {
            //parent.setContact(contact: CNContact())
        }
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    

    func makeUIViewController(context: UIViewControllerRepresentableContext<EmbeddedContactPicker>) ->EmbeddedContactPicker.UIViewControllerType {
        
        let result = EmbeddedContactPicker.UIViewControllerType()
        result.delegate = context.coordinator
        return result
            
    }
    

    func updateUIViewController(_ uiViewController: EmbeddedContactPicker.UIViewControllerType, context: UIViewControllerRepresentableContext<EmbeddedContactPicker>) { }
    

}

