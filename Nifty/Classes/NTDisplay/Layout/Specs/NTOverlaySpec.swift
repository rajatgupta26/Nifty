//
//  NTOverlaySpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 05/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit




@objc public protocol NTOverlaySpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithChildAndOverlay(_ child: NTLayoutElement, _ overley: NTLayoutElement) -> NTOverlaySpec
    
    var overlay: NTLayoutElement? {get}
    
}


@objc public class NTOverlaySpec: NTSpec {
    
    public var overlay: NTLayoutElement?
    
    convenience init(overley: NTLayoutElement, child: NTLayoutElement) {
        self.init()
        
        self.child = child
        self.children = [child]
        self.overlay = overley
    }
    
    
    override public var specType: NTSpectype {
        get {
            return .overlay
        }
    }
}



extension NTOverlaySpec: NTOverlaySpecProtocol {
    
    public static func createWithChildAndOverlay(_ child: NTLayoutElement, _ overley: NTLayoutElement) -> NTOverlaySpec {
        return NTOverlaySpec(overley: overley, child: child)
    }
}




extension NTOverlaySpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Overlay.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}




