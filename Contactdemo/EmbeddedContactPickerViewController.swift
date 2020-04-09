//
//  EmbeddedContactPickerViewController.swift
//  Contactdemo
//
//  Created by Bharat on 08/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import Foundation
import ContactsUI

protocol EmbeddedContactPickerViewControllerDelegate: class {
    
    func embeddedContactPickerViewControllerDidCancel(_ viewController: EmbeddedContactPickerViewController)
    
    func embeddedContactPickerViewController(_ viewController: EmbeddedContactPickerViewController, didSelect contact: CNContact)
}

class EmbeddedContactPickerViewController: UIViewController, CNContactPickerDelegate,ObservableObject {
    
    weak var delegate: EmbeddedContactPickerViewControllerDelegate?
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.open(animated: animated)

    }

    private func open(animated: Bool) {
        
        let viewController = CNContactPickerViewController()
        viewController.delegate = self
        viewController.view.backgroundColor = UIColor.white
        self.present(viewController, animated: false)
        
    }

    // MARK: Delegate method CNContectPickerDelegate
     func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        delegate?.embeddedContactPickerViewController(self, didSelect:contact)
//         print(contact.phoneNumbers)
//         let numbers = contact.phoneNumbers.first
//         print((numbers?.value)?.stringValue ?? "")
//         print(contact.givenName)
//        self.phNumber = (numbers?.value.stringValue)!
//        print("mmmmm \(self.phNumber)")
        
     }
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        self.dismiss(animated: true, completion: nil)
        delegate?.embeddedContactPickerViewControllerDidCancel(self)
    }
    
}
