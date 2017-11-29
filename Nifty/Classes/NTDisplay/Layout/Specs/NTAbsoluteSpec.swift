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

public typealias NTAbsoluteSpecSizing = ASAbsoluteLayoutSpecSizing.RawValue
public let NTAbsoluteSpecSizingDefault = ASAbsoluteLayoutSpecSizing.default.rawValue
public let NTAbsoluteSpecSizingSizeToFit = ASAbsoluteLayoutSpecSizing.sizeToFit.rawValue



@objc public protocol NTAbsoluteSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithChildren(_ children: [NTLayoutElement]) -> NTAbsoluteSpec
    static func createWithSizingAndChildren(_ sizing: NTAbsoluteSpecSizing,_ children: [NTLayoutElement]) -> NTAbsoluteSpec
    
    var sizing: NTAbsoluteSpecSizing {get}
}





@objc public class NTAbsoluteSpec: NTSpec {
    
    private var _sizing: NTAbsoluteSpecSizing = NTAbsoluteSpecSizingDefault
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
        self.init(sizing: NTAbsoluteSpecSizingDefault, children: children)
    }
    
    convenience init(sizing: NTAbsoluteSpecSizing, children: [NTLayoutElement]) {
        self.init()
        
        _sizing = sizing
        self.children = children
    }
    

    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTSpecConsts.Absolute.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        let constantsMap: [String: Any] = [NTSpecConsts.Absolute.sizing: [NTSpecConsts.Absolute.Sizing.default.rawValue: NTAbsoluteSpecSizingDefault,
                                                                          NTSpecConsts.Absolute.Sizing.sizeToFit.rawValue: NTAbsoluteSpecSizingSizeToFit]]
        return constantsMap
    }
}



extension NTAbsoluteSpec: NTAbsoluteSpecProtocol {
    
    public static func createWithChildren(_ children: [NTLayoutElement]) -> NTAbsoluteSpec {
        return NTAbsoluteSpec(sizing: NTAbsoluteSpecSizingDefault, children: children)
    }
    
    public static func createWithSizingAndChildren(_ sizing: NTAbsoluteSpecSizing,_ children: [NTLayoutElement]) -> NTAbsoluteSpec {
        return NTAbsoluteSpec(sizing: sizing, children: children)
    }
}








