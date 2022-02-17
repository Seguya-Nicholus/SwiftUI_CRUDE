//
//  ContentView.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var usersArray: [User] = []
    
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
                
                //  create listview to show all users
                List(self.usersArray) { (model) in
                    
                    // show name, email and age horizontally
                    HStack {
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text("\(model.age)")
                        
                    }
                }
            }.padding()
                
                // load data in the users array
                    .onAppear(perform: {
                        self.usersArray = DbUtils().getUsers()
                    })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
