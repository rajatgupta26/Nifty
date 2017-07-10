//
//  NTStackSpec.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 07/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit

//MARK: Defines
@objc public enum NTStackDirection: UInt {
    case vertical   = 0
    case horizontal = 1
}


@objc public enum NTStackJustifyContent: UInt {
    case start          = 0
    case center         = 1
    case end            = 2
    case spaceBetween   = 3
    case spaceAround    = 4
}


@objc public enum NTStackAlignItems: UInt {
    case start          = 0
    case end            = 1
    case center         = 2
    case stretch        = 3
    case baselineFirst  = 4
    case baselineLast   = 5
    case notSet         = 6
}


@objc public enum NTStackAlignSelf: UInt {
    case auto           = 0
    case start          = 1
    case end            = 2
    case center         = 3
    case stretch        = 4
}


@objc public enum NTStackFlexWrap: UInt {
    case noWrap = 0
    case wrap   = 1
}


@objc public enum NTStackAlignContent: UInt {
    case start          = 0
    case center         = 1
    case end            = 2
    case spaceBetween   = 3
    case spaceAround    = 4
    case stretch        = 5
}


@objc public enum NTHorizontalAlignment: UInt {
    case none   = 0
    case left   = 1
    case middle = 2
    case right  = 3
}


@objc public enum NTVerticalAlignment: UInt {
    case none   = 0
    case top    = 1
    case center = 2
    case bottom = 3
}


fileprivate let defaultDirection: NTStackDirection = .vertical
fileprivate let defaultJustification: NTStackJustifyContent = .start
fileprivate let defaultAlignItems: NTStackAlignItems = .start
fileprivate let defaultFlexWrap: NTStackFlexWrap = .noWrap
fileprivate let defaultAlignContent: NTStackAlignContent = .start
fileprivate let defaultSpacing: CGFloat = 0.0
fileprivate let defaultHAlignment: NTHorizontalAlignment = .none
fileprivate let defaultVAlignment: NTVerticalAlignment = .none



//MARK: NTStackSpec

@objc protocol NTStackSpecProtocol: JSExport, NTSpecProtocol {
    
    var direction: NTStackDirection {get set}
    var spacing: CGFloat {get set}
    var horizontalAlignment: NTHorizontalAlignment {get set}
    var verticalAlignment: NTVerticalAlignment {get set}
    var justifyContent: NTStackJustifyContent {get set}
    var alignItems: NTStackAlignItems {get set}
    var flexWrap: NTStackFlexWrap {get set}
    var alignContent: NTStackAlignContent {get set}
    var isConcurrent: Bool {get set}
    
    static func createWithOptionsAndChildren(_ options: [String: Any], _ children: [NTLayoutElement]) -> NTSpec
}




@objc public class NTStackSpec: NTSpec {
    
    public var direction: NTStackDirection = defaultDirection
    public var spacing: CGFloat = defaultSpacing
    public var horizontalAlignment: NTHorizontalAlignment = defaultHAlignment
    public var verticalAlignment: NTVerticalAlignment = defaultVAlignment
    public var justifyContent: NTStackJustifyContent = defaultJustification
    public var alignItems: NTStackAlignItems = defaultAlignItems
    public var flexWrap: NTStackFlexWrap = defaultFlexWrap
    public var alignContent: NTStackAlignContent = defaultAlignContent
    public var isConcurrent: Bool = false
    
    convenience init(direction: NTStackDirection = defaultDirection,
                     spacing: CGFloat = defaultSpacing,
                     justifyContent: NTStackJustifyContent = defaultJustification,
                     alignItems: NTStackAlignItems = defaultAlignItems,
                     flexWrap: NTStackFlexWrap = defaultFlexWrap,
                     alignContent: NTStackAlignContent = defaultAlignContent,
                     children: [NTLayoutElement]) {
        self.init()
        
        self.direction = direction
        self.spacing = spacing
        self.justifyContent = justifyContent
        self.alignContent = alignContent
        self.alignItems = alignItems
        self.flexWrap = flexWrap
        self.children = children
    }
    
    public override var specType: NTSpectype {
        get {
            return .stack
        }
    }
}




extension NTStackSpec: NTStackSpecProtocol {
    public static func createWithOptionsAndChildren(_ options: [String: Any], _ children: [NTLayoutElement]) -> NTSpec {
        
        let direction = NTStackDirection(rawValue: options[NTSpecConsts.Stack.direction] as? UInt ?? defaultDirection.rawValue) ?? defaultDirection
        let spacing: CGFloat = (options[NTSpecConsts.Stack.spacing] as? CGFloat) ?? defaultSpacing
        let justifyContent = NTStackJustifyContent(rawValue:options[NTSpecConsts.Stack.justifyContent]  as? UInt ?? defaultJustification.rawValue) ?? defaultJustification
        let alignItems = NTStackAlignItems(rawValue: options[NTSpecConsts.Stack.alignItems] as? UInt ?? defaultAlignItems.rawValue) ?? defaultAlignItems
        let flexWrap = NTStackFlexWrap(rawValue: options[NTSpecConsts.Stack.flexWrap] as? UInt ?? defaultFlexWrap.rawValue) ?? defaultFlexWrap
        let alignContent = NTStackAlignContent(rawValue: options[NTSpecConsts.Stack.alignContent] as? UInt ?? defaultAlignContent.rawValue) ?? defaultAlignContent
        
        return NTStackSpec(direction: direction,
                           spacing: spacing,
                           justifyContent: justifyContent,
                           alignItems: alignItems,
                           flexWrap: flexWrap,
                           alignContent: alignContent,
                           children: children)
    }
}





extension NTStackSpec {
    
    override public static func moduleName() -> String {
        return NTSpecConsts.Stack.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        let constants: [String: Any] = [NTSpecConsts.Stack.direction: [NTSpecConsts.Stack.Direction.horizontal.rawValue: NTStackDirection.horizontal.rawValue,
                                                                       NTSpecConsts.Stack.Direction.vertical.rawValue: NTStackDirection.vertical.rawValue],
                                        
                                        NTSpecConsts.Stack.justifyContent: [NTSpecConsts.Stack.JustifyContent.center.rawValue: NTStackJustifyContent.center.rawValue,
                                                                            NTSpecConsts.Stack.JustifyContent.end.rawValue: NTStackJustifyContent.end.rawValue,
                                                                            NTSpecConsts.Stack.JustifyContent.start.rawValue: NTStackJustifyContent.start.rawValue,
                                                                            NTSpecConsts.Stack.JustifyContent.spaceBetween.rawValue: NTStackJustifyContent.spaceBetween.rawValue,
                                                                            NTSpecConsts.Stack.JustifyContent.spaceAround.rawValue: NTStackJustifyContent.spaceAround.rawValue],
                                        
                                        NTSpecConsts.Stack.alignItems: [NTSpecConsts.Stack.AlignItems.baselineFirst.rawValue: NTStackAlignItems.baselineFirst.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.baselineLast.rawValue: NTStackAlignItems.baselineLast.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.center.rawValue:NTStackAlignItems.center.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.end.rawValue: NTStackAlignItems.end.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.notSet.rawValue: NTStackAlignItems.notSet.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.start.rawValue: NTStackAlignItems.start.rawValue,
                                                                        NTSpecConsts.Stack.AlignItems.stretch.rawValue: NTStackAlignItems.stretch.rawValue],
                                        
                                        NTSpecConsts.Stack.alignSelf: [NTSpecConsts.Stack.AlignSelf.auto.rawValue: NTStackAlignSelf.auto.rawValue,
                                                                       NTSpecConsts.Stack.AlignSelf.center.rawValue: NTStackAlignSelf.center.rawValue,
                                                                       NTSpecConsts.Stack.AlignSelf.end.rawValue: NTStackAlignSelf.end.rawValue,
                                                                       NTSpecConsts.Stack.AlignSelf.start.rawValue: NTStackAlignSelf.start.rawValue,
                                                                       NTSpecConsts.Stack.AlignSelf.stretch.rawValue: NTStackAlignSelf.stretch.rawValue],
                                        
                                        NTSpecConsts.Stack.flexWrap: [NTSpecConsts.Stack.FlexWrap.noWrap.rawValue: NTStackFlexWrap.noWrap.rawValue,
                                                                      NTSpecConsts.Stack.FlexWrap.wrap.rawValue: NTStackFlexWrap.wrap.rawValue],
                                        
                                        NTSpecConsts.Stack.alignContent: [NTSpecConsts.Stack.AlignContent.center.rawValue: NTStackAlignContent.center.rawValue,
                                                                          NTSpecConsts.Stack.AlignContent.end.rawValue: NTStackAlignContent.end.rawValue,
                                                                          NTSpecConsts.Stack.AlignContent.spaceAround.rawValue: NTStackAlignContent.spaceAround.rawValue,
                                                                          NTSpecConsts.Stack.AlignContent.spaceBetween.rawValue: NTStackAlignContent.spaceBetween.rawValue,
                                                                          NTSpecConsts.Stack.AlignContent.start.rawValue: NTStackAlignContent.start.rawValue,
                                                                          NTSpecConsts.Stack.AlignContent.stretch.rawValue: NTStackAlignContent.stretch.rawValue],
                                        
                                        NTSpecConsts.Stack.horizontalAlignment: [NTSpecConsts.Stack.HorizontalAlignment.left.rawValue: NTHorizontalAlignment.left.rawValue,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.middle.rawValue: NTHorizontalAlignment.middle.rawValue,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.none.rawValue: NTHorizontalAlignment.none.rawValue,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.right.rawValue: NTHorizontalAlignment.right.rawValue],
                                        
                                        NTSpecConsts.Stack.verticalAlignment: [NTSpecConsts.Stack.VerticalAlignment.none.rawValue: NTVerticalAlignment.none.rawValue,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.top.rawValue: NTVerticalAlignment.top.rawValue,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.bottom.rawValue: NTVerticalAlignment.bottom.rawValue,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.center.rawValue: NTVerticalAlignment.center.rawValue],
                                        
                                        NTSpecConsts.Stack.options: ["direction": NTSpecConsts.Stack.direction,
                                                                     "justifyContent": NTSpecConsts.Stack.justifyContent,
                                                                     "alignItems": NTSpecConsts.Stack.alignItems,
                                                                     "alignSelf": NTSpecConsts.Stack.alignSelf,
                                                                     "flexWrap": NTSpecConsts.Stack.flexWrap,
                                                                     "alignContent": NTSpecConsts.Stack.alignContent,
                                                                     "spacing": NTSpecConsts.Stack.spacing]
                                        ]
        
        return constants
    }
}





























