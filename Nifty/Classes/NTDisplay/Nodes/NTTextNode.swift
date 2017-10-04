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
 
 /**
 * An array of path objects representing the regions where text should not be displayed.
 *
 * @discussion The default value of this property is an empty array. You can
 * assign an array of UIBezierPath objects to exclude text from one or more regions in
 * the text node's bounds. You can use this property to have text wrap around images,
 * shapes or other text like a fancy magazine.
 */
 @property (nullable, nonatomic, strong) NSArray<UIBezierPath *> *exclusionPaths;
 
 #pragma mark - Placeholders
 /**
 @abstract Inset each line of the placeholder.
 */
 @property (nonatomic, assign) UIEdgeInsets placeholderInsets;
 
 #pragma mark - Shadow
 
 /**
 @abstract The number of pixels used for shadow padding on each side of the receiver.
 @discussion Each inset will be less than or equal to zero, so that applying
 UIEdgeInsetsRect(boundingRectForText, shadowPadding)
 will return a CGRect large enough to fit both the text and the appropriate shadow padding.
 */
 @property (nonatomic, readonly, assign) UIEdgeInsets shadowPadding;
 
 #pragma mark - Positioning
 
 /**
 @abstract Returns an array of rects bounding the characters in a given text range.
 @param textRange A range of text. Must be valid for the receiver's string.
 @discussion Use this method to detect all the different rectangles a given range of text occupies.
 The rects returned are not guaranteed to be contiguous (for example, if the given text range spans
 a line break, the rects returned will be on opposite sides and different lines). The rects returned
 are in the coordinate system of the receiver.
 */
 - (NSArray<NSValue *> *)rectsForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
 
 /**
 @abstract Returns an array of rects used for highlighting the characters in a given text range.
 @param textRange A range of text. Must be valid for the receiver's string.
 @discussion Use this method to detect all the different rectangles the highlights of a given range of text occupies.
 The rects returned are not guaranteed to be contiguous (for example, if the given text range spans
 a line break, the rects returned will be on opposite sides and different lines). The rects returned
 are in the coordinate system of the receiver. This method is useful for visual coordination with a
 highlighted range of text.
 */
 - (NSArray<NSValue *> *)highlightRectsForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
 
 /**
 @abstract Returns a bounding rect for the given text range.
 @param textRange A range of text. Must be valid for the receiver's string.
 @discussion The height of the frame returned is that of the receiver's line-height; adjustment for
 cap-height and descenders is not performed. This method raises an exception if textRange is not
 a valid substring range of the receiver's string.
 */
 - (CGRect)frameForTextRange:(NSRange)textRange AS_WARN_UNUSED_RESULT;
 
 /**
 @abstract Returns the trailing rectangle of space in the receiver, after the final character.
 @discussion Use this method to detect which portion of the receiver is not occupied by characters.
 The rect returned is in the coordinate system of the receiver.
 */
 - (CGRect)trailingRect AS_WARN_UNUSED_RESULT;
 
 
 #pragma mark - Actions
 
 /**
 @abstract The set of attribute names to consider links.  Defaults to NSLinkAttributeName.
 */
 @property (nonatomic, copy) NSArray<NSString *> *linkAttributeNames;
 
 /**
 @abstract Indicates whether the receiver has an entity at a given point.
 @param point The point, in the receiver's coordinate system.
 @param attributeNameOut The name of the attribute at the point. Can be NULL.
 @param rangeOut The ultimate range of the found text. Can be NULL.
 @result YES if an entity exists at `point`; NO otherwise.
 */
 - (nullable id)linkAttributeValueAtPoint:(CGPoint)point attributeName:(out NSString * _Nullable * _Nullable)attributeNameOut range:(out NSRange * _Nullable)rangeOut AS_WARN_UNUSED_RESULT;
 
 /**
 @abstract The style to use when highlighting text.
 */
 @property (nonatomic, assign) ASTextNodeHighlightStyle highlightStyle;
 
 /**
 @abstract The range of text highlighted by the receiver. Changes to this property are not animated by default.
 */
 @property (nonatomic, assign) NSRange highlightRange;
 
 /**
 @abstract Set the range of text to highlight, with optional animation.
 
 @param highlightRange The range of text to highlight.
 
 @param animated Whether the text should be highlighted with an animation.
 */
 - (void)setHighlightRange:(NSRange)highlightRange animated:(BOOL)animated;
 
 /**
 @abstract Responds to actions from links in the text node.
 @discussion The delegate must be set before the node is loaded, and implement
 textNode:longPressedLinkAttribute:value:atPoint:textRange: in order for
 the long press gesture recognizer to be installed.
 */
 @property (nonatomic, weak) id<ASTextNodeDelegate> delegate;
 
 /**
 @abstract If YES and a long press is recognized, touches are cancelled. Default is NO
 */
 @property (nonatomic, assign) BOOL longPressCancelsTouches;
 
 /**
 @abstract if YES will not intercept touches for non-link areas of the text. Default is NO.
 */
 @property (nonatomic, assign) BOOL passthroughNonlinkTouches;
 
 @end
 
 #else
 
 @interface ASTextNode : ASTextNode2
 @end
 
 #endif
 
 /**
 * @abstract Text node delegate.
 */
 @protocol ASTextNodeDelegate <NSObject>
 @optional
 
 /**
 @abstract Indicates to the delegate that a link was tapped within a text node.
 @param textNode The ASTextNode containing the link that was tapped.
 @param attribute The attribute that was tapped. Will not be nil.
 @param value The value of the tapped attribute.
 @param point The point within textNode, in textNode's coordinate system, that was tapped.
 @param textRange The range of highlighted text.
 */
 - (void)textNode:(ASTextNode *)textNode tappedLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point textRange:(NSRange)textRange;
 
 /**
 @abstract Indicates to the delegate that a link was tapped within a text node.
 @param textNode The ASTextNode containing the link that was tapped.
 @param attribute The attribute that was tapped. Will not be nil.
 @param value The value of the tapped attribute.
 @param point The point within textNode, in textNode's coordinate system, that was tapped.
 @param textRange The range of highlighted text.
 @discussion In addition to implementing this method, the delegate must be set on the text
 node before it is loaded (the recognizer is created in -didLoad)
 */
 - (void)textNode:(ASTextNode *)textNode longPressedLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point textRange:(NSRange)textRange;
 
 //! @abstract Called when the text node's truncation string has been tapped.
 - (void)textNodeTappedTruncationToken:(ASTextNode *)textNode;
 
 /**
 @abstract Indicates to the text node if an attribute should be considered a link.
 @param textNode The text node containing the entity attribute.
 @param attribute The attribute that was tapped. Will not be nil.
 @param value The value of the tapped attribute.
 @param point The point within textNode, in textNode's coordinate system, that was touched to trigger a highlight.
 @discussion If not implemented, the default value is YES.
 @return YES if the entity attribute should be a link, NO otherwise.
 */
 - (BOOL)textNode:(ASTextNode *)textNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point;
 
 /**
 @abstract Indicates to the text node if an attribute is a valid long-press target
 @param textNode The text node containing the entity attribute.
 @param attribute The attribute that was tapped. Will not be nil.
 @param value The value of the tapped attribute.
 @param point The point within textNode, in textNode's coordinate system, that was long-pressed.
 @discussion If not implemented, the default value is NO.
 @return YES if the entity attribute should be treated as a long-press target, NO otherwise.
 */
 - (BOOL)textNode:(ASTextNode *)textNode shouldLongPressLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point;
 
 @end
 
 #if !ASTEXTNODE_EXPERIMENT_GLOBAL_ENABLE
 
 @interface ASTextNode (Unavailable)
 
 - (instancetype)initWithLayerBlock:(ASDisplayNodeLayerBlock)viewBlock didLoadBlock:(nullable ASDisplayNodeDidLoadBlock)didLoadBlock __unavailable;
 
 - (instancetype)initWithViewBlock:(ASDisplayNodeViewBlock)viewBlock didLoadBlock:(nullable ASDisplayNodeDidLoadBlock)didLoadBlock __unavailable;
 
 @end
 
 /**
 * @abstract Text node deprecated properties
 */
 @interface ASTextNode (Deprecated)
 
 /**
 The attributedString and attributedText properties are equivalent, but attributedText is now the standard API
 name in order to match UILabel and ASEditableTextNode.
 
 @see attributedText
 */
 @property (nullable, nonatomic, copy) NSAttributedString *attributedString ASDISPLAYNODE_DEPRECATED_MSG("Use .attributedText instead.");
 
 
 /**
 The truncationAttributedString and truncationAttributedText properties are equivalent, but truncationAttributedText is now the
 standard API name in order to match UILabel and ASEditableTextNode.
 
 @see truncationAttributedText
 */
 @property (nullable, nonatomic, copy) NSAttributedString *truncationAttributedString ASDISPLAYNODE_DEPRECATED_MSG("Use .truncationAttributedText instead.");
 
 @end*/

public typealias NTLineBreakMode = Int
public let kNTLineBreakModeByTruncatingTail = NSLineBreakMode.byTruncatingTail.rawValue


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
            return self._textNode?.truncationMode.rawValue ?? NSLineBreakMode.byTruncatingTail.rawValue
        }
        set {
            self._textNode?.truncationMode = NSLineBreakMode(rawValue: newValue) ?? .byTruncatingTail
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
