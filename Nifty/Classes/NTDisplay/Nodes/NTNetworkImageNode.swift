//
//  NTNetworkImageNode.swift
//  Pods
//
//  Created by Naveen Chaudhary on 23/11/17.
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit

@objc public protocol NTNetworkImageNodeExports: JSExport, NTControlNodeExport {

    var image: UIImage? {get set}
    var defaultImage: UIImage? {get set}

    var url: String? {get set}
    
    var shouldCacheImage: Bool {get set}
    var shouldRenderProgressImages: Bool {get set}
    var currentImageQuality: CGFloat {get}
    var renderedImageQuality: CGFloat {get}
    
    func setURL(_ string:String?, _ resetToDefault:Bool)
}



@objc public class NTNetworkImageNode: NTControlNode, NTNetworkImageNodeExports {
    
    private var _networkImageNode: ASNetworkImageNode? {
        get {
            return self.asNode as? ASNetworkImageNode
        }
    }
    
    public override func loadNode() -> ASDisplayNode {
        let node = ASNetworkImageNode()
        return node
    }
    
    public var image: UIImage? {
        get {
            return self._networkImageNode?.image
        }
        set {
            self._networkImageNode?.image = newValue
            if let image = newValue {
                self._networkImageNode?.style.preferredSize = image.size
            }
        }
    }
    
    public var defaultImage: UIImage? {
        get {
            return self._networkImageNode?.defaultImage
        }
        set {
            self._networkImageNode?.defaultImage = newValue
        }
    }
    
    public var url: String? {
        get {
            return self._networkImageNode?.url?.absoluteString
        }
        set {
            if let urlString = newValue {
                self._networkImageNode?.url = URL(string: urlString)
            }
        }
    }
    
    public var shouldCacheImage: Bool {
        get {
            return (self._networkImageNode?.shouldCacheImage)!
        }
        set {
            self._networkImageNode?.shouldCacheImage = newValue
        }
    }
    
    public var shouldRenderProgressImages: Bool {
        get {
            return (self._networkImageNode?.shouldRenderProgressImages)!
        }
        set {
            self._networkImageNode?.shouldRenderProgressImages = newValue
        }
    }
    
    public var currentImageQuality: CGFloat {
        get {
            return (self._networkImageNode?.currentImageQuality)!
        }
    }
    
    public var renderedImageQuality: CGFloat {
        get {
            return (self._networkImageNode?.renderedImageQuality)!
        }
    }
    
    public func setURL(_ string: String?, _ resetToDefault: Bool) {
        if let urlString = string, let url = URL(string: urlString) {
            self._networkImageNode?.setURL(url, resetToDefault: resetToDefault)
        }
    }

    
    //MARK:-
    //MARK:NTModule
    public override static func moduleName() -> String {
        return NTNodeConsts.NetworkImage.name
    }
    
    public override static func constantsToExport() -> [String : Any]? {
        return nil
    }
}
