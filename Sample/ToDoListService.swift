//
//  ToDoListService.swift
//  Sample
//
//  Created by Morteza on 11/14/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//


import Foundation
import ObjectMapper

protocol ToDoListProtocol : class{
  
  func loadAllToDo(albums:[ToDoModel])
  func loadAllToDoWithError(error:ServiceError)
  
}

class ToDoListServiceCore {
  
  static let sharedInstance = ToDoListServiceCore()
  weak   var toDoListDelegate: ToDoListProtocol?
  
  func getToDoList() {
    
    NetworkingBrain.sharedInstance.sendRequest(endpoint: .toDo, httpMethod: .get) { serverResponse in
      
      if(!serverResponse.hasError!){
        
        guard let jsonData = serverResponse.backData else {
          return
        }
        
        guard let albums = Mapper<ToDoModel>().mapArray(JSONObject: jsonData as? [Any] ) else {
          
          let error = ServiceError(customCode: ErrorCodes.json, httpCode: serverResponse.statusCode, message: ServerGeneralErros.croptedData.localized)
          
          self.toDoListDelegate?.loadAllToDoWithError(error: error)
          return
        }
        
        self.toDoListDelegate?.loadAllToDo(albums: albums)
        
        
      }
      else{
        
        let error = ServiceError(httpCode: serverResponse.statusCode, message: serverResponse.message)
        self.toDoListDelegate?.loadAllToDoWithError(error: error)
      }
    }
  }
  
}
