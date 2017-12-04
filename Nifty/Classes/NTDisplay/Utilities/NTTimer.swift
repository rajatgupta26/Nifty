//
//  NTTimer.swift
//  CwlUtils
//
//  Created by Naveen Chaudhary on 04/12/17.
//

import JavaScriptCore

@objc public protocol NTTimerNodeExports: JSExport {
    static func create() -> NTTimer
    func setupTimerWithInterval(_ interval: TimeInterval, _ repeats: Bool)
    func invalidateTimer()
}

@objc public class NTTimer: NSObject, NTTimerNodeExports, NTDispatcherModuleExports {
    
    required public override init() {
        super.init()
    }
    
    public static func create() -> NTTimer {
        let timer = self.init()
        return timer
    }
    

    internal var timer: Timer?
    
    public func setupTimerWithInterval(_ timeInterval: TimeInterval, _ repeats: Bool) {
        invalidateTimer()
        
        self.timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(self.handleTimer), userInfo: nil, repeats: repeats)
        if let timer = self.timer {
            RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        }
    }
    
    public func invalidateTimer() {
        self.timer?.invalidate()
    }
    
    @objc internal func handleTimer() -> Void {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)

            let _ = dispatcher.objectForKeyedSubscript("timerHandler").call(withArguments: nil)
        }
    }
    
    // Must be set nil in deinit in order to remove managed reference for dispatcher
    public var ntDispatcher: JSManagedValue? {
        
        willSet {
            if newValue == nil {
                if let context = JSContext.current() {
                    let delegate = UIApplication.shared.delegate
                    context.setObject(delegate, forKeyedSubscript: "SharedOwner" as NSString)
                    context.virtualMachine.removeManagedReference(ntDispatcher, withOwner: delegate)
                } else {
                    print("Context not found!")
                }
            }
        }
        
        didSet {
            if ntDispatcher != nil {
                if let context = JSContext.current() {
                    let delegate = UIApplication.shared.delegate
                    context.setObject(delegate, forKeyedSubscript: "SharedOwner" as NSString)
                    context.virtualMachine.addManagedReference(ntDispatcher, withOwner: delegate)
                } else {
                    print("Context not found!")
                }
            }
        }
    }
    
    open func nt_setDispatcher(_ jsObject: JSValue) {
        self.ntDispatcher = JSManagedValue(value: jsObject, andOwner: self)
    }
    
    deinit {
        ntDispatcher = nil
    }
}

extension NTTimer: NTModule {
    //MARK:-
    //MARK:NTModule
    public static func moduleName() -> String {
        return "Timer"
    }
    
    public static func constantsToExport() -> [String : Any]? {
        return nil
    }
}
