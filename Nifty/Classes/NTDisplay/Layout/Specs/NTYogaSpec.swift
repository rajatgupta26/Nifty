//
//  NTYogaSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 05/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit




@objc public protocol NTYogaSpecProtocol: JSExport, NTSpecProtocol {
    
    func createWithChild(_ child: NTLayoutElement) -> NTYogaSpec
}


@objc public class NTYogaSpec: NTSpec {
    
    convenience init(child: NTLayoutElement) {
        self.init()
        
        self.child = child
        self.children = [child]
    }
    
    
    override public var specType: NTSpectype {
        return .yoga
    }
    
    
    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTSpecConsts.Yoga.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}




extension NTYogaSpec: NTYogaSpecProtocol {
    
    public func createWithChild(_ child: NTLayoutElement) -> NTYogaSpec {
        return NTYogaSpec(child: child)
    }
}











