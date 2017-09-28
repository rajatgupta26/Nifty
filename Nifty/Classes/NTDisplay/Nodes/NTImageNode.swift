//
//  NTImageNode.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 10/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit

/*
 //MARK: Not implemented
 @property (nullable, nonatomic, readwrite, copy) asimagenode_modification_block_t imageModificationBlock;
 #if TARGET_OS_TV
 @property (nonatomic, assign) BOOL isDefaultFocusAppearance;
 #endif
 @property (nullable, nonatomic, strong) id <ASAnimatedImageProtocol> animatedImage;
 @property (nonatomic, assign) BOOL animatedImagePaused;
 
 @property (nonatomic, strong) NSString *animatedImageRunLoopMode;
 - (void)animatedImageSet:(id <ASAnimatedImageProtocol>)newAnimatedImage previousAnimatedImage:(id <ASAnimatedImageProtocol>)previousAnimatedImage;
 asimagenode_modification_block_t ASImageNodeRoundBorderModificationBlock(CGFloat borderWidth, UIColor * _Nullable borderColor);
 asimagenode_modification_block_t ASImageNodeTintColorModificationBlock(UIColor *color);
*/

@objc public protocol NTImageNodeExports: JSExport, NTControlNodeExport {
    
    var image: UIImage? {get set}
    
    var placeholderColor: UIColor? {get set}
    
    var isCropEnabled: Bool {get set}
    
    var forceUpscaling: Bool {get set}
    
    var forcedSize: CGSize {get set}
    
    var cropRect: CGRect {get set}
    
    func setCropEnabled(_ cropEnabled: Bool, _ recropImmediately: Bool, _ cropBounds: CGRect)
    
    func setNeedsDisplayWithCompletion(_ completion: @escaping (Bool) -> Void)
}



@objc public class NTImageNode: NTControlNode, NTImageNodeExports {
    
    private var _imageNode: ASImageNode? {
        get {
            return self.asNode as? ASImageNode
        }
    }
    
    public override func loadNode() -> ASDisplayNode {
        return ASImageNode()
    }
    
    public func setNeedsDisplayWithCompletion(_ completion: @escaping (Bool) -> Void) {
        self._imageNode?.setNeedsDisplayWithCompletion(completion)
    }

    public func setCropEnabled(_ cropEnabled: Bool, _ recropImmediately: Bool, _ cropBounds: CGRect) {
        self._imageNode?.setCropEnabled(cropEnabled, recropImmediately: recropImmediately, inBounds: cropBounds)
    }

    public var cropRect: CGRect = CGRect.zero

    public var forcedSize: CGSize = CGSize.zero

    public var forceUpscaling: Bool = false

    public var isCropEnabled: Bool = false
    
    public var placeholderColor: UIColor?
    
    public var image: UIImage? {
        get {
            return self._imageNode?.image
        }
        set {
            self._imageNode?.image = newValue
        }
    }
}


extension NTImageNode {
    
    public override static func moduleName() -> String {
        return NTNodeConsts.Image.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        return nil
    }
}


















