//
//  ContactObject.swift
//  Contactdemo
//
//  Created by Bharat on 08/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import Foundation
import ContactsUI

class ContactObject : ObservableObject {
    
    @Published var cObj = CNContact()
    @Published var showContactPicker = false
    
}
