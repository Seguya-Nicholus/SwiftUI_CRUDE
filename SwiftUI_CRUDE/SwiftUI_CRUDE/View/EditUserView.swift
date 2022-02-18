//
//  EditUserView.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import SwiftUI

struct EditUserView: View {
    
    // recieving of user id from previous view
    @Binding var id: Int64
    
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
                
                // call function to update a record in the sqlite database
                DbUtils().updateUser(idValue: self.id, nameValue: self.name, emailValue: self.email, ageValue: Int64(self.age) ?? 0)
                
                
                //go back to the home screen
                self.mode.wrappedValue.dismiss()
                
                
            }, label: {
                Text("Edit User")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
        
        // populate user's data in the fileds when view loads
            .onAppear(perform: {
                
                // get data from database
                let userModel: User = DbUtils().getUser(idValue: self.id)
                
                // populate in textfields
                self.name = userModel.name
                self.email = userModel.email
                self.age = String(userModel.age)
            })
            .navigationBarTitle("Users")
    }
}

struct EditUserView_Previews: PreviewProvider {
    
    // when using @Binding , do this in preview provider
    @State static var id: Int64 = 0
    
    static var previews: some View {
        EditUserView(id: $id)
    }
}
