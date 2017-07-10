//
//  NTAbsoluteSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 04/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit

@objc public enum NTAbsoluteSpecSizing: Int {
    case `default` = 0
    case sizeToFit = 1
}

@objc public protocol NTAbsoluteSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithChildren(_ children: [NTLayoutElement]) -> NTAbsoluteSpec
    static func createWithSizingAndChildren(_ sizing: NTAbsoluteSpecSizing,_ children: [NTLayoutElement]) -> NTAbsoluteSpec
    
    var sizing: NTAbsoluteSpecSizing {get}
}





@objc public class NTAbsoluteSpec: NTSpec {
    
    private var _sizing: NTAbsoluteSpecSizing = .default
    public var sizing: NTAbsoluteSpecSizing {
        get {
            return _sizing
        }
    }
    
    override public var specType: NTSpectype {
        get {
            return .absolute
        }
    }
    
    //MARK: Convenience initializers
    convenience init(children: [NTLayoutElement]) {
        self.init(sizing: .default, children: children)
    }
    
    convenience init(sizing: NTAbsoluteSpecSizing, children: [NTLayoutElement]) {
        self.init()
        
        _sizing = sizing
        self.children = children
    }
    

}



extension NTAbsoluteSpec: NTAbsoluteSpecProtocol {
    
    public static func createWithChildren(_ children: [NTLayoutElement]) -> NTAbsoluteSpec {
        return NTAbsoluteSpec(sizing: .default, children: children)
    }
    
    public static func createWithSizingAndChildren(_ sizing: NTAbsoluteSpecSizing,_ children: [NTLayoutElement]) -> NTAbsoluteSpec {
        return NTAbsoluteSpec(sizing: sizing, children: children)
    }
}




extension NTAbsoluteSpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Absolute.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        let constantsMap: [String: Any] = [NTSpecConsts.Absolute.sizing: [NTSpecConsts.Absolute.Sizing.default.rawValue: NTAbsoluteSpecSizing.default.rawValue,
                                                                          NTSpecConsts.Absolute.Sizing.sizeToFit.rawValue: NTAbsoluteSpecSizing.sizeToFit.rawValue]]
        return constantsMap
    }
}




