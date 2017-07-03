//
//  NTInsetSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 03/07/17.
//
//

import UIKit
import JavaScriptCore
import AsyncDisplayKit

@objc public protocol NTInsetSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithInsetsAndChild(_ insets: [String: Double], _ child: NTLayoutElement) -> NTInsetSpec
    
}




@objc public class NTInsetSpec: NTSpec, NTInsetSpecProtocol {
    
    public var insets: UIEdgeInsets?
    
    public static func createWithInsetsAndChild(_ insets: [String : Double], _ child: NTLayoutElement) -> NTInsetSpec {
        let edgeInsets = NTConverter.mapToEdgeInsets(insets)
        return NTInsetSpec(insets: edgeInsets ?? UIEdgeInsets.zero, child: child)
    }
    
    
    convenience init(insets: UIEdgeInsets, child: NTLayoutElement) {
        self.init()
        
        self.insets = insets
        self.child = child
        self.children = [child]
    }
    
    
    //MARK: NTLayoutElement
    override public var layoutElementType: NTLayoutElementType {
        get {
            return .spec
        }
    }
    
    
    override public var sublayoutElements: [NTLayoutElement]? {
        get {
            return self.children
        }
    }
    
    override public var specType: NTSpectype {
        get {
            return .insets
        }
    }
}



extension NTInsetSpec {
    
    public override static func moduleName() -> String {
        return "InsetSpec"
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}


