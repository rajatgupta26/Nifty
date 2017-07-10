//
//  NTBackgroundSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 04/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit



@objc public protocol NTBackgroundSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithChildAndBackground(_ child: NTLayoutElement, _ background: NTLayoutElement) -> NTBackgroundSpec
    
    var background: NTLayoutElement? {get}
    
}


@objc public class NTBackgroundSpec: NTSpec {
    
    public var background: NTLayoutElement?
    
    convenience init(background: NTLayoutElement, child: NTLayoutElement) {
        self.init()
        
        self.child = child
        self.children = [child]
        self.background = background
    }
    
    
    override public var specType: NTSpectype {
        get {
            return .background
        }
    }
}



extension NTBackgroundSpec: NTBackgroundSpecProtocol {
    
    public static func createWithChildAndBackground(_ child: NTLayoutElement, _ background: NTLayoutElement) -> NTBackgroundSpec {
        return NTBackgroundSpec(background: background, child: child)
    }
}




extension NTBackgroundSpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Background.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}




