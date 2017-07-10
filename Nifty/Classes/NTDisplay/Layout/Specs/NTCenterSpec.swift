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
@objc public enum NTCenterSpecCenteringOption: UInt {
    case none = 0
    case x = 1
    case y = 2
    case xy = 3
}

@objc public enum NTCenterSpecSizingOption: UInt {
    case `default` = 0
    case minX = 1
    case minY = 2
    case minXY = 3
}



@objc public protocol NTCenterSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithCenteringSizingAndChild(_ centering: NTCenterSpecCenteringOption, _ sizing: NTCenterSpecSizingOption, _ child: NTLayoutElement) -> NTCenterSpec
    
    var centeringOption: NTCenterSpecCenteringOption {get}
    var sizingOption: NTCenterSpecSizingOption {get}
}


@objc public class NTCenterSpec: NTSpec {

    private var _centeringOption: NTCenterSpecCenteringOption = .none
    public var centeringOption: NTCenterSpecCenteringOption {
        get {
            return _centeringOption
        }
    }
    
    private var _sizingOption: NTCenterSpecSizingOption = .default
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
        let constantsMap: [String: Any] = [NTSpecConsts.Center.centeringOption: [NTSpecConsts.Center.CenteringOption.none.rawValue: NTCenterSpecCenteringOption.none,
                                                                                 NTSpecConsts.Center.CenteringOption.x.rawValue: NTCenterSpecCenteringOption.x,
                                                                                 NTSpecConsts.Center.CenteringOption.y.rawValue: NTCenterSpecCenteringOption.y,
                                                                                 NTSpecConsts.Center.CenteringOption.xy.rawValue: NTCenterSpecCenteringOption.xy],
                                           
                                           NTSpecConsts.Center.sizingOption: [NTSpecConsts.Center.SizingOption.default.rawValue: NTCenterSpecSizingOption.default,
                                                                              NTSpecConsts.Center.SizingOption.minX.rawValue: NTCenterSpecSizingOption.minX,
                                                                              NTSpecConsts.Center.SizingOption.minY.rawValue: NTCenterSpecSizingOption.minY,
                                                                              NTSpecConsts.Center.SizingOption.minXY.rawValue: NTCenterSpecSizingOption.minXY]]
        return constantsMap
    }
}







