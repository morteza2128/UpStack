//
//  Config.swift
//  Sample
//
//  Created by Morteza on 11/14/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import Foundation
class ServerResponse: NSObject {
  
  var backData : AnyObject?
  var hasError : Bool?
  var message  : String?
  var statusCode : NSInteger?
  
}

class Config: NSObject {
  
  static let sharedInstance        = Config()
  public static let server         = Server()
}

struct Server {
  let baseUrl = "http://jsonplaceholder.typicode.com/"
  
  //Other Server config like version port if need
}

enum Endpoint: String {
  case toDo   = "todos/"
  
  var url: String {
    return rawValue
  }
}
