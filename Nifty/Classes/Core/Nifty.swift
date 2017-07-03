//
//  Nifty.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 16/06/17.
//
//

import Foundation
import JavaScriptCore


/*
 !!
 Search 'NTDEBUG' for things that should probably only be enabled in debug mode
 Search 'NTLOOK' for things that may require reconsideration for better alternatives possible
 Search 'NTIMP' for things that are good to know and share
 !!
 */


/*
 NTLOOK: Using a singleton right now. It's possible to make all these shared variables static and avoid singleton.
 Let's come back to this and evaluate the approach.
 One approach could also be that devs just asks to evaluate a script and
 Nifty create a context or maintains a pool and uses one from that to evaluate the script.
 Though devs could also create NTContext objects and use them evaluate scripts.
 */
public class Nifty {
    
    //MARK: Private
    private lazy var _sharedVM: JSVirtualMachine? = JSVirtualMachine()
    private lazy var _sharedContext: NTContext? = NTContext(virtualMachine: self._sharedVM)
    
    //NTLOOK: Spawning a private background thread here
    /* To be used if we decide that shared context will evaluate scripts on this thread
       or if we wanna give control to the host app to decide if they wanna use this thread evaluating some scritps.
       Not being used right now.
     */
    private lazy var _ntThread: Thread = {
        let jsThread: Thread = Thread(target: self, selector: #selector(_runRunLoopThread), object: nil)
        jsThread.name = "com.rajni.example.thread"
        jsThread.qualityOfService = .userInteractive
        jsThread.start()
        return jsThread
    } ()
    
    @objc private func _runRunLoopThread() {
        _ = autoreleasepool {
            
            //copy thread name to pthread
            if let threadName = Thread.current.name {
                pthread_setname_np(threadName)
            }
            
            // add dummy runloop source to avoid spinning
            var noSpinCtx: CFRunLoopSourceContext = CFRunLoopSourceContext(version: 0, info: nil, retain: nil, release: nil, copyDescription: nil, equal: nil, hash: nil, schedule: nil, cancel: nil, perform: nil)
            let noSpinSource: CFRunLoopSource = CFRunLoopSourceCreate(nil, 0, &noSpinCtx)
            CFRunLoopAddSource(CFRunLoopGetCurrent(), noSpinSource, .defaultMode)
            
            // run the run loop
            while (.stopped != CFRunLoopRunInMode(.defaultMode, Date.distantFuture.timeIntervalSinceReferenceDate, false)) {
                assert(false, "not reached assertion")
            }
        }
    }

    
    //MARK: Public
    // Shared instance
    public static let shared = Nifty()
    
    // Shared thread
    public var sharedThread: Thread {
        get {
            return self._ntThread
        }
    }
    
}
