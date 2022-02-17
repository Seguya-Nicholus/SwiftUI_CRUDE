//
//  ContentView.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import SwiftUI

struct ContentView: View {
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
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
