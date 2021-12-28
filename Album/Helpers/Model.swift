//
//  Model.swift
//  Album
//
//  Created by Shereen on 24/11/20.
//

import Foundation

class User:Decodable {
    var id : Int
    var email : String
    var first_name : String
    var last_name : String
    var avatar : String
    
    func userName() -> String {
         return self.first_name + " " + self.last_name
      }
}

class UserDetails: Decodable {
    var data: [User]
}
