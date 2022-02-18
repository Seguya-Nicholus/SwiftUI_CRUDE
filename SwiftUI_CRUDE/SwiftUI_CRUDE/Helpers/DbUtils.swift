//
//  DbUtils.swift
//  SwiftUI_CRUDE
//
//  Created by Nicholas Sseguya on 17/02/2022.
//

import Foundation

//import library
import SQLite
import UIKit

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
    
    
    // function to return all users
    public func getUsers() -> [User] {
        
        // create an empty array
        var usersArray: [User] = []
        
        // get all user in descending order
        users = users.order(id.desc)
        
        // handle exception
        do {
            
            // loop through all users
            for user in try db.prepare(users) {
                
                // create model in each loop iteration
                let userModel: User = User()
                
                // set values of model from database
                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.age = user[age]
                
                
                // append in new array
                usersArray.append(userModel)
            }
            
        } catch  {
            print(error.localizedDescription)
        }
        
        return usersArray
    }
    
    
    public func getUser(idValue: Int64) -> User {
        
        // create an empty object
        let userModel: User = User()
        
        // handle exception
        do {

            // get user using id
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))
            
            // get row
            try user.forEach({ (rowValue) in
                
               // set values in model
                userModel.id = try rowValue.get(id)
                userModel.name = try rowValue.get(name)
                userModel.email = try rowValue.get(email)
                userModel.age = try rowValue.get(age)
            })
            
        } catch  {
            print(error.localizedDescription)
        }
        
        return userModel
    }
    
    
    // function to update user
    public func updateUser(idValue: Int64, nameValue: String, emailValue: String, ageValue: Int64) {
        
        do {
            
            // get user by Id
            let user: Table = users.filter(id == idValue)
            
            // run the update query
            try db.run(user.update(name <- nameValue, email <- emailValue, age <- ageValue))
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    
    // function to delete user
    public func deleteUser(idValue: Int64) {
        
        do {
            // get user by Id
            let user: Table = users.filter(id == idValue)
            
            // run the delete query
            try db.run(user.delete())
        } catch  {
            print(error.localizedDescription)
        }
    }
    
}
