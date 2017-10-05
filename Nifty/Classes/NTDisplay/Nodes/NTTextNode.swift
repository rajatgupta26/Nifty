//
//  NTTextNode.swift
//  Pods
//
//  Created by Keerthana Reddy Ragi on 03/10/17.
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit
/*
 @property (nullable, nonatomic, strong) NSArray<UIBezierPath *> *exclusionPaths;
 @abstract Inset each line of the placeholder.
 @property (nonatomic, readonly, assign) UIEdgeInsets shadowPadding;
 - (NSArray<NSValue *> *)rectsForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
 - (NSArray<NSValue *> *)highlightRectsForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
- (CGRect)frameForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
- (CGRect)trailingRect AS_WARN_UNUSED_RESULT;
@property (nonatomic, copy) NSArray<NSString *> *linkAttributeNames;
- (nullable id)linkAttributeValueAtPoint:(CGPoint)point attributeName:(out NSString * _Nullable * _Nullable)attributeNameOut range:(out NSRange * _Nullable)rangeOut AS_WARN_UNUSED_RESULT;
@property (nonatomic, assign) ASTextNodeHighlightStyle highlightStyle;
@property (nonatomic, assign) NSRange highlightRange;
- (void)setHighlightRange:(NSRange)highlightRange animated:(BOOL)animated;
@property (nonatomic, weak) id<ASTextNodeDelegate> delegate;
@property (nonatomic, assign) BOOL longPressCancelsTouches;
@property (nonatomic, assign) BOOL passthroughNonlinkTouches;
@interface ASTextNode : ASTextNode2
@protocol ASTextNodeDelegate <NSObject>
- (void)textNode:(ASTextNode *)textNode tappedLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point textRange:(NSRange)textRange;
- (void)textNode:(ASTextNode *)textNode longPressedLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point textRange:(NSRange)textRange;
- (void)textNodeTappedTruncationToken:(ASTextNode *)textNode;
- (BOOL)textNode:(ASTextNode *)textNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point;
- (BOOL)textNode:(ASTextNode *)textNode shouldLongPressLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point;
 @interface ASTextNode (Unavailable)
 - (instancetype)initWithLayerBlock:(ASDisplayNodeLayerBlock)viewBlock didLoadBlock:(nullable ASDisplayNodeDidLoadBlock)didLoadBlock __unavailable;
 - (instancetype)initWithViewBlock:(ASDisplayNodeViewBlock)viewBlock didLoadBlock:(nullable ASDisplayNodeDidLoadBlock)didLoadBlock __unavailable;
@interface ASTextNode (Deprecated)
@property (nullable, nonatomic, copy) NSAttributedString *attributedString ASDISPLAYNODE_DEPRECATED_MSG("Use .attributedText instead.");
@property (nullable, nonatomic, copy) NSAttributedString *truncationAttributedString ASDISPLAYNODE_DEPRECATED_MSG("Use .truncationAttributedText instead.");
 */

public typealias NTLineBreakMode = Int
public let kNTLineBreakModeByTruncatingTail = NSLineBreakMode.byTruncatingTail.rawValue
public let kNTLineBreakModeByWordWrapping = NSLineBreakMode.byWordWrapping.rawValue
public let kNTLineBreakModeByCharWrapping = NSLineBreakMode.byCharWrapping.rawValue
public let kNTLineBreakModeByClipping = NSLineBreakMode.byClipping.rawValue
public let kNTLineBreakModeByTruncatingHead = NSLineBreakMode.byTruncatingHead.rawValue
public let kNTLineBreakModeByTruncatingMiddle = NSLineBreakMode.byTruncatingMiddle.rawValue


@objc public protocol NTTextNodeExports: JSExport, NTControlNodeExport {
    
    //NTLOOK: Using string only for now, will solution for NSAttributedString later
    var attributedText: String? {get set}
    var truncationAttributedText: String? {get set}
    var additionalTruncationMessage: String? {get set}
    var truncationMode: NTLineBreakMode {get set}
    var truncated: Bool {get}
    var maximumNumberOfLines: UInt {get set}
    var lineCount: UInt {get} //readonly property
    var textPlaceholderEnabled: Bool {get set}
    var placeholderColor: UIColor? {get set}
    var shadowColor: UIColor? {get set}
    var shadowOpacity: Double {get set}
    var shadowRadius: Double {get set}
    var shadowOffset: CGSize {get set}
    
}

@objc public class NTTextNode: NTControlNode, NTTextNodeExports {
    private var _textNode: ASTextNode? {
        get {
            return self.asNode as? ASTextNode
        }
    }
    
    public override func loadNode() -> ASDisplayNode {
        return ASTextNode()
    }
    
    public var attributedText: String? {
        get {
            return self._textNode?.attributedText?.string
        }
        set {
            self._textNode?.attributedText = NSAttributedString(string: newValue ?? "")
        }
    }
    
    public var truncationAttributedText: String? {
        get {
            return self._textNode?.truncationAttributedText?.string
        }
        set {
            self._textNode?.truncationAttributedText = NSAttributedString(string: newValue ?? "")
        }
    }
    
    public var additionalTruncationMessage: String? {
        get {
            return self._textNode?.additionalTruncationMessage?.string
        }
        set {
            self._textNode?.additionalTruncationMessage = NSAttributedString(string: newValue ?? "")
        }
    }
    
    public var truncationMode: NTLineBreakMode {
        get {
            return self._textNode?.truncationMode.rawValue ?? kNTLineBreakModeByWordWrapping
        }
        set {
            self._textNode?.truncationMode = NSLineBreakMode(rawValue: newValue) ?? .byWordWrapping
        }
    }
    
    public var truncated: Bool = false
    
    public var maximumNumberOfLines: UInt // default==NSUInteger  (undefined for layer-backed nodes)
        {
        get {
            return self._textNode?.maximumNumberOfLines ?? 0
        }
        set {
            self._textNode?.maximumNumberOfLines = newValue
        }
    }
    
    public var lineCount: UInt {
        get {
            return self._textNode?.lineCount ?? 0
        }
    }
    
    public var textPlaceholderEnabled: Bool = false
    public var placeholderColor: UIColor?
    public var shadowColor: UIColor?
    
    public var shadowOpacity: Double // default=0.0
        {
        get {
            return Double(self._textNode?.shadowOpacity ?? 0.0)
        }
        set {
            self._textNode?.shadowOpacity = CGFloat(newValue)
        }
    }
    
    public var shadowRadius: Double // default=0.0
    {
        get {
            return Double(self._textNode?.shadowRadius ?? 0.0)
        }
        set {
            self._textNode?.shadowRadius = CGFloat(newValue)
        }
    }
    
    public var shadowOffset: CGSize = CGSize.zero
}

extension NTTextNode {
    
    public override static func moduleName() -> String {
        return NTNodeConsts.Text.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        return nil
    }
}
