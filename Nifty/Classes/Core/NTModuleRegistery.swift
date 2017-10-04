//
//  NTModuleRegistery.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 16/06/17.
//
//

import Foundation
import JavaScriptCore


public protocol NTModule: class {
    static func moduleName() -> String
    static func constantsToExport() -> [String: Any]?
}

/*
 NTLOOK:
 See if we can benefit from ReactNative's approach.
 So what ReactNative does is, it injects all the methods and constants of each module
 as JSValueRef properties of batched bridge into JSContextRef.
 I think what this helps with is when JS invokes any method or property of module
 using dot (Module.method), it does using batched bridge's method 'enqueJSCall:'.
 And in that method ReactNative can find out the module and method.
 They also maintain the metadata of each module, so they can check whether the module
 has that method or property and throw meaningful exceptions.
 */
extension NTModule {
    public static func moduleName() -> String {
        return NSStringFromClass(self)
    }
    public static func constantsToExport() -> [String: Any]? {
        return nil
    }
}



internal class NTModuleRegistery {
    //NTLOOK: Automate module registration through a build script or any other better way
    static private var _modules: [NTModule.Type] = [NTNode.self,
                                                    NTSpec.self,
                                                    NTInsetSpec.self,
                                                    NTAbsoluteSpec.self,
                                                    NTBackgroundSpec.self,
                                                    NTCenterSpec.self,
                                                    NTOverlaySpec.self,
                                                    NTWrapperSpec.self,
                                                    NTRatioSpec.self,
                                                    NTRelativeSpec.self,
//                                                    NTYogaSpec.self,
                                                    NTStackSpec.self,
                                                    
                                                    NTControlNode.self,
                                                    NTImageNode.self,
                                                    NTTextNode.self,
                                                    NTButtonNode.self,
                                                    
                                                    UIColor.self,
                                                    UIImage.self]
    
    //NTLOOK: Figure out all the default environtment variables related to mobie that should be exported here
    //Bundle and document/library directory read write, filemanager etc
    //NTLOOK: figure out a better way to do this if possible
    static private var _defaultConstants: [String: Any] = ["ScreenBounds": ["size": ["width" : UIScreen.main.bounds.size.width,
                                                                                     "height": UIScreen.main.bounds.size.height],
                                                                            "width": UIScreen.main.bounds.size.width,
                                                                            "height": UIScreen.main.bounds.size.height]]
    
    static private var _defaultScripts: [String] = NTCommons.scripts
    
    internal static func setup(_ context: JSContext) {
        
        // Export default constants
        for (key, object) in _defaultConstants {
            context.setObject(object, forKeyedSubscript: key as NSString)
        }
        
        for script in _defaultScripts {
            context.evaluateScript(script)
        }
        
        // Export modules
        for module in _modules {
            context.setObject(module, forKeyedSubscript: module.moduleName() as NSString)
            //NTLOOK: key for constants is ModuleName+Constants.<constant> right now
            
//            if let consts = module.constantsToExport() {
//                
//                let key = module.moduleName() + "Constants"
//                
//                func export(consts: [String: Any], baseKey: String) {
//                    
//                    context.setObject(key, forKeyedSubscript: baseKey as NSString)
//                    
//                    for (key, value) in consts {
//                        
//                        let subscriptString = (baseKey + "." + key)
//                        context.setObject(value, forKeyedSubscript: subscriptString as NSString)
//                        
//                        if let value = value as? [String: Any] {
//                            export(consts: value, baseKey: subscriptString)
//                        }
//                    }
//                }
//                
//                export(consts: consts, baseKey: module.moduleName() + "Constants")
//            }
            context.setObject(module.constantsToExport(), forKeyedSubscript: (module.moduleName() + "Constants") as NSString)
        }
    }
}

