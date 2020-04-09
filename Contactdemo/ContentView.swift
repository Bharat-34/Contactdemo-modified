//
//  ContentView.swift
//  Contactdemo
//
//  Created by Bharat on 08/04/20.
//  Copyright © 2020 Bharat. All rights reserved.
//

import SwiftUI
import ContactsUI

struct ContentView: View {
   
    @State var pickedContact:CNContact?
    @State var showContactPicker = false
    
    var body: some View {
        ZStack{
        VStack{
            Spacer(minLength: 500)
            List(){
            
            if self.pickedContact != nil {

                HStack {
                    Image("Dummy")
                    VStack(alignment:.leading) {
                        Text("\(pickedContact!.givenName)")
                        Text("\(self.pickedContact!.phoneNumbers.first!.value.stringValue)")
                    }
                }
            
            }
                
            }.padding()
            
            
            if self.pickedContact != nil {
                Text("\(self.pickedContact!.phoneNumbers.first!.value.stringValue)")
            }
            
            Button(action: {
                self.showContactPicker.toggle()
               
            }){
                Text("Add contacts")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                .cornerRadius(20)
                
            }.padding()
        }.background(Color.gray)
        .edgesIgnoringSafeArea(.all)

            if self.showContactPicker{
                EmbeddedContactPicker { (con) in
                    self.pickedContact = con
                    self.showContactPicker.toggle()
                }
            }
        }
    }
    
    init() {
                       UITableView.appearance().backgroundColor = .clear
                       UITableViewCell.appearance().backgroundColor = .clear
                       UITableView.appearance().tableFooterView = UIView()
            }
   
}
