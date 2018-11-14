//
//  ToDoModel.swift
//  Sample
//
//  Created by Morteza on 11/14/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import Foundation
import ObjectMapper

class ToDoModel : Mappable{
  
  var title : String?
  var userId : Int?
  var id : Int?
  var completed = false
  
  required init?(map: Map) {
    
  }
  
  func mapping(map: Map) {
    
    title <- map["title"]
    userId <- map["userId"]
    completed <- map["completed"]
    id <- map["id"]

  }
  
  
}
