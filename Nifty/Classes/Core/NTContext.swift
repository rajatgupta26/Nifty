//
//  NTContext.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 16/06/17.
//
//

import Foundation
import JavaScriptCore


public protocol NTContextDelegate {
    func uniqueIdentifierFor(_ context: JSContext) -> String
    
    func exceptionHandlerFor(_ context: JSContext) ->  ((JSContext?, JSValue?) -> Swift.Void)!
}


extension NTContextDelegate {
    public func uniqueIdentifierFor(_ context: JSContext) -> String {
        return defaultUID()
    }
    
    public func exceptionHandlerFor(_ context: JSContext) ->  ((JSContext?, JSValue?) -> Swift.Void)! {
        return defaultExceptionHandler()
    }
}


fileprivate func defaultUID() -> String {
    let name = "NTContext - " + String(NTContext._instanceCounter) + " " + Thread.current.debugDescription
    NTContext._instanceCounter += 1
    return name
}


fileprivate func defaultExceptionHandler() ->  ((JSContext?, JSValue?) -> Swift.Void)! {
    return { context, exception in
        print("JS Error: \(exception?.description ?? "unknown error")")
    }
}



public class NTContext: JSContext {
    
    // May be enable this only for debugging
    // NTDEBUG
    static fileprivate var _instanceCounter: UInt = 0
    
    //MARK: initializer
    public var delegate: NTContextDelegate? {
        didSet {
            self._setup()
        }
    }
    
    required public convenience init(withDelegate _delegate: NTContextDelegate!) {
        self.init()
        self.delegate = _delegate
    }
    
    public override init!() {
        
        // initialize default
        super.init()
        
        // Setup context with default registered modules and constants
        NTModuleRegistery.setup(self)
    }
    
    public override init!(virtualMachine: JSVirtualMachine!) {
        
        // initialize default
        super.init(virtualMachine: virtualMachine)
        
        // Setup context with default registered modules and constants
        //NTLOOK: This could be done by the NTExecutor as well. But doing it here makes it possible to use this context directly without executor.
        //This context will be aware of basic nifty modules
        //Not fully convinced about either anyway. So let's revisit this.
        NTModuleRegistery.setup(self)
    }
    
    
    //MARK: private
    private func _setup() {
        
        // Set name of context
        // Useful for debugging
//        NT_EXECUTE(debug: {
//            self.name = self.delegate?.uniqueIdentifierFor(self) ?? defaultUID()
//        }) {}
        
        if NT_DEBUG {
            self.name = self.delegate?.uniqueIdentifierFor(self) ?? defaultUID()
        }
        
        //NTLOOK: Provide a way for the host app to add custom modules to the context via delegate or some other method
        /*
         So right now the approach is that there is a shared context to evaluate scripts unless dev explicitely creates a new context.
         So whenever a new script is given to evalutate, we need to find a way to either accept modules before eval is initialized, or
         use a delegate method where we send the context instance as a param or else we'll have to have some identifier for scripts using
         which delegate method will identify the script for which these extra modules are needed.
         
         OR
         
         Create a new context every time and let the devs just specify the script path to eval.
         */
        
        //NTLOOK: Consider exposing exception handler to host app
        //Provide default exception handler
        self.exceptionHandler = self.delegate?.exceptionHandlerFor(self) ?? defaultExceptionHandler()
    }
    
}





extension NTContext {
    
    public func function(_ functionName: String) -> JSValue? {
        
        if let function = self.objectForKeyedSubscript(functionName) {
            //NTLOOK: may be cache this and other functions or objects
//            if let kindOf = self.globalObject?.objectForKeyedSubscript("is") {
//            
//                if kindOf.call(withArguments: [function]).toString() == NTCommons.Constants.Kinds.function.rawValue {
                    return function
//                }
//            }
        }
        
        return nil
    }
}




extension JSValue {
    
    public func function(_ functionName: String) -> JSValue? {
        
        if let function = self.objectForKeyedSubscript(functionName) {
            //NTLOOK: may be cache this and other functions or objects
//            if let kindOf = JSContext.current().globalObject?.objectForKeyedSubscript("is") {
//                
//                if kindOf.call(withArguments: [function]).toString() == NTCommons.Constants.Kinds.function.rawValue {
                    return function
//                }
//            }
        }
        
        return nil
    }
    
    
    public func function(atIndex index: Int) -> JSValue? {
        
        if let function = self.objectAtIndexedSubscript(index) {
            //NTLOOK: may be cache this and other functions or objects
//            if let kindOf = JSContext.current().globalObject?.objectForKeyedSubscript("is") {
//                
//                if kindOf.call(withArguments: [function]).toString() == NTCommons.Constants.Kinds.function.rawValue {
                    return function
//                }
//            }
        }
        
        return nil
    }
}



















