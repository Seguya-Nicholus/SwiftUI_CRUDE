//
//  AddNewUserView.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import SwiftUI

struct AddNewUserView: View {
    
    // Create variables to store user input values
    @State var name: String = ""
    @State var email: String = ""
    @State var age: String = ""
    
    // to go back to the home screen when a new user has been added
    @Environment(\.presentationMode) var
            mode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            
            
            // Create name field
            TextField("Enter name ", text: $name)
                .background(Color(.systemGray6))
                .padding(10)
                .disableAutocorrection(true)
                .cornerRadius(5)
            
            
            // Create email field
            TextField("Enter email ", text: $email)
                .background(Color(.systemGray6))
                .padding(10)
                .disableAutocorrection(true)
                .cornerRadius(5)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            
            // Create age field
            TextField("Enter age ", text: $age)
                .background(Color(.systemGray6))
                .padding(10)
                .disableAutocorrection(true)
                .cornerRadius(5)
                .keyboardType(.numberPad)
            
            
            
            // Button to add new user
            Button(action: {
                
                // call function to add a record to the sqlite database
                DbUtils().addUser(nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                
                
                //go back to the home screen
                self.mode.wrappedValue.dismiss()
                
                
            }, label: {
                Text("Add User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
    }
}

struct AddNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewUserView()
    }
}
