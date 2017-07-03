//
//  NTSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

import UIKit
import JavaScriptCore
import AsyncDisplayKit


public enum NTSpectype {
    case absolute
    case insets
}


@objc public protocol NTSpecProtocol: JSExport {
    
}




@objc public class NTSpec: NSObject, NTSpecProtocol, NTLayoutElement {

    
    internal var _asSpec: ASLayoutSpec?
    public var asSpec: ASLayoutSpec? {
        get {
            // NTLOOK: recalculating every time
            if let spec = asLayoutElement(from: self) as? ASLayoutSpec? {
                _asSpec = spec
            }
            return _asSpec
        }
    }
    
    
    public var isMutable: Bool {
        get {
            return _asSpec?.isMutable ?? false
        }
        set {
            _asSpec?.isMutable = self.isMutable
        }
    }
    
    
    public var child: NTLayoutElement?
    public var children: [NTLayoutElement]?
    
    
    //MARK: NTLayoutElement
    public var layoutElementType: NTLayoutElementType {
        get {
            return .spec
        }
    }
    
    
    public var sublayoutElements: [NTLayoutElement]? {
        get {
            return nil
        }
    }
    
    
    public var asLayoutElement: ASLayoutElement? {
        get {
            return self.asSpec
        }
    }
    
    public var specType: NTSpectype {
        get {
            return .absolute
        }
    }

    
    private func asLayoutElement(from ntLayoutElement: NTLayoutElement) -> ASLayoutElement? {
        
        if let ntSpec = ntLayoutElement as? NTSpec {
            
            switch ntSpec.specType {
            case .insets:
                if let ntInsetSpec = ntSpec as? NTInsetSpec, let ntChild = ntSpec.child, let insets = ntInsetSpec.insets {
                    if let _child = asLayoutElement(from: ntChild) {
                        return ASInsetLayoutSpec(insets: insets, child: _child)
                    }
                }
                break
            default:
                break
            }
        } else {
            return ntLayoutElement.asLayoutElement
        }
        
        return nil
    }

}




extension NTSpec: NTModule {
    
    public class func moduleName() -> String {
        return "Spec"
    }
    public class func constantsToExport() -> [String: Any]? {
        return nil
    }
}




