//
//  NTLayoutElement.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

import Foundation
import AsyncDisplayKit
import JavaScriptCore


@objc public enum NTLayoutElementType: UInt {
    case spec
    case node
}

/*
 @property (nonatomic, assign, readwrite) ASDimension width;

 @property (nonatomic, assign, readwrite) ASDimension height;

 @property (nonatomic, assign, readwrite) ASDimension minHeight;
 
 @property (nonatomic, assign, readwrite) ASDimension maxHeight;

 @property (nonatomic, assign, readwrite) ASDimension minWidth;

 @property (nonatomic, assign, readwrite) ASDimension maxWidth;
 
 @property (nonatomic, assign) CGSize preferredSize;
 
 @property (nonatomic, assign) CGSize minSize;
 
 @property (nonatomic, assign) CGSize maxSize;
 
 @property (nonatomic, assign, readwrite) ASLayoutSize preferredLayoutSize;
 
 @property (nonatomic, assign, readwrite) ASLayoutSize minLayoutSize;
 
 @property (nonatomic, assign, readwrite) ASLayoutSize maxLayoutSize;
*/

@objc public protocol NTLayoutElementStyleExport: JSExport {
    var width: CGFloat {get set}
    var relativeWidth: CGFloat {get set}
    
    var height: CGFloat {get set}
    var relativeHeight: CGFloat {get set}
    
    var minHeight: CGFloat {get set}
    var relativeMinHeight: CGFloat {get set}
    
    var maxHeight: CGFloat {get set}
    var relativeMaxHeight: CGFloat {get set}
    
    var minWidth: CGFloat {get set}
    var relativeMinWidth: CGFloat {get set}
    
    var maxWidth: CGFloat {get set}
    var relativeMaxWidth: CGFloat {get set}
    
    var preferredSize: CGSize {get set}
    var relativePreferredSize: CGSize {get set}
}



@objc public protocol NTLayoutElement: class, NTLayoutElementStyleExport {
    
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

//NTLOOK: All ASDimension values will be created with ASDimensionUnitPoints only. Assuming that Nifty will operate only on points.

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
