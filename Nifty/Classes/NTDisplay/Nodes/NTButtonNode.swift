//
//  NTButtonNode.swift
//  Pods
//
//  Created by Keerthana Reddy Ragi on 04/10/17.
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit
/*
 
 /** Horizontally align content (text or image).
 Defaults to ASHorizontalAlignmentMiddle.
 */
 @property (nonatomic, assign) ASHorizontalAlignment contentHorizontalAlignment;
 
 /** Vertically align content (text or image).
 Defaults to ASVerticalAlignmentCenter.
 */
 @property (nonatomic, assign) ASVerticalAlignment contentVerticalAlignment;
 
 /**
 * @discussion The insets used around the title and image node
 */
 @property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
 
 /**
 * @discusstion Whether the image should be aligned at the beginning or at the end of node. Default is `ASButtonNodeImageAlignmentBeginning`.
 */
 @property (nonatomic, assign) ASButtonNodeImageAlignment imageAlignment;
 
 /**
 *  Returns the styled title associated with the specified state.
 *
 *  @param state The control state that uses the styled title.
 *
 *  @return The title for the specified state.
 */
 - (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state AS_WARN_UNUSED_RESULT;
 
 /**
 *  Sets the styled title to use for the specified state. This will reset styled title previously set with -setTitle:withFont:withColor:forState.
 *
 *  @param title The styled text string to use for the title.
 *  @param state The control state that uses the specified title.
 */
 - (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;
 /**
 *  Returns the image used for a button state.
 *
 *  @param state The control state that uses the image.
 *
 *  @return The image used for the specified state.
 */
 - (nullable UIImage *)imageForState:(UIControlState)state AS_WARN_UNUSED_RESULT;

 /**
 *  Returns the background image used for a button state.
 *
 *  @param state The control state that uses the image.
 *
 *  @return The background image used for the specified state.
 */
 - (nullable UIImage *)backgroundImageForState:(UIControlState)state AS_WARN_UNUSED_RESULT;
*/

@objc public protocol NTButtonNodeExports: JSExport, NTControlNodeExport {
    
    var titleNode: NTTextNode? {get set}
    var imageNode: NTImageNode? {get set}
    var backgroundImageNode: NTImageNode? {get set}
    var contentSpacing: Double {get set}
    var laysOutHorizontally: Bool {get set}
    func setTitle(_ title: String, _ font: UIFont, _ color: UIColor, _ state: UIControlState)
    func setBackgroundImage(_ image: UIImage, _ state: UIControlState)
    func setImage(_ image: UIImage, _ state: UIControlState)
}

@objc public class NTButtonNode: NTControlNode, NTButtonNodeExports {
    private var _buttonNode: NTButtonNode? {
        get {
            return self.asNode as? NTButtonNode
        }
    }
    
    public override func loadNode() -> ASDisplayNode {
        return ASButtonNode()
    }
    
    public var titleNode: NTTextNode? {
        get{
            return self._buttonNode?.titleNode
        }
        set {
            self._buttonNode?.titleNode = newValue
        }
    }
    
    public var imageNode: NTImageNode? {
        get{
            return self._buttonNode?.imageNode
        }
        set {
            self._buttonNode?.imageNode = newValue
        }
    }
    
    public var backgroundImageNode: NTImageNode? {
        get{
            return self._buttonNode?.backgroundImageNode
        }
        set {
            self._buttonNode?.backgroundImageNode = newValue
        }
    }
    
    public var contentSpacing: Double // default=0.0
    {
        get {
            return Double(self._buttonNode?.contentSpacing ?? 0.0)
        }
        set {
            self._buttonNode?.contentSpacing = newValue
        }
    }
    
    public var laysOutHorizontally: Bool = false
    
    public func setTitle(_ title: String, _ font: UIFont, _ color: UIColor, _ state: UIControlState) {
        self._buttonNode?.setTitle(title, font, color, state)
    }
    
    public func setBackgroundImage(_ image: UIImage, _ state: UIControlState){
        self._buttonNode?.setBackgroundImage(image, state)
    }
    
    public func setImage(_ image: UIImage, _ state: UIControlState){
        self._buttonNode?.setImage(image, state)
    }
}

extension NTButtonNode {
    
    public override static func moduleName() -> String {
        return NTNodeConsts.Button.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        return nil
    }
}
