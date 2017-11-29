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
//NTLOOK: typealias is the right approach I think. Evaluate this approach further. Trying to use typealias NTControlNode onwards.
public typealias NTRelativeSpecPosition = ASRelativeLayoutSpecPosition.RawValue
public let NTRelativeSpecPositionNone = ASRelativeLayoutSpecPosition.none.rawValue
public let NTRelativeSpecPositionStart = ASRelativeLayoutSpecPosition.start.rawValue
public let NTRelativeSpecPositionCenter = ASRelativeLayoutSpecPosition.center.rawValue
public let NTRelativeSpecPositionEnd = ASRelativeLayoutSpecPosition.end.rawValue

public typealias NTRelativeSpecSizingOption = ASRelativeLayoutSpecSizingOption.RawValue
public let NTRelativeSpecSizingOptionDefault: NTRelativeSpecSizingOption = 0
public let NTRelativeSpecSizingOptionMinWidth: NTRelativeSpecSizingOption = ASRelativeLayoutSpecSizingOption.minimumWidth.rawValue
public let NTRelativeSpecSizingOptionMinHeight: NTRelativeSpecSizingOption = ASRelativeLayoutSpecSizingOption.minimumHeight.rawValue
public let NTRelativeSpecSizingOptionMinSize: NTRelativeSpecSizingOption = ASRelativeLayoutSpecSizingOption.minimumSize.rawValue




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
    
    private var _horizontalPosition: NTRelativeSpecPosition = NTRelativeSpecPositionNone
    public var horizontalPosition: NTRelativeSpecPosition {
        get {
            return _horizontalPosition
        }
    }
    
    private var _verticalPosition: NTRelativeSpecPosition = NTRelativeSpecPositionNone
    public var verticalPosition: NTRelativeSpecPosition {
        get {
            return _verticalPosition
        }
    }
    
    private var _sizing: NTRelativeSpecSizingOption = NTRelativeSpecSizingOptionDefault
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

    
    
    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTSpecConsts.Relative.name
    }
    
    public override static func constantsToExport() -> [String: Any]? {
        let constantsToExport: [String: Any] = [NTSpecConsts.Relative.position: [NTSpecConsts.Relative.Position.none.rawValue: NTRelativeSpecPositionNone,
                                                                                 NTSpecConsts.Relative.Position.start.rawValue: NTRelativeSpecPositionStart,
                                                                                 NTSpecConsts.Relative.Position.center.rawValue: NTRelativeSpecPositionCenter,
                                                                                 NTSpecConsts.Relative.Position.end.rawValue: NTRelativeSpecPositionEnd],
                                                
                                                NTSpecConsts.Relative.sizingOption: [NTSpecConsts.Relative.SizingOption.default.rawValue: NTRelativeSpecSizingOptionDefault,
                                                                                     NTSpecConsts.Relative.SizingOption.minHeight.rawValue: NTRelativeSpecSizingOptionMinHeight,
                                                                                     NTSpecConsts.Relative.SizingOption.minWidth.rawValue: NTRelativeSpecSizingOptionMinWidth,
                                                                                     NTSpecConsts.Relative.SizingOption.minSize.rawValue: NTRelativeSpecSizingOptionMinSize]]
        return constantsToExport
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






















