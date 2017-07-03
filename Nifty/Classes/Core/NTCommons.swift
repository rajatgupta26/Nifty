//
//  NTCommons.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 21/06/17.
//
//

import Foundation


//NTLOOK: May be we can define a better debug criteria
var NT_DEBUG: Bool {
    get {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}

var NT_RELEASE: Bool {
    get {
        return !NT_DEBUG
    }
}


#if DEBUG
    //NTLOOK: it might make sense to just call debug code directly in these functions unless definition of NT_DEBUG is more than just the DEBUG env variable
    //NTLOOK: Capturing blocks involves capturing environment and that means heap allocations, which will be slower than may be an inline function.
    //Need to figure out a better way to do this.
    func NT_EXECUTE<T>(debug dCode: () -> T, release rCode: () -> T) -> T {
        if NT_DEBUG {
            return dCode()
        } else {
            return rCode()
        }
    }
    
//    func NT_EXECUTE(debug dCode: () -> Void, release rCode: () -> Void) {
//        if NT_DEBUG {
//            dCode()
//        } else {
//            rCode()
//        }
//    }
    
    func NTD_EXECUTE<T>(_ code: () -> T) -> T? {
        return code()
    }
    
    func NTR_EXECUTE<T>(_ code: () -> T) -> T? {
        return nil
    }
    
#else
    
    func NT_EXECUTE<T>(debug dCode: () -> T, release rCode: () -> T) -> T {
        return rCode()
    }
    
//    func NT_EXECUTE(debug dCode: () -> Void, release rCode: () -> Void) {
//        rCode()
//    }
    
    func NTD_EXECUTE<T>(_ code: () -> T) -> T? {
        return nil
    }
    
    func NTR_EXECUTE<T>(_ code: () -> T) -> T? {
        return code()
    }
    
#endif


//NTLOOK: Find a better alternative to this. Using module also solve this. And how to make this function name a constant?
private struct Scripts {
    static let isKindOf: String = "var is = function(obj){ return typeof(obj) }"
}


//MARK: Constants

public struct NTCommons {
    struct Constants {
        enum Kinds: String {
            case undefined = "undefined"
            case object = "object"
            case boolean = "boolean"
            case number = "number"
            case string = "string"
            case symbol = "symbol"
            case function = "function"
        }
    }
    
    static let scripts: [String] = [Scripts.isKindOf]
}


































