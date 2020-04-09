//
//  contactFetcher.swift
//  Contactdemo
//
//  Created by Bharat on 08/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import Foundation
import SwiftUI
import Contacts

struct Contact:Identifiable {
    
    var id = UUID()
    
    var name:String
    var phoneNumber:String
    var image:Data?
    
}

class ContactsFetcher: ObservableObject {
    
    typealias ContactAccessSuccess = (Bool) ->()
    typealias ContactAccessFailure = (String) ->()
    
    
    @Published var contacts:[Contact] = []
    
    var authStatus:CNAuthorizationStatus {
        return CNContactStore.authorizationStatus(for: .contacts)
    }
    
    func checkPermissionForContacts(success:@escaping ContactAccessSuccess, fail:@escaping ContactAccessFailure){
        
        let status = authStatus
        if authStatus == .authorized{
            success(true)
        }else if status == .notDetermined {
            CNContactStore.init().requestAccess(for: .contacts) { (isGranted, error) in
                if isGranted {
                    success(true)
                }else{
                    fail(error!.localizedDescription)
                }
            }
        }else{
            fail("Please enable permission to contacts in settings app for this application")
        }
        
    }
    
    func refreshContacts(){
        
        let keyToFetch = [CNContactGivenNameKey,CNContactPhoneNumbersKey,CNContactImageDataKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keyToFetch)
        
        do{
            let store = CNContactStore()
            var tempList:[Contact] = []
            
            try store.enumerateContacts(with: fetchRequest, usingBlock: { (contactInfo,_) in
                let name = contactInfo.givenName
                let phoneNumber = contactInfo.phoneNumbers.first!.value.stringValue
                let image = contactInfo.imageData
                tempList.append(Contact(name: name, phoneNumber: phoneNumber, image: image))
            })
            contacts = tempList
            
        }catch{
            fatalError(error.localizedDescription)
        }
    }
}

