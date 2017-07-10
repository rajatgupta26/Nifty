//
//  NTLayoutElement.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

import Foundation
import AsyncDisplayKit


@objc public enum NTLayoutElementType: UInt {
    case spec
    case node
}


@objc public protocol NTLayoutElement: class {
    
    var layoutElementType: NTLayoutElementType {get}
    
    var sublayoutElements: [NTLayoutElement]? {get}
    
    var asLayoutElement: ASLayoutElement? {get}
    
    
    /*
     Not implemented
     
     - style
     - (ASLayout *)layoutThatFits:(ASSizeRange)constrainedSize;
     - (ASLayout *)layoutThatFits:(ASSizeRange)constrainedSize parentSize:(CGSize)parentSize;
     - (ASLayout *)calculateLayoutThatFits:(ASSizeRange)constrainedSize;
     - (ASLayout *)calculateLayoutThatFits:(ASSizeRange)constrainedSize
     restrictedToSize:(ASLayoutElementSize)size
     relativeToParentSize:(CGSize)parentSize;
     */
}


extension NTLayoutElement {
    
    var layoutElementType: NTLayoutElementType {
        get {
            return .spec
        }
    }
    
    
    var sublayoutElements: [NTLayoutElement]? {
        get {
            return nil
        }
    }
    
    
//    var asLayoutElement: ASLayoutElement? {
//        get {
//            return nil
//        }
//    }
}
