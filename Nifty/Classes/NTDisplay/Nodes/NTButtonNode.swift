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
 @property (nonatomic, assign) ASHorizontalAlignment contentHorizontalAlignment;
 @property (nonatomic, assign) ASVerticalAlignment contentVerticalAlignment;
 @property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
 @property (nonatomic, assign) ASButtonNodeImageAlignment imageAlignment;
 - (nullable NSAttributedString *)attributedTitleForState:(UIControlState)state AS_WARN_UNUSED_RESULT;
 - (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(UIControlState)state;
 - (nullable UIImage *)imageForState:(UIControlState)state AS_WARN_UNUSED_RESULT;
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
