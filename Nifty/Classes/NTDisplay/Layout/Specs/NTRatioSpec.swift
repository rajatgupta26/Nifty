//
//  NTRatioSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 05/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit




@objc public protocol NTRatioSpecProtocol: JSExport, NTSpecProtocol {
    
    static func createWithRatioAndChild(_ ratio: CGFloat,_ child: NTLayoutElement) -> NTRatioSpec?
    
    var ratio: CGFloat {get}
    
}


@objc public class NTRatioSpec: NTSpec {
    
    private var _ratio: CGFloat = 1
    public var ratio: CGFloat {
        return _ratio
    }
    
    convenience init?(ratio: CGFloat, child: NTLayoutElement) {
        
        //NTLOOK: Ratio should be greater than zero. Refer documentation in ASRatioLayoutSpec.
        guard ratio > 0 else {
            return nil
        }
        
        self.init()
        
        self.child = child
        self.children = [child]
        _ratio = ratio
    }
    
    
    override public var specType: NTSpectype {
        get {
            return .ratio
        }
    }
    
    

    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTSpecConsts.Ratio.name
    }
    public override static func constantsToExport() -> [String: Any]? {
        return nil
    }
}



extension NTRatioSpec: NTRatioSpecProtocol {
    
    public static func createWithRatioAndChild(_ ratio: CGFloat,_ child: NTLayoutElement) -> NTRatioSpec? {
        return NTRatioSpec(ratio: ratio, child: child)
    }
}









