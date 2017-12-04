//
//  NTCommons.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 21/06/17.
//
//

import Foundation
import CwlUtils


public extension PThreadMutex {
    func fastSync<R>(execute work: () throws -> R) rethrows -> R {
        pthread_mutex_lock(&unsafeMutex)
        defer { pthread_mutex_unlock(&unsafeMutex) }
        return try work()
    }
}


//NTLOOK: May be we can define a better debug criteria
var NT_DEBUG: Bool {
    get {
        #if DEBUG
            return true
        #else
            return false
        #endif
    }
}

var NT_RELEASE: Bool {
    get {
        return !NT_DEBUG
    }
}


#if DEBUG
    //NTLOOK: it might make sense to just call debug code directly in these functions unless definition of NT_DEBUG is more than just the DEBUG env variable
    //NTLOOK: Capturing blocks involves capturing environment and that means heap allocations, which will be slower than may be an inline function.
    //Need to figure out a better way to do this.
    func NT_EXECUTE<T>(debug dCode: () -> T, release rCode: () -> T) -> T {
        if NT_DEBUG {
            return dCode()
        } else {
            return rCode()
        }
    }
    
//    func NT_EXECUTE(debug dCode: () -> Void, release rCode: () -> Void) {
//        if NT_DEBUG {
//            dCode()
//        } else {
//            rCode()
//        }
//    }
    
    func NTD_EXECUTE<T>(_ code: () -> T) -> T? {
        return code()
    }
    
    func NTR_EXECUTE<T>(_ code: () -> T) -> T? {
        return nil
    }
    
#else
    
    func NT_EXECUTE<T>(debug dCode: () -> T, release rCode: () -> T) -> T {
        return rCode()
    }
    
//    func NT_EXECUTE(debug dCode: () -> Void, release rCode: () -> Void) {
//        rCode()
//    }
    
    func NTD_EXECUTE<T>(_ code: () -> T) -> T? {
        return nil
    }
    
    func NTR_EXECUTE<T>(_ code: () -> T) -> T? {
        return code()
    }
    
#endif


//NTLOOK: Find a better alternative to this. Using module also solve this. And how to make this function name a constant?
private struct Scripts {
    static let isKindOf: String = "var is = function(obj){ return typeof(obj) }"
}


//MARK: Constants

internal struct NTCommons {
    struct Constants {
        enum Kinds: String {
            case undefined = "undefined"
            case object = "object"
            case boolean = "boolean"
            case number = "number"
            case string = "string"
            case symbol = "symbol"
            case function = "function"
        }
    }
    
    static let scripts: [String] = [Scripts.isKindOf]
}




internal struct NTSpecConsts {
    struct Absolute {
        static let name = "AbsoluteSpec"
        static let sizing = "Sizing"
        enum Sizing: String {
            case `default` = "default"
            case sizeToFit = "sizeToFit"
        }
    }
    
    struct Inset {
        static let name = "InsetSpec"
    }
    
    struct Background {
        static let name = "BackgroundSpec"
    }
    
    struct Center {
        static let name = "CenterSpec"
        
        static let centeringOption = "CenteringOption"
        enum CenteringOption: String {
            case none = "none"
            case x = "x"
            case y = "y"
            case xy = "xy"
        }
        
        static let sizingOption = "SizingOption"
        enum SizingOption: String {
            case `default` = "default"
            case minX = "minX"
            case minY = "minY"
            case minXY = "minXY"
        }
    }
    
    struct Wrapper {
        static let name = "WrapperSpec"
    }
    
    struct Overlay {
        static let name = "OverlaySpec"
    }
    
    struct Ratio {
        static let name = "RatioSpec"
    }
    
    struct Relative {
        static let name = "RelativeSpec"
        
        static let position = "Position"
        enum Position: String {
            case none  
            case start 
            case center
            case end
        }
        
        static let sizingOption = "SizingOption"
        enum SizingOption: String {
            case `default` 
            case minWidth  
            case minHeight 
            case minSize
        }
    }
    
    struct Yoga {
        static let name = "YogaSpec"
    }
    
    struct Stack {
        static let name = "StackSpec"
        
        static let direction = "Direction"
        enum Direction: String {
            case vertical
            case horizontal
        }
        
        static let justifyContent = "JustifyContent"
        enum JustifyContent: String {
            case start
            case center
            case end
            case spaceBetween
            case spaceAround
        }
        
        static let alignItems = "AlignItems"
        enum AlignItems: String {
            case start
            case end
            case center
            case stretch
            case baselineFirst
            case baselineLast
            case notSet
        }
        
        static let alignSelf = "AlignSelf"
        enum AlignSelf: String {
            case auto
            case start
            case end
            case center
            case stretch
        }
        
        static let flexWrap = "FlexWrap"
        enum FlexWrap: String {
            case noWrap
            case wrap
        }
        
        static let alignContent = "AlignContent"
        enum AlignContent: String {
            case start
            case center
            case end
            case spaceBetween
            case spaceAround
            case stretch
        }
        
        static let horizontalAlignment = "HorizontalAlignment"
        enum HorizontalAlignment: String {
            case none
            case left
            case middle
            case right
        }
        
        static let verticalAlignment = "VerticalAlignment"
        enum VerticalAlignment: String {
            case none  
            case top   
            case center
            case bottom
        }
        
        static let options = "Options"
        static let spacing = "Spacing"

//        
//        static let isConcurrent = "IsConcurrent"
//
//        enum Options: String {
//            case isConcurrent
//            case verticalAlignment
//            case horizontalAlignment
//            case alignContent
//            case flexWrap
//            case alignSelf
//            case alignItems
//            case justifyContent
//            case direction
//        }
    }
}


internal struct NTNodeConsts {
    struct Node {
        static let name = "Node"
        static let interfaceState = "InterfaceState"
        enum InterfaceState: String {
            case none = "none"
            case preload = "preload"
            case display = "display"
            case visible = "visible"
            case inHierarchy = "inHierarchy"
        }
        
        static let autoResizing = "AutoResizing"
        enum AutoResizing: String {
            case flexibleLeft = "flexibleLeft"
            case flexibleRight = "flexibleRight"
            case flexibleTop = "flexibleTop"
            case flexibleBottom = "flexibleBottom"
            case flexibleWidth = "flexibleWidth"
            case flexibleHeight = "flexibleHeight"
        }
                
        static let contentMode = "ContentMode"
        enum ContentMode: String {
            case scaleToFill = "scaleToFill"
            case scaleAspectFit = "scaleAspectFit"
            case scaleAspectFill = "scaleAspectFill"
            case redraw = "redraw"
            case center = "center"
            case top = "top"
            case bottom = "bottom"
            case left = "left"
            case right = "right"
            case topLeft = "topLeft"
            case topRight = "topRight"
            case bottomLeft = "bottomLeft"
            case bottomRight = "bottomRight"
        }
    }
    
    struct Control {
        static let name = "ControlNode"
        
        static let event = "Event"
        enum Event: String {
            case touchDown
            case touchDownRepeat
            case touchDragInside
            case touchDragOutside
            case touchUpInside
            case touchUpOutside
            case touchCancel
            case valueChanged
            case primaryActionTriggered
            case allEvents
        }
        
        static let state = "State"
        enum State: String {
            case normal
            case disabled
            case highlighted
            case selected
        }
    }
    
    struct Image {
        static let name = "ImageNode"
    }
    
    struct NetworkImage {
        static let name = "NetworkImageNode"
    }
    
    struct Text {
        static let name = "TextNode"
    }
    
    struct Button {
        static let name = "ButtonNode"
    }
}





























