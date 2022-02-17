//
//  DbUtils.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import Foundation

//import library
import SQLite

class DbUtils {
    // sqlite instance
    private var db: Connection!
    
    // table instance
    private var users: Table!
    
    // Columns instances of the table
    private var id: Expression<Int64>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var age: Expression<Int64>!
    
    // constructor of this class
    
    init() {
        
        // exception handling
        do {
            
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            // creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
            
            // creating table object
            users = Table("users")
            
            // creating instances of each column
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            email = Expression<String>("email")
            age = Expression<Int64>("age")
            
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
                
                // if not, then create the table
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(email, unique: true)
                    t.column(age)
                })
                
                // set the value to true so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
            
        } catch {
            
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    public func addUser(nameValue: String, emailValue: String, ageValue: Int64) {
        
        do {
            try db.run(users.insert(name <- nameValue, email <- emailValue, age <- ageValue))
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
}
