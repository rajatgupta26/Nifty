//
//  NTColor.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 10/07/17.
//
//

import Foundation
import JavaScriptCore

@objc public protocol UIColorExports: JSExport {
    
    static func withWhite(_ white: CGFloat, _ alpha: CGFloat) -> UIColor
    static func withHSB(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat, _ alpha: CGFloat) -> UIColor
    static func withRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor
    static func createRandom() -> UIColor!
    static func withRGBHex(_ hex: UInt32) -> UIColor
    static func withHex(_ hexString: String) -> UIColor
    static func withName(_ cssName: String) -> UIColor
    
    static func createBlack() -> UIColor
    static func createDarkGray() -> UIColor
    static func createLightGray() -> UIColor
    static func createWhite() -> UIColor
    static func createGray() -> UIColor
    static func createRed() -> UIColor
    static func createGreen() -> UIColor
    static func createBlue() -> UIColor
    static func createCyan() -> UIColor
    static func createYellow() -> UIColor
    static func createMagenta() -> UIColor
    static func createOrange() -> UIColor
    static func createPurple() -> UIColor
    static func createBrown() -> UIColor
    static func createClear() -> UIColor
    
    func copyWithAlphaComponent(_ alpha: CGFloat) -> UIColor
    
    func copyByLuminanceMapping() -> UIColor!
    
    func byMultiplyingRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor
    func byAddingRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor
    func byLighteningToRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor
    func byDarkeningToRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor
    
    func byMultiplying(_ value: CGFloat) -> UIColor
    func byAdding(_ value: CGFloat) -> UIColor
    func byLighteningTo(_ value: CGFloat) -> UIColor
    func byDarkeningTo(_ value: CGFloat) -> UIColor
    
    func byMultiplyingColor(_ color: UIColor) -> UIColor
    func byAddingColor(_ color: UIColor) -> UIColor
    func byLighteningToColor(_ color: UIColor) -> UIColor
    func byDarkeningToColor(_ color: UIColor) -> UIColor

    static func contrastingTo(_ color: UIColor) -> UIColor!
    static func complementaryTo(_ color: UIColor) -> UIColor!
    func triadics() -> [UIColor]?
    
    var canProvideRGBComponents: Bool {get}
    
    var red: CGFloat {get}
    var green: CGFloat {get}
    var blue: CGFloat {get}
    var white: CGFloat {get}
    var hue: CGFloat {get}
    var saturation: CGFloat {get}
    var brightness: CGFloat {get}
    var alpha: CGFloat {get}
    var luminance: CGFloat {get}
    var rgbHex: UInt32 {get}
    
    var hexString: String {get}
    var closestName: String {get}
}

extension UIColor: UIColorExports {
    
    public static func contrastingTo(_ color: UIColor) -> UIColor! {
        return color.contrasting()
    }
    
    public static func complementaryTo(_ color: UIColor) -> UIColor! {
        return color.complementary()
    }
    
    public func copyWithAlphaComponent(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
    
    public func copyByLuminanceMapping() -> UIColor! {
        return self.byLuminanceMapping()
    }
    
    
    public static func createRandom() -> UIColor! {
        return UIColor.random()
    }
    
    public static func createBlack() -> UIColor {
        return UIColor.black
    }
    
    public static func createDarkGray() -> UIColor {
        return UIColor.darkGray
    }
    
    public static func createLightGray() -> UIColor {
        return UIColor.lightGray
    }
    
    public static func createWhite() -> UIColor {
        return UIColor.white
    }
    
    public static func createGray() -> UIColor {
        return UIColor.gray
    }
    
    public static func createRed() -> UIColor {
        return UIColor.red
    }
    
    public static func createGreen() -> UIColor {
        return UIColor.green
    }
    
    public static func createBlue() -> UIColor {
        return UIColor.blue
    }
    
    public static func createCyan() -> UIColor {
        return UIColor.cyan
    }
    
    public static func createYellow() -> UIColor {
        return UIColor.yellow
    }
    
    public static func createMagenta() -> UIColor {
        return UIColor.magenta
    }
    
    public static func createOrange() -> UIColor {
        return UIColor.orange
    }
    
    public static func createPurple() -> UIColor {
        return UIColor.purple
    }
    
    public static func createBrown() -> UIColor {
        return UIColor.brown
    }
    
    public static func createClear() -> UIColor {
        return UIColor.clear
    }
    
    public var closestName: String {
        return self.closestColorName()
    }

    public var hexString: String {
        return self.hexStringFromColor()
    }

    public func triadics() -> [UIColor]? {
        return self.triadicColors() as? [UIColor]
    }

    public func byDarkeningToColor(_ color: UIColor) -> UIColor {
        return self.darkening(to: color)
    }

    public func byLighteningToColor(_ color: UIColor) -> UIColor {
        return self.lightening(to: color)
    }

    public func byAddingColor(_ color: UIColor) -> UIColor {
        return self.adding(color)
    }

    public func byMultiplyingColor(_ color: UIColor) -> UIColor {
        return self.multiplying(by: color)
    }

    public func byDarkeningTo(_ value: CGFloat) -> UIColor {
        return self.darkening(to: value)
    }

    public func byLighteningTo(_ value: CGFloat) -> UIColor {
        return self.lightening(to: value)
    }

    public func byAdding(_ value: CGFloat) -> UIColor {
        return self.adding(value)
    }

    public func byMultiplying(_ value: CGFloat) -> UIColor {
        return self.multiplying(by: value)
    }

    public func byDarkeningToRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return self.darkening(toRed: red, green: green, blue: blue, alpha: alpha)
    }

    public func byLighteningToRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return self.lightening(toRed: red, green: green, blue: blue, alpha: alpha)
    }

    public func byAddingRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return self.addingRed(red, green: green, blue: blue, alpha: alpha)
    }

    public func byMultiplyingRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return self.multiplying(byRed: red, green: green, blue: blue, alpha: alpha)
    }

    public static func withName(_ cssName: String) -> UIColor {
        return UIColor(name: cssName)
    }

    public static func withHex(_ hexString: String) -> UIColor {
        return UIColor(hexString: hexString)
    }

    public static func withRGBHex(_ hex: UInt32) -> UIColor {
        return UIColor(rgbHex: hex)
    }

    public static func withRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    public static func withHSB(_ hue: CGFloat, _ saturation: CGFloat, _ brightness: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    public static func withWhite(_ white: CGFloat, _ alpha: CGFloat) -> UIColor {
        return UIColor(white: white, alpha: alpha)
    }
}


extension UIColor: NTModule {

    public static func moduleName() -> String {
        return "Color"
    }
    public static func constantsToExport() -> [String: Any]? {
        return nil
    }
}

/*
 NTLOOK: Not implemented
 + (UIColor *)colorWithPatternImage:(UIImage *)image;
 - (BOOL)getWhite:(nullable CGFloat *)white alpha:(nullable CGFloat *)alpha NS_AVAILABLE_IOS(5_0);
 - (BOOL)getHue:(nullable CGFloat *)hue saturation:(nullable CGFloat *)saturation brightness:(nullable CGFloat *)brightness alpha:(nullable CGFloat *)alpha NS_AVAILABLE_IOS(5_0);
 - (BOOL)getRed:(nullable CGFloat *)red green:(nullable CGFloat *)green blue:(nullable CGFloat *)blue alpha:(nullable CGFloat *)alpha NS_AVAILABLE_IOS(5_0);

 - (NSArray*)analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs;	// Multiple pairs of colors
 */
