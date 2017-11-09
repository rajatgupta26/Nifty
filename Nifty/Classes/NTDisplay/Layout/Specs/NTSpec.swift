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
                if let ntAbsSpec = ntSpec as? NTAbsoluteSpec {
                    
                    if let children = ntSpec.children {
                        var asChildren: [ASLayoutElement] = []
                        for child in children {
                            if let asChild = asLayoutElement(from: child) {
                                asChildren.append(asChild)
                            }
                        }
                        
                        if asChildren.count > 0 {
                            return ASAbsoluteLayoutSpec(sizing: ASAbsoluteLayoutSpecSizing(rawValue: ntAbsSpec.sizing) ?? .default, children: asChildren)
                        }
                    } else {
                        return ASAbsoluteLayoutSpec()
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
                        return ASCenterLayoutSpec(centeringOptions: ASCenterLayoutSpecCenteringOptions(rawValue: ntCenterSpec.centeringOption),
                                                  sizingOptions: ASCenterLayoutSpecSizingOptions(rawValue: ntCenterSpec.sizingOption),
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
                        return ASRelativeLayoutSpec(horizontalPosition: ASRelativeLayoutSpecPosition(rawValue: ntRelativeSpec.horizontalPosition) ?? .none,
                                                    verticalPosition: ASRelativeLayoutSpecPosition(rawValue: ntRelativeSpec.verticalPosition) ?? .none,
                                                    sizingOption: ASRelativeLayoutSpecSizingOption(rawValue: ntRelativeSpec.sizing),
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

                            let spec = ASStackLayoutSpec(direction: ASStackLayoutDirection(rawValue: direction) ?? .vertical,
                                                         spacing: spacing,
                                                         justifyContent: ASStackLayoutJustifyContent(rawValue: justifyContent) ?? .start,
                                                         alignItems: ASStackLayoutAlignItems(rawValue: alignItems) ?? .start,
                                                         flexWrap: ASStackLayoutFlexWrap(rawValue: flexWrap) ?? .noWrap,
                                                         alignContent: ASStackLayoutAlignContent(rawValue: alignContent) ?? .start,
                                                         children: asChildren)
                            
                            spec.horizontalAlignment = ASHorizontalAlignment(rawValue: horizontalAlignment) ?? .none
                            spec.verticalAlignment = ASVerticalAlignment(rawValue: verticalAlignment) ?? .none
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


    //MARK: Style attributes
    public var width: CGFloat {
        get {
            return self.asLayoutElement?.style.width.value ?? 0
        }
        set {
            self.asLayoutElement?.style.width = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeWidth: CGFloat {
        get {
            return self.asLayoutElement?.style.width.value ?? 0
        }
        set {
            self.asLayoutElement?.style.width = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var height: CGFloat {
        get {
            return self.asLayoutElement?.style.height.value ?? 0
        }
        set {
            self.asLayoutElement?.style.height = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeHeight: CGFloat {
        get {
            return self.asLayoutElement?.style.height.value ?? 0
        }
        set {
            self.asLayoutElement?.style.height = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var minHeight: CGFloat {
        get {
            return self.asLayoutElement?.style.minHeight.value ?? 0
        }
        set {
            self.asLayoutElement?.style.minHeight = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeMinHeight: CGFloat {
        get {
            return self.asLayoutElement?.style.minHeight.value ?? 0
        }
        set {
            self.asLayoutElement?.style.minHeight = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var maxHeight: CGFloat {
        get {
            return self.asLayoutElement?.style.maxHeight.value ?? UIScreen.main.bounds.height
        }
        set {
            self.asLayoutElement?.style.maxHeight = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeMaxHeight: CGFloat {
        get {
            return self.asLayoutElement?.style.maxHeight.value ?? 1
        }
        set {
            self.asLayoutElement?.style.maxHeight = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var minWidth: CGFloat {
        get {
            return self.asLayoutElement?.style.minWidth.value ?? 0
        }
        set {
            self.asLayoutElement?.style.minWidth = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeMinWidth: CGFloat {
        get {
            return self.asLayoutElement?.style.minWidth.value ?? 0
        }
        set {
            self.asLayoutElement?.style.minWidth = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var maxWidth: CGFloat {
        get {
            return self.asLayoutElement?.style.maxWidth.value ?? UIScreen.main.bounds.width
        }
        set {
            self.asLayoutElement?.style.maxWidth = ASDimension(unit: .points, value: newValue)
        }
    }
    
    public var relativeMaxWidth: CGFloat {
        get {
            return self.asLayoutElement?.style.maxWidth.value ?? 1
        }
        set {
            self.asLayoutElement?.style.maxWidth = ASDimension(unit: .fraction, value: newValue)
        }
    }
    
    public var preferredSize: CGSize {
        get {
            return self.asLayoutElement?.style.preferredSize ?? CGSize.zero
        }
        set {
            self.asLayoutElement?.style.preferredSize = newValue
        }
    }
    
    public var minSize: CGSize {
        get {
            return self.asLayoutElement?.style.minSize ?? CGSize.zero
        }
        set {
            self.asLayoutElement?.style.minSize = newValue
        }
    }
    
    public var maxSize: CGSize {
        get {
            return self.asLayoutElement?.style.maxSize ?? UIScreen.main.bounds.size
        }
        set {
            self.asLayoutElement?.style.maxSize = newValue
        }
    }
    
    public var relativePreferredSize: CGSize {
        get {
            return (self.asLayoutElement != nil) ? CGSize(width: self.asLayoutElement!.style.preferredLayoutSize.width.value, height: self.asLayoutElement!.style.preferredLayoutSize.height.value) : CGSize.zero
        }
        set {
            self.asLayoutElement?.style.preferredLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: newValue.width), height: ASDimension(unit: .fraction, value: newValue.height))
        }
    }
    
    public var relativeMinSize: CGSize {
        get {
            return (self.asLayoutElement != nil) ? CGSize(width: self.asLayoutElement!.style.minLayoutSize.width.value, height: self.asLayoutElement!.style.minLayoutSize.height.value) : CGSize.zero
        }
        set {
            self.asLayoutElement?.style.minLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: newValue.width), height: ASDimension(unit: .fraction, value: newValue.height))
        }
    }
    
    public var relativeMaxSize: CGSize {
        get {
            return (self.asLayoutElement != nil) ? CGSize(width: self.asLayoutElement!.style.maxLayoutSize.width.value, height: self.asLayoutElement!.style.maxLayoutSize.height.value) : CGSize(width: 1, height: 1)
        }
        set {
            self.asLayoutElement?.style.maxLayoutSize = ASLayoutSize(width: ASDimension(unit: .fraction, value: newValue.width), height: ASDimension(unit: .fraction, value: newValue.height))
        }
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




