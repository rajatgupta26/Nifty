//
//  NTImage.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 11/07/17.
//
//

/*
 This class exposes necessary UIImage and functionality
 */


import Foundation
import JavaScriptCore
/*
 NTLOOK: Not implemented
 open func withAlignmentRectInsets(_ alignmentInsets: UIEdgeInsets) -> UIImage
 open var alignmentRectInsets: UIEdgeInsets { get }
*/

//MARK: Constants
public typealias NTImageRenderingMode = UIImageRenderingMode.RawValue
public let NTImageRenderingModeAutomatic = UIImageRenderingMode.automatic.rawValue
public let NTImageRenderingModeOriginal = UIImageRenderingMode.alwaysOriginal.rawValue
public let NTImageRenderingModeTemplate = UIImageRenderingMode.alwaysTemplate.rawValue


internal struct NTImageConsts {
    static let name = "Image"
    
    static let renderingMode = "RenderingMode"
    enum RenderingMode: String {
        case automatic
        case original
        case template
    }
    
    static let resizingMode = "ResizingMode"
    enum ResizingMode: String {
        case tile
        case stretch
    }
}


public typealias NTImageResizingMode = UIImageResizingMode.RawValue
public let NTImageResizingModeTile = UIImageResizingMode.tile.rawValue
public let NTImageResizingModeStretch = UIImageResizingMode.stretch.rawValue



//MARK: UIImageExports
@objc public protocol UIImageExports: JSExport {
    
    static func createWithName(_ name: String) -> UIImage?
    static func createWithPath(_ path: String) -> UIImage?
    
    static func animatedWithNameAndDuration(_ name: String, _ duration: TimeInterval) -> UIImage?
    static func animatedResizableWithNameInsetsAndDuration(_ name: String, _ capInsets: [String: Double], _ duration: TimeInterval) -> UIImage?
    static func animatedResizableWithNameInsetsModeAndDuration(_ name: String, _ capInsets: [String: Double], _ resizingMode: NTImageResizingMode, _ duration: TimeInterval) -> UIImage?
    static func animatedWithImagesAndDuration(_ images: [UIImage], _ duration: TimeInterval) -> UIImage?
    
    var size: CGSize {get}
    var imageOrientation: UIImageOrientation { get }
    var scale: CGFloat { get }
    
    var images: [UIImage]? { get }
    var duration: TimeInterval { get }
    
    func resizableWithCapInsets(_ insets: [String: Double]) -> UIImage?
    func resizableWithCapInsetsAndMode(_ insets: [String: Double], _ resizingMode: NTImageResizingMode) -> UIImage?
    
    var capInsetsMap: [String: Double] { get }
    var imageResizingMode: NTImageResizingMode { get }
    
    func forRenderingMode(_ renderingMode: NTImageRenderingMode) -> UIImage
    var imageRenderingMode: NTImageRenderingMode { get }
    
    func imageFlippedForRightToLeftLayoutDirection() -> UIImage
    var flipsForRightToLeftLayoutDirection: Bool { get }
    func byFliipingHorizontally() -> UIImage
    
    func stretchableWithCaps(_ leftCapWidth: Int, _ topCapHeight: Int) -> UIImage
    var leftCapWidth: Int { get }
    var topCapHeight: Int { get }
}



//MARK: UIImage Export Extension
extension UIImage: UIImageExports {

    public func forRenderingMode(_ renderingMode: NTImageRenderingMode) -> UIImage {
        return self.withRenderingMode(UIImageRenderingMode(rawValue: renderingMode) ?? .automatic)
    }

    public var imageRenderingMode: NTImageRenderingMode {
        get {
            return self.renderingMode.rawValue
        }
    }
    
    
    public func byFliipingHorizontally() -> UIImage {
        if #available(iOS 10.0, *) {
            return self.withHorizontallyFlippedOrientation()
        } else {
            return self
        }
    }
    
    
    public func stretchableWithCaps(_ leftCapWidth: Int, _ topCapHeight: Int) -> UIImage {
        return self.stretchableImage(withLeftCapWidth: leftCapWidth, topCapHeight: topCapHeight)
    }
    
    
    public var capInsetsMap: [String : Double] {
        return NTConverter.edgeInsetsToMap(self.capInsets)
    }

    
    public var imageResizingMode: NTImageResizingMode {
        return self.resizingMode.rawValue
    }
    
    public func resizableWithCapInsetsAndMode(_ insets: [String : Double], _ resizingMode: NTImageResizingMode) -> UIImage? {
        
        if let insets = NTConverter.mapToEdgeInsets(insets) {
            return self.resizableImage(withCapInsets: insets, resizingMode: UIImageResizingMode(rawValue: resizingMode) ?? .stretch)
        }
        return nil
    }

    public func resizableWithCapInsets(_ insets: [String : Double]) -> UIImage? {
        
        if let insets = NTConverter.mapToEdgeInsets(insets) {
            return self.resizableImage(withCapInsets: insets)
        }
        return nil
    }

    public static func animatedWithImagesAndDuration(_ images: [UIImage], _ duration: TimeInterval) -> UIImage? {
        return UIImage.animatedImage(with: images, duration: duration)
    }

    public static func animatedResizableWithNameInsetsModeAndDuration(_ name: String, _ capInsets: [String : Double], _ resizingMode: NTImageResizingMode, _ duration: TimeInterval) -> UIImage? {
        
        if let insets = NTConverter.mapToEdgeInsets(capInsets) {
            return UIImage.animatedResizableImageNamed(name, capInsets: insets, resizingMode: UIImageResizingMode(rawValue: resizingMode) ?? .stretch, duration: duration)
        }
        return nil
    }

    public static func animatedResizableWithNameInsetsAndDuration(_ name: String, _ capInsets: [String : Double], _ duration: TimeInterval) -> UIImage? {
        
        if let insets = NTConverter.mapToEdgeInsets(capInsets) {
            return UIImage.animatedResizableImageNamed(name, capInsets: insets, duration: duration)
        }
        return nil
    }

    public static func animatedWithNameAndDuration(_ name: String, _ duration: TimeInterval) -> UIImage? {
        return UIImage.animatedImageNamed(name, duration: duration)
    }

    public static func createWithPath(_ path: String) -> UIImage? {
        return UIImage(contentsOfFile: path)
    }

    public static func createWithName(_ name: String) -> UIImage? {
        return UIImage(named: name)
    }
}



//MARK: UIImage NTModule Extension
extension UIImage: NTModule {
    
    public static func moduleName() -> String {
        return NTImageConsts.name
    }
    
    public static func constantsToExport() -> [String: Any]? {
        return [NTImageConsts.resizingMode: [NTImageConsts.ResizingMode.stretch.rawValue: NTImageResizingModeStretch,
                                             NTImageConsts.ResizingMode.tile.rawValue: NTImageResizingModeTile],
                NTImageConsts.renderingMode:[NTImageConsts.RenderingMode.automatic.rawValue: NTImageRenderingModeAutomatic,
                                             NTImageConsts.RenderingMode.template.rawValue: NTImageRenderingModeTemplate,
                                             NTImageConsts.RenderingMode.original.rawValue: NTImageRenderingModeOriginal]]
    }
}
































