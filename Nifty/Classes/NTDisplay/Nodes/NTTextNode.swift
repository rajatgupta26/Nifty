//
//  NTTextNode.swift
//  Pods
//
//  Created by Keerthana Reddy Ragi on 03/10/17.
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit
import NSAttributedString_DDHTML

/*
 var attributedText: String? {get set}
 var truncationAttributedText: String? {get set}

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

public typealias NTLineBreakMode = NSLineBreakMode.RawValue
public let kNTLineBreakModeByTruncatingTail = NSLineBreakMode.byTruncatingTail.rawValue
public let kNTLineBreakModeByWordWrapping = NSLineBreakMode.byWordWrapping.rawValue
public let kNTLineBreakModeByCharWrapping = NSLineBreakMode.byCharWrapping.rawValue
public let kNTLineBreakModeByClipping = NSLineBreakMode.byClipping.rawValue
public let kNTLineBreakModeByTruncatingHead = NSLineBreakMode.byTruncatingHead.rawValue
public let kNTLineBreakModeByTruncatingMiddle = NSLineBreakMode.byTruncatingMiddle.rawValue


@objc public protocol NTTextNodeExports: JSExport, NTControlNodeExport {
    
    //NTLOOK: Using string only for now, will solution for NSAttributedString later
    var text: String? {get set}
    var truncationText: String? {get set}
    var additionalTruncationMessage: String? {get set}
    var truncationMode: NTLineBreakMode {get set}
    var truncated: Bool {get}
    var maximumNumberOfLines: UInt {get set}
    var lineCount: UInt {get} //readonly property
    var textPlaceholderEnabled: Bool {get set}
    var placeholderColor: UIColor? {get set}
    var placeholderInset: [String: Double] {get set}
    var shadowColor: UIColor? {get set}
    var shadowOpacity: Double {get set}
    var shadowRadius: Double {get set}
    var shadowOffset: CGSize {get set}
    
    func setAttributedTextWithHTML(_ html: String)
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
    
    public func setAttributedTextWithHTML(_ html: String) {
        let attrStr = NSAttributedString(fromHTML: html)
        self._textNode?.attributedText = attrStr
    }
    
    public var text: String? {
        get {
            return self._textNode?.attributedText?.string
        }
        set {
            self._textNode?.attributedText = NSAttributedString(string: newValue ?? "")
        }
    }
    
    public var truncationText: String? {
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
    
    public var truncated: Bool {
        get {
            return self._textNode?.isTruncated ?? false
        }
    }
    
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
    
    public var textPlaceholderEnabled: Bool {
        get {
            return self._textNode?.placeholderEnabled ?? false
        }
        set {
            self._textNode?.placeholderEnabled = newValue
        }
    }
    
    public var placeholderColor: UIColor? {
        get {
            return self._textNode?.placeholderColor
        }
        set {
            self._textNode?.placeholderColor = newValue
        }
    }
    
    override public var shadowColor: UIColor? {
        get {
            if let color = self._textNode?.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            self._textNode?.shadowColor = newValue?.cgColor
        }
    }
    
    public var placeholderInset: [String : Double] {
        get {
            return NTConverter.edgeInsetsToMap(self._textNode?.placeholderInsets ?? UIEdgeInsets.zero)
        }
        set {
            self._textNode?.placeholderInsets = NTConverter.mapToEdgeInsets(newValue) ?? UIEdgeInsets.zero
        }
    }
    
    override public var shadowOpacity: Double // default=0.0
        {
        get {
            return Double(self._textNode?.shadowOpacity ?? 0.0)
        }
        set {
            self._textNode?.shadowOpacity = CGFloat(newValue)
        }
    }
    
    override public var shadowRadius: Double // default=0.0
    {
        get {
            return Double(self._textNode?.shadowRadius ?? 0.0)
        }
        set {
            self._textNode?.shadowRadius = CGFloat(newValue)
        }
    }
    
    override public var shadowOffset: CGSize {
        get {
            return self._textNode?.shadowOffset ?? CGSize.zero
        }
        set {
            self._textNode?.shadowOffset = newValue
        }
    }
    
    
    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTNodeConsts.Text.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        return nil
    }
}



