//
//  ContentView.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var usersArray: [User] = []
    
    // check if user is selected for edit
    @State var isUserSelected: Bool = false
    
    // id of selected user to edit or delete
    @State var selectedUserId: Int64 = 0
    
    var body: some View {
        
        // create navigation view
        NavigationView {
            
            VStack {
                
                // Create link to add new user
                HStack {
                    Spacer()
                    NavigationLink(
                        destination: AddNewUserView(),
                        label: {
                            Text("Add User")
                        })
                }
                
                // navigation link to go to edit user view
                
                NavigationLink(destination:
                                EditUserView(id:
                                self.$selectedUserId), isActive:
                                self.$isUserSelected) {
                    EmptyView()
                }
                
                //  create listview to show all users
                List(self.usersArray) { (model) in
                    
                    // show name, email and age horizontally
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text("\(model.age)")
                        
                        // button to edit user
                        Button(action: {
                            self.selectedUserId = model.id
                            self.isUserSelected = true
                        }, label: {
                            Text("Edit")
                            .foregroundColor(Color.blue)}
                        )
                        // by default buttons are full width , to prevent this use the following
                            .buttonStyle(PlainButtonStyle())
                        
                        //  button to delete user
                        Button(action: {
                            // create a db instance
                            let dbManager: DbUtils = DbUtils()
                            
                            // call delete function
                            dbManager.deleteUser(idValue: model.id)
                            
                            // refresh the user model array
                            self.usersArray = dbManager.getUsers()
                        }, label: {
                            Text("Delete")
                            .foregroundColor(Color.red)}
                        )
                        // by default buttons are full width , to prevent this use the following
                            .buttonStyle(PlainButtonStyle())
                        
                    }
                }
            }.padding()
            
            // load data in the users array
                .onAppear(perform: {
                    self.usersArray = DbUtils().getUsers()
                })
                .navigationBarTitle("Users")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
