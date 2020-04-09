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
                    if ((self.pickedContact?.imageData) != nil) {
                        Image(uiImage: UIImage(data: (pickedContact?.imageData)!)!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth:2))
                            .shadow(radius:1)
                    }else{
                        Text("\(pickedContact!.givenName.first(char: 1))\(pickedContact!.familyName.first(char: 1))")
                            .font(.headline)
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .frame(width:40,height: 40)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white,lineWidth:0.5))
                            .shadow(radius:1)
                    }
                    
                    VStack(alignment:.leading) {
                        Text("\(pickedContact!.givenName) \(pickedContact!.familyName)")
                            .font(.body)
                        Text("\(self.pickedContact!.phoneNumbers.first!.value.stringValue)")
                            .font(.body)
                        Text("\((self.pickedContact?.emailAddresses.first?.value) ?? "")")
                            .font(.body)
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
    
//    func getInitail() -> String {
//        if (self.pickedContact?.familyName) != nil{
//            return pickedContact?.familyName.utf8.prefix(2)
//        }
//
//        return "tt"
//    }
    
    
    
    
    func getImage() -> UIImage {
        if ((self.pickedContact?.imageData) != nil) {
            return UIImage(data:(pickedContact?.imageData)!)!
          }
        return UIImage(data:(pickedContact?.imageData)!)!
      }
    
    init() {
                       UITableView.appearance().backgroundColor = .clear
                       UITableViewCell.appearance().backgroundColor = .clear
                       UITableView.appearance().tableFooterView = UIView()
            }
   
}

extension String {
    
  func first(char:Int) -> String {
       return String(self.prefix(char))
   }

   func last(char:Int) -> String
   {
       return String(self.suffix(char))
   }

   func excludingFirst(char:Int) -> String {
       return String(self.suffix(self.count - char))
   }

   func excludingLast(char:Int) -> String
   {
        return String(self.prefix(self.count - char))
   }
}
