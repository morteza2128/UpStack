//
//  NetworkingBrain.swift
//  TouchTunesTest
//
//  Created by Morteza on 10/30/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import Foundation

import Alamofire

class NetworkingBrain: NSObject {
    
    static let sharedInstance = NetworkingBrain()
    
    func sendRequest(endpoint:Endpoint, httpMethod:HTTPMethod, parameters:[String: Any]? = nil, headers:[String:String]? = nil, isFirstPage: Bool = true, callback: @escaping (ServerResponse) -> Void) {
        
        Alamofire.request( isFirstPage ? (Config.server.baseUrl + endpoint.url) : endpoint.url , method: httpMethod, parameters: parameters , headers: headers)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                
                
                let serverR = ServerResponse()
                serverR.statusCode = response.response?.statusCode

                switch response.result {
                    
                case .success:
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        serverR.backData = JSON as AnyObject?
                        serverR.hasError = false
                        serverR.message  = ServerSuccessMessages.dataReceived.localized
                        
                        
                    }else{
                        
                        serverR.backData  = nil
                        serverR.hasError  = true
                        serverR.message   = ServerGeneralErros.jsonFormat.localized
                    }
                    callback(serverR)
                    
                    
                case .failure(let responErrror):
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: response.data!, options:
                            JSONSerialization.ReadingOptions.mutableContainers)
                        
                        serverR.backData  = nil
                        serverR.hasError  = true
                        serverR.message   = (jsonResult as AnyObject).object(forKey: "message") as? String
                        callback(serverR)
                        
                    } catch {
                        
                        if responErrror._code == NSURLErrorTimedOut {
                            
                            serverR.backData  = nil
                            serverR.hasError  = true
                            serverR.message   =  ServerGeneralErros.requestTimeOutError.localized
                            callback(serverR)
                        }
                        else if responErrror._code == NSURLErrorNotConnectedToInternet{
                            
                            serverR.backData  = nil
                            serverR.hasError  = true
                            serverR.message   = ServerGeneralErros.noInternetConnectionError.localized
                            callback(serverR)
                        }
                            
                        else if responErrror._code == NSURLErrorNetworkConnectionLost{
                            
                            serverR.backData  = nil
                            serverR.hasError  = true
                            serverR.message   = ServerGeneralErros.noInternetConnectionError.localized
                            callback(serverR)
                        }
                        else{
                            
                            serverR.backData  = nil
                            serverR.hasError  = true
                            serverR.message   = ServerGeneralErros.unknowError.localized
                            callback(serverR)
                        }
                        
                    }
                    
                }
                
        }
        
    }
    
    
}


struct ServiceError {
    
    var customCode: ErrorCodes?
    var httpCode: Int?
    var message: String?
    
    init(customCode:ErrorCodes? = nil, httpCode: Int? = nil, message:String? = nil) {
        
        self.customCode = customCode
        self.httpCode   = httpCode
        self.message    = message
    }
}

enum ErrorCodes : Int{
    
    case json = 1000
    
}
