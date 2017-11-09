//
//  NTCenterSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 04/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit


//NTLOOK: Find a better way to map these enums to AsyncDisplayKit's. Goes for all of the enums.
public typealias NTCenterSpecCenteringOption = ASCenterLayoutSpecCenteringOptions.RawValue
public let NTCenterSpecCenteringOptionX: NTCenterSpecCenteringOption = ASCenterLayoutSpecCenteringOptions.X.rawValue
public let NTCenterSpecCenteringOptionY: NTCenterSpecCenteringOption = ASCenterLayoutSpecCenteringOptions.Y.rawValue
public let NTCenterSpecCenteringOptionXY: NTCenterSpecCenteringOption = ASCenterLayoutSpecCenteringOptions.XY.rawValue
public let NTCenterSpecCenteringOptionNone: NTCenterSpecCenteringOption = 0

public typealias NTCenterSpecSizingOption = ASCenterLayoutSpecSizingOptions.RawValue
public let NTCenterSpecSizingOptionMinX: NTCenterSpecCenteringOption = ASCenterLayoutSpecSizingOptions.minimumX.rawValue
public let NTCenterSpecSizingOptionMinY: NTCenterSpecCenteringOption = ASCenterLayoutSpecSizingOptions.minimumY.rawValue
public let NTCenterSpecSizingOptionMinXY: NTCenterSpecCenteringOption = ASCenterLayoutSpecSizingOptions.minimumXY.rawValue
public let NTCenterSpecSizingOptionDefault: NTCenterSpecCenteringOption = 0





@objc public protocol NTCenterSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithCenteringSizingAndChild(_ centering: NTCenterSpecCenteringOption, _ sizing: NTCenterSpecSizingOption, _ child: NTLayoutElement) -> NTCenterSpec
    
    var centeringOption: NTCenterSpecCenteringOption {get}
    var sizingOption: NTCenterSpecSizingOption {get}
}


@objc public class NTCenterSpec: NTSpec {

    private var _centeringOption: NTCenterSpecCenteringOption = NTCenterSpecCenteringOptionNone
    public var centeringOption: NTCenterSpecCenteringOption {
        get {
            return _centeringOption
        }
    }
    
    private var _sizingOption: NTCenterSpecSizingOption = NTCenterSpecSizingOptionDefault
    public var sizingOption: NTCenterSpecSizingOption {
        get {
            return _sizingOption
        }
    }
    
    override public var specType: NTSpectype {
        get {
            return .center
        }
    }
    
    
    convenience init(centering: NTCenterSpecCenteringOption, sizing: NTCenterSpecSizingOption, child: NTLayoutElement) {
        self.init()
        
        _centeringOption = centering
        _sizingOption = sizing
        self.child = child
        self.children = [child]
    }
}




extension NTCenterSpec: NTCenterSpecProtocol {
    
    public static func createWithCenteringSizingAndChild(_ centering: NTCenterSpecCenteringOption, _ sizing: NTCenterSpecSizingOption, _ child: NTLayoutElement) -> NTCenterSpec {
        return NTCenterSpec(centering: centering, sizing: sizing, child: child)
    }
}







extension NTCenterSpec {
    
    public override static func moduleName() -> String {
        return NTSpecConsts.Center.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        let constantsMap: [String: Any] = [NTSpecConsts.Center.centeringOption: [NTSpecConsts.Center.CenteringOption.none.rawValue: NTCenterSpecCenteringOptionNone,
                                                                                 NTSpecConsts.Center.CenteringOption.x.rawValue: NTCenterSpecCenteringOptionX,
                                                                                 NTSpecConsts.Center.CenteringOption.y.rawValue: NTCenterSpecCenteringOptionY,
                                                                                 NTSpecConsts.Center.CenteringOption.xy.rawValue: NTCenterSpecCenteringOptionXY],
                                           
                                           NTSpecConsts.Center.sizingOption: [NTSpecConsts.Center.SizingOption.default.rawValue: NTCenterSpecSizingOptionDefault,
                                                                              NTSpecConsts.Center.SizingOption.minX.rawValue: NTCenterSpecSizingOptionMinX,
                                                                              NTSpecConsts.Center.SizingOption.minY.rawValue: NTCenterSpecSizingOptionMinY,
                                                                              NTSpecConsts.Center.SizingOption.minXY.rawValue: NTCenterSpecSizingOptionMinXY]]
        return constantsMap
    }
}







