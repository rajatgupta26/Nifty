//
//  NTRelativeSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 05/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit


//NTLOOK: Find a better way to map these enums to AsyncDisplayKit's. Goes for all of the enums.
//NTLOOK: typealias is the irght approach I think. Evaluate this approach further. Trying to use typealias NTControlNode onwards.
@objc public enum NTRelativeSpecPosition: UInt {
    case none   = 0
    case start  = 1
    case center = 2
    case end    = 3
}

@objc public enum NTRelativeSpecSizingOption: UInt {
    case `default`  = 0
    case minWidth   = 1
    case minHeight  = 2
    case minSize    = 3
}



@objc public protocol NTRelativeSpecProtocol: JSExport, NTSpecProtocol {
    static func createWithHorizontalVerticalPositionSizingAndChild(_ horizontalPosition: NTRelativeSpecPosition,
                                                                   _ verticalPosition: NTRelativeSpecPosition,
                                                                   _ sizing: NTRelativeSpecSizingOption,
                                                                   _ child: NTLayoutElement) -> NTRelativeSpec
    
    var horizontalPosition: NTRelativeSpecPosition {get}
    var verticalPosition: NTRelativeSpecPosition {get}
    var sizing: NTRelativeSpecSizingOption {get}
}



@objc public class NTRelativeSpec: NTSpec {
    
    private var _horizontalPosition: NTRelativeSpecPosition = .none
    public var horizontalPosition: NTRelativeSpecPosition {
        get {
            return _horizontalPosition
        }
    }
    
    private var _verticalPosition: NTRelativeSpecPosition = .none
    public var verticalPosition: NTRelativeSpecPosition {
        get {
            return _verticalPosition
        }
    }
    
    private var _sizing: NTRelativeSpecSizingOption = .default
    public var sizing: NTRelativeSpecSizingOption {
        get {
            return _sizing
        }
    }
    
    
    convenience init(horizontalPosition: NTRelativeSpecPosition,
                     verticalPosition: NTRelativeSpecPosition,
                     sizing: NTRelativeSpecSizingOption,
                     child: NTLayoutElement) {
        self.init()
        
        _horizontalPosition = horizontalPosition
        _verticalPosition = verticalPosition
        _sizing = sizing
        
        self.child = child
        self.children = [child]
    }
    
    
    override public var specType: NTSpectype {
        return .relative
    }
}




extension NTRelativeSpec: NTRelativeSpecProtocol {
    public static func createWithHorizontalVerticalPositionSizingAndChild(_ horizontalPosition: NTRelativeSpecPosition,
                                                                          _ verticalPosition: NTRelativeSpecPosition,
                                                                          _ sizing: NTRelativeSpecSizingOption,
                                                                          _ child: NTLayoutElement) -> NTRelativeSpec {
        
        return NTRelativeSpec(horizontalPosition: horizontalPosition,
                              verticalPosition: verticalPosition,
                              sizing: sizing,
                              child: child)
    }
}




extension NTRelativeSpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Relative.name
    }
    
    public override static func constantsToExport() -> [String: Any]? {
        let constantsToExport: [String: Any] = [NTSpecConsts.Relative.position: [NTSpecConsts.Relative.Position.none.rawValue: NTRelativeSpecPosition.none.rawValue,
                                                                                 NTSpecConsts.Relative.Position.start.rawValue: NTRelativeSpecPosition.start.rawValue,
                                                                                 NTSpecConsts.Relative.Position.center.rawValue: NTRelativeSpecPosition.center.rawValue,
                                                                                 NTSpecConsts.Relative.Position.end.rawValue: NTRelativeSpecPosition.end.rawValue],
                                                
                                                NTSpecConsts.Relative.sizingOption: [NTSpecConsts.Relative.SizingOption.default.rawValue: NTRelativeSpecSizingOption.default.rawValue,
                                                                                     NTSpecConsts.Relative.SizingOption.minHeight.rawValue: NTRelativeSpecSizingOption.minHeight.rawValue,
                                                                                     NTSpecConsts.Relative.SizingOption.minWidth.rawValue: NTRelativeSpecSizingOption.minWidth.rawValue,
                                                                                     NTSpecConsts.Relative.SizingOption.minSize.rawValue: NTRelativeSpecSizingOption.minSize.rawValue]]
        return constantsToExport
    }
}

















