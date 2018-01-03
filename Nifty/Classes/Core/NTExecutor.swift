//
//  NTExecutor.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 20/06/17.
//
//

import Foundation
import JavaScriptCore


public protocol NTExecutorDelegate {
    func sourceURL(forScript scriptName: String, executor: NTExecutor) -> URL?
    func uniqueIdentifier(forContextWith scriptName: String, url: URL, executor: NTExecutor) -> String
    func extraModules(forScript scriptName: String, url: URL, executor: NTExecutor) -> [NTModule.Type]?
    func exceptionHandler(forScript scriptName: String, url: URL, executor: NTExecutor) -> ((JSContext?, JSValue?) -> Swift.Void)?
    func loadScript(forScriptURL scriptURL: URL, executor: NTExecutor) -> String?
}

extension NTExecutorDelegate {
    public func sourceURL(forScript scriptName: String, executor: NTExecutor) -> URL? {
        return defaultURL(scriptName)
    }
    
    public func uniqueIdentifier(forContextWith scriptName: String, url: URL, executor: NTExecutor) -> String {
        return defaultUID(scriptName, url: url)
    }

    public func extraModules(forScript scriptName: String, url: URL, executor: NTExecutor) -> [NTModule.Type]? {
        return nil
    }

    public func exceptionHandler(forScript scriptName: String, url: URL, executor: NTExecutor) -> ((JSContext?, JSValue?) -> Swift.Void)? {
        return nil
    }
    
    public func loadScript(forScriptURL scriptURL: URL, executor: NTExecutor) -> String? {
        return defaultLoad(scriptURL)
    }
}


fileprivate func defaultURL(_ scriptName: String) -> URL? {
    //NTLOOK: Should this extension be hard coded here or should it be flexbile somehow?
    //Though delegate can provide any path with any extension even now
    return Bundle.main.url(forResource: scriptName, withExtension: "js")
}

fileprivate func defaultLoad(_ scriptURL: URL) -> String? {
    do {
        let script = try String(contentsOf: scriptURL, encoding: .utf8)
        return script
    } catch _ {
        return nil
    }
}

fileprivate func defaultUID(_ scriptName: String, url: URL?) -> String {
    let name = "NTContext - " + scriptName + ":" + (url?.absoluteString ?? "") + " " + Thread.current.debugDescription
    return name
}



public class NTExecutor: NTContextDelegate {
    
    /*
     NTLOOK: This set just serves to avoid re evaluating already evaluated scripts in cases where we are just
     calculating values or calling functions of already evaluated scripts.
     If an explicit call is made to evaluate the script with same name, executor will go ahead and re-evaluate
     that script.
     Only when evaluateKey:inScript: is called, will we not re-evaluate the script and just call objectForKey 
     on JSContext.
     So if it benefits to evaluate a script just once and use the same executor to evaluate some function in that
     script, there will be a performance benefit I assume. Although we'll need to evaluate the performance.
     */
    fileprivate var _evaluatedScripts: Set<NTScript>?
    
    //NTLOOK: mutex for concurrency. May be this could be part of commons and every class could use it. Keeping it per instance level right now.
    fileprivate let _mutex: PThreadMutex = PThreadMutex(type: .recursive)

    //NTLOOK: Should there be an option to ues a shared context?
    fileprivate var _context: NTContext!
    
    fileprivate func defaultContext() -> NTContext {
        return NTContext(withDelegate: self)
    }
    
    public var context: NTContext {
        get {
            return self._context
        }
    }
    
    
    public var delegate: NTExecutorDelegate?
    
    
    public required init(withDelegate delegate: NTExecutorDelegate? = nil, context: NTContext? = nil) {
        _context = context ?? defaultContext()
        self.delegate = delegate
    }
}





public enum NTExecutionError: Error {
    case noSourceURL
    case invalidSourceURL
    case failedToLoad
    case invalidScript
    case unknown
}



extension NTExecutor {
    
    public func evaluateScript(_ name: String) throws -> JSValue? {
        //NTLOOK: probably should check here if the script has been already processed.
        //But scripts can return some value on evaluation, should that value be cached or should we recalculate it?
        //since it might depend on some other environment variables and hence result in different output each time
        //Going for the latter right now

        guard let sourceURL = self.delegate?.sourceURL(forScript: name, executor: self) ?? defaultURL(name) else {
            throw NTExecutionError.noSourceURL
        }
        
        //NTLOOK: Perform sanity check on sourceURL here
        
        /*
         NTLOOK:
         May be we can benefit with ReactNative's appraoch here.
         So every script that ReactNative executes, first they load the file data and figure out if the data is valid.
         Then they convert that data into C string and use JSContextRef api to evaluate that.
         One benefit of this is that bundles or scripts can be encypted on file system.
         And devs can implement the loadSourceForBridge: function of bridge and decrypt the data before ReactNative 
         begins to use it.
         */
        
        guard let script = self.delegate?.loadScript(forScriptURL: sourceURL, executor: self) ?? defaultLoad(sourceURL) else {
            throw NTExecutionError.failedToLoad
        }
        
        //NTLOOK: validate script here
        
        //Not providing a default value here since NTContext will add a default exception handler itself
        let exceptionHandler = self.delegate?.exceptionHandler(forScript: name, url: sourceURL, executor: self)
        
        //Set exception handler on context
        if let handler = exceptionHandler {
            _context.exceptionHandler = handler
        }
        
        //NTLOOK: Make sure this is being used right. Get better understanding of this mutex wrapper
        _mutex.fastSync { () -> Void in
            var scriptObj: NTScript
            //Find out if there is already a script with same name and url that has been evaluated by the context
            if let matchingScripts: [NTScript] = _evaluatedScripts?.filter({ (aScript) -> Bool in
                return aScript.name == name && aScript.url == sourceURL
            }), matchingScripts.count > 0  {
                scriptObj = matchingScripts[0]
                scriptObj.setURL(sourceURL)
                scriptObj.setExceptionHandler(exceptionHandler)
                _evaluatedScripts?.remove(matchingScripts[0])
            } else {
                //Craete new script if not found
                scriptObj = NTScript(name: name, scriptURL: sourceURL, exceptionHandler: exceptionHandler)
            }
            
            //Add to evaluated scripts
            _evaluatedScripts?.insert(scriptObj)
        }
        
        
        //Export extra modules to context
        /*
         NTLOOK: In the current approach where we are directly exposing modules to JSContext, unlike ReactNative where
         they do not export the modules direct but export the bridge and collect the meta data of module, this extramodules
         api only makes sense until there is a script or some other automated way for finding out classes conforming to
         NTModule protocol.
         In our approach we are just making the JSContext aware of these types of modules, and JS will create those modules 
         when needed and create there dependencies as well as take care of any other custom initialization.
         Need to explore the react native approach a bit more. Maybe there is something we could benefit from.
         */
        
        if let extraModdules = self.delegate?.extraModules(forScript: name, url: sourceURL, executor: self) {
            for module in extraModdules {
                _context.setObject(module, forKeyedSubscript: module.moduleName() as NSString)
                //NTLOOK: key for constants is ModuleName+Constants.<constant> right now
                _context.setObject(module.constantsToExport(), forKeyedSubscript: (module.moduleName() + "Constants") as NSString)
            }
        }
        
        //Set name of context for debugging purposes
        if NT_DEBUG {
            _context.name = self.delegate?.uniqueIdentifier(forContextWith: name, url: sourceURL, executor: self) ?? _context.name ?? defaultUID(name, url: sourceURL)
        }
        
        
        //Evaluate script
        //NTLOOK: Need to figure out which approach is better to bifurcate debug and release codes. 
        //And how to avoid block passing and environment capture
//
//        let result: JSValue? = NT_EXECUTE(debug: { () -> JSValue? in
//            return _context.evaluateScript(script, withSourceURL: sourceURL)
//        }) { () -> JSValue? in
//            return _context.evaluateScript(script)
//        }
        
        // Using if-else to avoid block capture. Pending evaluation.
        let result: JSValue?
        if NT_DEBUG {
            result = _context.evaluateScript(script, withSourceURL: sourceURL)
        } else {
            result = _context.evaluateScript(script)
        }
        
        return result
    }
    
    
    
    /*
     NTLOOK: Now here is one issue.
     To uniquely identify a script, we are using url and name both.
     Now this api is supposed to check if a given stript has been already evaluated or not.
     If not, first evaluate the script with given name and then evaluate the key.
     But since url is also needed to uniquely identify the script, we'll need that as a
     param as well.
     Ideas: 
     - make it mandatory for scripts to have unique names, thus avoiding the need of url to
     uniquely identify.
     - do not bother in this api if the script has been evaluated at all and make it mandatory 
     to call evaluateScript before calling these methods. Just like JSContext.
     
     Choosing second option for now.
     */
    public func value(forKey key: String/*, inScriptNamed scriptName: String*/) -> JSValue? {
        
//        _mutex.trySync { () -> Void in
//            if _evaluatedScripts?.contains(where: { (aScript) -> Bool in
//                
//            })
//        }
//        
//        if let value = _mutex.trySync(execute: { () -> JSValue? in
//            
//            return nil
//        }) {
//            return value
//        }
        
        return _context.objectForKeyedSubscript(key)
    }
    
    
    
    
    public func call(_ functionName: String, onObject objectName: String? = nil, withArguments arguments: [Any]!) -> JSValue? {
        var result: JSValue? = nil
        
        if let oName = objectName {
            if let value: JSValue? = _context.objectForKeyedSubscript(oName) {
                if let function = value?.function(functionName) {
                    result = function.call(withArguments: arguments)
                }
            }
        } else {
            if let function = _context.function(functionName) {
                result = function.call(withArguments: arguments)
            }
        }
        
        return result
    }
}








































