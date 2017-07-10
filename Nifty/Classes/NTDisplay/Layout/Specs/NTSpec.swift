//
//  NTSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit


@objc public enum NTSpectype: Int {
    case absolute   = 0
    case insets     = 1
    case background = 2
    case center     = 3
    case wrapper    = 4
    case overlay    = 5
    case ratio      = 6
    case relative   = 7
    case yoga       = 8
    case stack      = 9
}


@objc public protocol NTSpecProtocol: JSExport {
    //NTLOOK: Keeping both child and children variable. Just following what AsyncDisplayKit does. Although a single array var should be enough. But may be there is a scenario that we haven't yet comprehended
    var child: NTLayoutElement? {get set}
    var children: [NTLayoutElement]? {get set}
    var specType: NTSpectype {get}
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
            
            case .absolute:
                if let ntAbsSpec = ntSpec as? NTAbsoluteSpec, let children = ntSpec.children {
                    
                    var asChildren: [ASLayoutElement] = []
                    for child in children {
                        if let asChild = asLayoutElement(from: child) {
                            asChildren.append(asChild)
                        }
                    }
                    
                    if asChildren.count > 0 {
                        return ASAbsoluteLayoutSpec(sizing: ASAbsoluteLayoutSpecSizing(rawValue: ntAbsSpec.sizing.rawValue) ?? .default, children: asChildren)
                    }
                }
                
            case .background:
                if let ntBackgroundSpec = ntSpec as? NTBackgroundSpec, let ntChild = ntSpec.child, let ntBackground = ntBackgroundSpec.background {
                    if let _child = asLayoutElement(from: ntChild), let background = asLayoutElement(from: ntBackground) {
                        return ASBackgroundLayoutSpec(child: _child, background: background)
                    }
                }
                break
            
            case .center:
                if let ntCenterSpec = ntSpec as? NTCenterSpec, let ntChild = ntSpec.child {
                    if let _child = asLayoutElement(from: ntChild) {
                        return ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions(rawValue: ntCenterSpec.centeringOption.rawValue),
                                                  sizingOptions: ASCenterLayoutSpecSizingOptions(rawValue: ntCenterSpec.sizingOption.rawValue),
                                                  child: _child)
                    }
                }
                
            case .wrapper:
                if ntSpec is NTWrapperSpec {
                    
                    if let children = ntSpec.children {
                        
                        var asChildren: [ASLayoutElement] = []
                        for child in children {
                            if let asChild = asLayoutElement(from: child) {
                                asChildren.append(asChild)
                            }
                        }
                        
                        if asChildren.count > 0 {
                            return ASWrapperLayoutSpec(layoutElements: asChildren)
                        }
                    }
                    
                    if let ntChild = ntSpec.child, let child = asLayoutElement(from: ntChild) {
                        
                        return ASWrapperLayoutSpec(layoutElement: child)
                    }
                }
                
            case .overlay:
                if let ntOverlaySpec = ntSpec as? NTOverlaySpec, let ntChild = ntSpec.child, let ntOverlay = ntOverlaySpec.overlay {
                    if let _child = asLayoutElement(from: ntChild), let overlay = asLayoutElement(from: ntOverlay) {
                        return ASOverlayLayoutSpec(child: _child, overlay: overlay)
                    }
                }
                break

            case .ratio:
                if let ntRatioSpec = ntSpec as? NTRatioSpec, let ntChild = ntSpec.child {
                    if let _child = asLayoutElement(from: ntChild) {
                        return ASRatioLayoutSpec(ratio: ntRatioSpec.ratio, child: _child)
                    }
                }
                
            case .relative:
                if let ntRelativeSpec = ntSpec as? NTRelativeSpec, let ntChild = ntSpec.child {
                    if let _child = asLayoutElement(from: ntChild) {
                        return ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition(rawValue: ntRelativeSpec.horizontalPosition.rawValue) ?? .none,
                                                    verticalPosition: ASRelativeLayoutSpecPosition(rawValue: ntRelativeSpec.verticalPosition.rawValue) ?? .none,
                                                    sizingOption: ASRelativeLayoutSpecSizingOption(rawValue: ntRelativeSpec.sizing.rawValue),
                                                    child: _child)
                    }
                }
                
            case .stack:
                if let ntStackSpec = ntSpec as? NTStackSpec {
                    
                    if let children = ntSpec.children {
                        
                        var asChildren: [ASLayoutElement] = []
                        for child in children {
                            if let asChild = asLayoutElement(from: child) {
                                asChildren.append(asChild)
                            }
                        }
                        
                        if asChildren.count > 0 {
                            
                            let direction = ntStackSpec.direction
                            let spacing: CGFloat = ntStackSpec.spacing
                            let justifyContent = ntStackSpec.justifyContent
                            let alignItems = ntStackSpec.alignItems
                            let flexWrap = ntStackSpec.flexWrap
                            let alignContent = ntStackSpec.alignContent
                            let horizontalAlignment = ntStackSpec.horizontalAlignment
                            let verticalAlignment = ntStackSpec.verticalAlignment
                            let isConcurrent = ntStackSpec.isConcurrent

                            let spec = ASStackLayoutSpec(direction: ASStackLayoutDirection(rawValue: direction.rawValue) ?? .vertical,
                                                         spacing: spacing,
                                                         justifyContent: ASStackLayoutJustifyContent(rawValue: justifyContent.rawValue) ?? .start,
                                                         alignItems: ASStackLayoutAlignItems(rawValue: alignItems.rawValue) ?? .start,
                                                         flexWrap: ASStackLayoutFlexWrap(rawValue: flexWrap.rawValue) ?? .noWrap,
                                                         alignContent: ASStackLayoutAlignContent(rawValue: alignContent.rawValue) ?? .start,
                                                         children: asChildren)
                            
                            spec.horizontalAlignment = ASHorizontalAlignment(rawValue: horizontalAlignment.rawValue) ?? .none
                            spec.verticalAlignment = ASVerticalAlignment(rawValue: verticalAlignment.rawValue) ?? .none
                            spec.isConcurrent = isConcurrent
                            
                            return spec
                        }
                    }
                }
                
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




