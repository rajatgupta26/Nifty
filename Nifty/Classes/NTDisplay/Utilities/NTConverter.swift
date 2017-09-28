//
//  NTConverter.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

import Foundation
import AsyncDisplayKit


protocol NTInsetsConverter {
    static func mapToEdgeInsets(_ map: [String: Double]) -> UIEdgeInsets?
    static func edgeInsetsToMap(_ insets: UIEdgeInsets) -> [String: Double]
}

protocol NTSizeRangeConverter {
    
    static func mapToSizeRange(_ map: [String: [String: Double]]) -> ASSizeRange?
    static func sizeRangeToMap(_ sizeRange: ASSizeRange) -> [String: [String: Double]]
}



public struct NTConverter {
    
}

extension NTConverter: NTInsetsConverter {
    
    static func mapToEdgeInsets(_ map: [String: Double]) -> UIEdgeInsets? {
        
        if let top = map["top"], let left = map["left"], let bottom = map["bottom"], let right = map["right"] {
            return UIEdgeInsetsMake(CGFloat(top), CGFloat(left), CGFloat(bottom), CGFloat(right))
        }
        return nil
    }
    
    static func edgeInsetsToMap(_ insets: UIEdgeInsets) -> [String: Double] {
        
        return ["top": Double(insets.top), "left": Double(insets.left), "bottom": Double(insets.bottom), "right": Double(insets.right)]
    }
}


extension NTConverter: NTSizeRangeConverter {
    
    static func mapToSizeRange(_ map: [String: [String: Double]]) -> ASSizeRange? {
        
        if let minWidth = map["min"]?["width"], let minHeight = map["min"]?["width"], let maxWidth = map["max"]?["width"], let maxHeight = map["max"]?["height"] {
            return ASSizeRange(min: CGSize(width: minWidth, height: minHeight), max: CGSize(width: maxWidth, height: maxHeight))
        }
        return nil
    }
    
    static func sizeRangeToMap(_ sizeRange: ASSizeRange) -> [String: [String: Double]] {
        
        return ["min": ["width": Double(sizeRange.min.width), "height": Double(sizeRange.min.height)], "max": ["width": Double(sizeRange.max.width), "height": Double(sizeRange.max.height)]]
    }
}
