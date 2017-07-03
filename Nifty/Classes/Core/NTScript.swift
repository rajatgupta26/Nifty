//
//  NTScript.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 20/06/17.
//
//

import Foundation
import JavaScriptCore


//NTLOOK: keeping it internal right now
//may be functionality demands we can expose this
internal struct NTScript {
    //NTLOOK: keeping only name and exception handler for now
    //possibly can have the source url and extra modules as well but (specifically modules) 
    //don't seem to serve much purpose right now. unless we want that dev should be able
    //to create NTScript instances and directly execute them
    
    let name: String
    var url: URL? = nil
    var exceptionHandler: ((JSContext?, JSValue?) -> Swift.Void)? = nil
    
    init(name: String, scriptURL: URL? = nil, exceptionHandler: ((JSContext?, JSValue?) -> Swift.Void)? = nil) {
        self.name = name
        self.url = scriptURL
        self.exceptionHandler = exceptionHandler
    }
    
    mutating func setURL(_ scriptURL: URL?) {
        self.url = scriptURL
    }
    
    mutating func setExceptionHandler(_ handler: ((JSContext?, JSValue?) -> Swift.Void)?) {
        self.exceptionHandler = handler
    }
}


//NTIMP: Hashable and Equatable usage
//NTLOOK: ignores hasing or equating the blocks and just considers name and url of script
extension NTScript: Hashable, Equatable {
    
    var hashValue: Int {
        return name.hashValue + (url?.hashValue ?? 0)
    }
    
    public static func ==(lhs: NTScript, rhs: NTScript) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
