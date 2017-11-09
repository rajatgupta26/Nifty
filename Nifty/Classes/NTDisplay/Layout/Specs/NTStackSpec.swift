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
public typealias NTStackDirection = ASStackLayoutDirection.RawValue
public let NTStackDirectionVertical = ASStackLayoutDirection.vertical.rawValue
public let NTStackDirectionHorizontal = ASStackLayoutDirection.horizontal.rawValue


public typealias NTStackJustifyContent = ASStackLayoutJustifyContent.RawValue
public let NTStackJustifyContentStart = ASStackLayoutJustifyContent.start.rawValue
public let NTStackJustifyContentCenter = ASStackLayoutJustifyContent.center.rawValue
public let NTStackJustifyContentEnd = ASStackLayoutJustifyContent.end.rawValue
public let NTStackJustifyContentSpaceBetween = ASStackLayoutJustifyContent.spaceBetween.rawValue
public let NTStackJustifyContentSpaceAround = ASStackLayoutJustifyContent.spaceAround.rawValue


public typealias NTStackAlignItems = ASStackLayoutAlignItems.RawValue
public let NTStackAlignItemsStart = ASStackLayoutAlignItems.start.rawValue
public let NTStackAlignItemsEnd = ASStackLayoutAlignItems.end.rawValue
public let NTStackAlignItemsCenter = ASStackLayoutAlignItems.center.rawValue
public let NTStackAlignItemsStretch = ASStackLayoutAlignItems.stretch.rawValue
public let NTStackAlignItemsBaselineFirst = ASStackLayoutAlignItems.baselineFirst.rawValue
public let NTStackAlignItemsBaselineLast = ASStackLayoutAlignItems.baselineLast.rawValue
public let NTStackAlignItemsNotset = ASStackLayoutAlignItems.notSet.rawValue


public typealias NTStackAlignSelf = ASStackLayoutAlignSelf.RawValue
public let NTStackAlignSelfAuto = ASStackLayoutAlignSelf.auto.rawValue
public let NTStackAlignSelfStart = ASStackLayoutAlignSelf.start.rawValue
public let NTStackAlignSelfEnd = ASStackLayoutAlignSelf.end.rawValue
public let NTStackAlignSelfCenter = ASStackLayoutAlignSelf.center.rawValue
public let NTStackAlignSelfStretch = ASStackLayoutAlignSelf.stretch.rawValue


public typealias NTStackFlexWrap = ASStackLayoutFlexWrap.RawValue
public let NTStackFlexWrapNoWrap = ASStackLayoutFlexWrap.noWrap.rawValue
public let NTStackFlexWrapWrap = ASStackLayoutFlexWrap.wrap.rawValue


public typealias NTStackAlignContent = ASStackLayoutAlignContent.RawValue
public let NTStackAlignContentStart = ASStackLayoutAlignContent.start.rawValue
public let NTStackAlignContentCenter = ASStackLayoutAlignContent.center.rawValue
public let NTStackAlignContentEnd = ASStackLayoutAlignContent.end.rawValue
public let NTStackAlignContentSpaceBetween = ASStackLayoutAlignContent.spaceBetween.rawValue
public let NTStackAlignContentSpaceAround = ASStackLayoutAlignContent.spaceAround.rawValue
public let NTStackAlignContentStretch = ASStackLayoutAlignContent.stretch.rawValue


public typealias NTHorizontalAlignment = ASHorizontalAlignment.RawValue
public let NTHorizontalAlignmentNone = ASHorizontalAlignment.none.rawValue
public let NTHorizontalAlignmentLeft = ASHorizontalAlignment.left.rawValue
public let NTHorizontalAlignmentMiddle = ASHorizontalAlignment.middle.rawValue
public let NTHorizontalAlignmentRight = ASHorizontalAlignment.right.rawValue


public typealias NTVerticalAlignment = ASVerticalAlignment.RawValue
public let NTVerticalAlignmentNone = ASVerticalAlignment.none.rawValue
public let NTVerticalAlignmentTop = ASVerticalAlignment.top.rawValue
public let NTVerticalAlignmentCenter = ASVerticalAlignment.center.rawValue
public let NTVerticalAlignmentBottom = ASVerticalAlignment.bottom.rawValue


fileprivate let defaultDirection: NTStackDirection = NTStackDirectionVertical
fileprivate let defaultJustification: NTStackJustifyContent = NTStackJustifyContentStart
fileprivate let defaultAlignItems: NTStackAlignItems = NTStackAlignItemsStart
fileprivate let defaultFlexWrap: NTStackFlexWrap = NTStackFlexWrapNoWrap
fileprivate let defaultAlignContent: NTStackAlignContent = NTStackAlignContentStart
fileprivate let defaultSpacing: CGFloat = 0.0
fileprivate let defaultHAlignment: NTHorizontalAlignment = NTHorizontalAlignmentNone
fileprivate let defaultVAlignment: NTVerticalAlignment = NTVerticalAlignmentNone



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
        
        let direction = options[NTSpecConsts.Stack.direction] as? NTStackDirection ?? defaultDirection
        let spacing: CGFloat = (options[NTSpecConsts.Stack.spacing] as? CGFloat) ?? defaultSpacing
        let justifyContent = options[NTSpecConsts.Stack.justifyContent]  as? NTStackJustifyContent ?? defaultJustification
        let alignItems = options[NTSpecConsts.Stack.alignItems] as? NTStackAlignItems ?? defaultAlignItems
        let flexWrap = options[NTSpecConsts.Stack.flexWrap] as? NTStackFlexWrap ?? defaultFlexWrap
        let alignContent = options[NTSpecConsts.Stack.alignContent] as? NTStackAlignContent ?? defaultAlignContent
        
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
        let constants: [String: Any] = [NTSpecConsts.Stack.direction: [NTSpecConsts.Stack.Direction.horizontal.rawValue: NTStackDirectionHorizontal,
                                                                       NTSpecConsts.Stack.Direction.vertical.rawValue: NTStackDirectionVertical],
                                        
                                        NTSpecConsts.Stack.justifyContent: [NTSpecConsts.Stack.JustifyContent.center.rawValue: NTStackJustifyContentCenter,
                                                                            NTSpecConsts.Stack.JustifyContent.end.rawValue: NTStackJustifyContentEnd,
                                                                            NTSpecConsts.Stack.JustifyContent.start.rawValue: NTStackJustifyContentStart,
                                                                            NTSpecConsts.Stack.JustifyContent.spaceBetween.rawValue: NTStackJustifyContentSpaceBetween,
                                                                            NTSpecConsts.Stack.JustifyContent.spaceAround.rawValue: NTStackJustifyContentSpaceAround],
                                        
                                        NTSpecConsts.Stack.alignItems: [NTSpecConsts.Stack.AlignItems.baselineFirst.rawValue: NTStackAlignItemsBaselineFirst,
                                                                        NTSpecConsts.Stack.AlignItems.baselineLast.rawValue: NTStackAlignItemsBaselineLast,
                                                                        NTSpecConsts.Stack.AlignItems.center.rawValue:NTStackAlignItemsCenter,
                                                                        NTSpecConsts.Stack.AlignItems.end.rawValue: NTStackAlignItemsEnd,
                                                                        NTSpecConsts.Stack.AlignItems.notSet.rawValue: NTStackAlignItemsNotset,
                                                                        NTSpecConsts.Stack.AlignItems.start.rawValue: NTStackAlignItemsStart,
                                                                        NTSpecConsts.Stack.AlignItems.stretch.rawValue: NTStackAlignItemsStretch],
                                        
                                        NTSpecConsts.Stack.alignSelf: [NTSpecConsts.Stack.AlignSelf.auto.rawValue: NTStackAlignSelfAuto,
                                                                       NTSpecConsts.Stack.AlignSelf.center.rawValue: NTStackAlignSelfCenter,
                                                                       NTSpecConsts.Stack.AlignSelf.end.rawValue: NTStackAlignSelfEnd,
                                                                       NTSpecConsts.Stack.AlignSelf.start.rawValue: NTStackAlignSelfStart,
                                                                       NTSpecConsts.Stack.AlignSelf.stretch.rawValue: NTStackAlignSelfStretch],
                                        
                                        NTSpecConsts.Stack.flexWrap: [NTSpecConsts.Stack.FlexWrap.noWrap.rawValue: NTStackFlexWrapNoWrap,
                                                                      NTSpecConsts.Stack.FlexWrap.wrap.rawValue: NTStackFlexWrapWrap],
                                        
                                        NTSpecConsts.Stack.alignContent: [NTSpecConsts.Stack.AlignContent.center.rawValue: NTStackAlignContentCenter,
                                                                          NTSpecConsts.Stack.AlignContent.end.rawValue: NTStackAlignContentEnd,
                                                                          NTSpecConsts.Stack.AlignContent.spaceAround.rawValue: NTStackAlignContentSpaceAround,
                                                                          NTSpecConsts.Stack.AlignContent.spaceBetween.rawValue: NTStackAlignContentSpaceBetween,
                                                                          NTSpecConsts.Stack.AlignContent.start.rawValue: NTStackAlignContentStart,
                                                                          NTSpecConsts.Stack.AlignContent.stretch.rawValue: NTStackAlignContentStretch],
                                        
                                        NTSpecConsts.Stack.horizontalAlignment: [NTSpecConsts.Stack.HorizontalAlignment.left.rawValue: NTHorizontalAlignmentLeft,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.middle.rawValue: NTHorizontalAlignmentMiddle,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.none.rawValue: NTHorizontalAlignmentNone,
                                                                                 NTSpecConsts.Stack.HorizontalAlignment.right.rawValue: NTHorizontalAlignmentRight],
                                        
                                        NTSpecConsts.Stack.verticalAlignment: [NTSpecConsts.Stack.VerticalAlignment.none.rawValue: NTVerticalAlignmentNone,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.top.rawValue: NTVerticalAlignmentTop,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.bottom.rawValue: NTVerticalAlignmentBottom,
                                                                                 NTSpecConsts.Stack.VerticalAlignment.center.rawValue: NTVerticalAlignmentCenter],
                                        
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





























