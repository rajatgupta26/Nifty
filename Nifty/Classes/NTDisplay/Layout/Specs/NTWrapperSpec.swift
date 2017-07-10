//
//  NTWrapperSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 05/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit


@objc public protocol NTWrapperSpecProtocol: JSExport, NTSpecProtocol {
    
    func createWithChild(_ child: NTLayoutElement) -> NTWrapperSpec
    func createWithChildren(_ children: [NTLayoutElement]) -> NTWrapperSpec
}


@objc public class NTWrapperSpec: NTSpec {
    
    convenience init(child: NTLayoutElement) {
        self.init()
        
        self.child = child
        self.children = [child]
    }
    
    
    convenience init(children: [NTLayoutElement]) {
        self.init()
        
        self.children = children
    }
    
    
    override public var specType: NTSpectype {
        return .wrapper
    }
}




extension NTWrapperSpec: NTWrapperSpecProtocol {
    
    public func createWithChild(_ child: NTLayoutElement) -> NTWrapperSpec {
        return NTWrapperSpec(child: child)
    }
    
    public func createWithChildren(_ children: [NTLayoutElement]) -> NTWrapperSpec {
        return NTWrapperSpec(children: children)
    }
}






extension NTWrapperSpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Wrapper.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}








