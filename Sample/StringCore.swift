//
//  StringCore.swift
//  TouchTunesTest
//
//  Created by Morteza on 10/30/18.
//  Copyright © 2018 Morteza Hosseini Zadeh. All rights reserved.
//

import Foundation


enum ServerGeneralErros :String{
    
    case jsonFormat                = "JsonFormatError"
    case croptedData               = "CroptedData"
    case unknowError               = "UnknowServerError"
    case unauthorized              = "Unauthorized"
    case requestTimeOutError       = "RequestTimeOutError"
    case noInternetConnectionError = "NoInternetConnectionError"

}

enum SearchBarErrorMessages: String{
    
    case empty       = "SearchBarIsEmpty"
    case toManyInput = "SearchBarToManyInput"
}

enum ServerSuccessMessages :String{
    
    case dataReceived   = "DataReceived"
    case noResult       = "NoResult"
}


extension RawRepresentable where RawValue : StringProtocol{
    
    var localized: String {
        return (self.rawValue as! String).localized
    }
}

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "StringCore", bundle: Bundle.main, value: "", comment: "")
    }
    
}
