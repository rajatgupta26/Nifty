//
//  NTControlNode.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 10/07/17.
//
//

import Foundation
import JavaScriptCore
import AsyncDisplayKit



public typealias NTControlEvent = ASControlNodeEvent.RawValue
public let NTControlEventTouchDown = ASControlNodeEvent.touchDown.rawValue
public let NTControlEventTouchDownRepeat = ASControlNodeEvent.touchDownRepeat.rawValue
public let NTControlEventTouchDragInside = ASControlNodeEvent.touchDragInside.rawValue
public let NTControlEventTouchDragOutside = ASControlNodeEvent.touchDragOutside.rawValue
public let NTControlEventTouchUpInside = ASControlNodeEvent.touchUpInside.rawValue
public let NTControlEventTouchUpOutside = ASControlNodeEvent.touchUpOutside.rawValue
public let NTControlEventTouchCancel = ASControlNodeEvent.touchCancel.rawValue
public let NTControlEventValueChanged = ASControlNodeEvent.valueChanged.rawValue
public let NTControlEventPrimaryActionTriggered = ASControlNodeEvent.primaryActionTriggered.rawValue
public let NTControlEventAllEvents = ASControlNodeEvent.allEvents.rawValue

public typealias NTControlState = UIControlState.RawValue
public let NTControlStateNormal = UIControlState.normal.rawValue
public let NTControlStateHighlighted = UIControlState.highlighted.rawValue
public let NTControlStateDisabled = UIControlState.disabled.rawValue
public let NTControlStateSelected = UIControlState.selected.rawValue
public let NTControlStateFocused = UIControlState.focused.rawValue
public let NTControlStateApplication = UIControlState.application.rawValue
public let NTControlStateReserved = UIControlState.reserved.rawValue


public typealias NTControlNodeCallback = @convention(block) (NTControlNode) -> ()



@objc public protocol NTControlNodeExport: JSExport, NTNodeExport {
    
    //MARK: State
    var enabled: Bool {get set}
    var highlighted: Bool {get set}
    var selected: Bool {get set}
    
    //MARK: Tracking Touches
    var tracking: Bool {get}
    var touchInside: Bool {get}
    
    func removeAllActions()
}



@objc public class NTControlNode: NTNode, NTControlNodeExport {
    
    private var _controlNode: ASControlNode? {
        get {
            return self.asNode as? ASControlNode
        }
    }
    
    required public init() {
        super.init()
        self._controlNode?.addTarget(self, action: #selector(_onAllEvents), forControlEvents: .allEvents)
        self._controlNode?.addTarget(self, action: #selector(_onTouchDown), forControlEvents: .touchDown)
        self._controlNode?.addTarget(self, action: #selector(_onTouchDownRepeat), forControlEvents: .touchDownRepeat)
        self._controlNode?.addTarget(self, action: #selector(_onTouchDragInside), forControlEvents: .touchDragInside)
        self._controlNode?.addTarget(self, action: #selector(_onTouchDragOutside), forControlEvents: .touchDragOutside)
        self._controlNode?.addTarget(self, action: #selector(_onTouchUpInside), forControlEvents: .touchUpInside)
        self._controlNode?.addTarget(self, action: #selector(_onTouchUpOutside), forControlEvents: .touchUpOutside)
        self._controlNode?.addTarget(self, action: #selector(_onTouchCancel), forControlEvents: .touchCancel)
        self._controlNode?.addTarget(self, action: #selector(_onValueChanged), forControlEvents: .valueChanged)
        self._controlNode?.addTarget(self, action: #selector(_onPrimaryActionTriggered), forControlEvents: .primaryActionTriggered)
    }
    
    public override func loadNode() -> ASDisplayNode {
        let controlNode = ASControlNode()
        return controlNode
    }

    
    //MARK: State
    public var enabled: Bool {
        get {
            return self._controlNode?.isEnabled ?? false
        }
        set {
            self._controlNode?.isEnabled = newValue
        }
    }
    
    public var highlighted: Bool {
        get {
            return self._controlNode?.isHighlighted ?? false
        }
        set {
            self._controlNode?.isHighlighted = newValue
        }
    }
    
    public var selected: Bool {
        get {
            return self._controlNode?.isSelected ?? false
        }
        set {
            self._controlNode?.isSelected = newValue
        }
    }
    
    
    //MARK: Tracking Touches
    public var tracking: Bool {
        get {
            return self._controlNode?.isTracking ?? false
        }
    }
    
    public var touchInside: Bool {
        get {
            return self._controlNode?.isTracking ?? false
        }
    }
    
    
    //MARK: Actions
    
    @objc public func _onTouchDown() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchDown])
        }
    }
    
    @objc private func _onTouchDownRepeat() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchDownRepeat])
        }
    }

    @objc private func _onTouchDragInside() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchDragInside])
        }
    }

    @objc private func _onTouchDragOutside() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchDragOutside])
        }
    }

    @objc public func _onTouchUpInside() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchUpInside])
        }
    }

    @objc private func _onTouchUpOutside() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchUpOutside])
        }
    }

    @objc private func _onTouchCancel() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventTouchCancel])
        }
    }

    @objc private func _onValueChanged() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventValueChanged])
        }
    }

    @objc private func _onPrimaryActionTriggered() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventPrimaryActionTriggered])
        }
    }
    
    @objc private func _onAllEvents() {
        if let dispatcher = self.ntDispatcher?.value {
            print(dispatcher)
            
            let _ = dispatcher.objectForKeyedSubscript("touchHandler").call(withArguments: [self, NTControlEventAllEvents])
        }
    }
    

    
    public func removeAllActions() {
        self._controlNode?.removeTarget(nil, action: nil, forControlEvents: .allEvents)
    }



    //MARK:-
    //MARK:NTModule
    public override class func moduleName() -> String {
        return NTNodeConsts.Control.name
    }
    
    public override class func constantsToExport() -> [String : Any]? {
        let constants: [String: Any] = [NTNodeConsts.Control.event: [NTNodeConsts.Control.Event.touchDown.rawValue: NTControlEventTouchDown,
                                                                     NTNodeConsts.Control.Event.touchDownRepeat.rawValue: NTControlEventTouchDownRepeat,
                                                                     NTNodeConsts.Control.Event.touchDragInside.rawValue: NTControlEventTouchDragInside,
                                                                     NTNodeConsts.Control.Event.touchDragOutside.rawValue: NTControlEventTouchDragOutside,
                                                                     NTNodeConsts.Control.Event.touchUpInside.rawValue: NTControlEventTouchUpInside,
                                                                     NTNodeConsts.Control.Event.touchUpOutside.rawValue: NTControlEventTouchUpOutside,
                                                                     NTNodeConsts.Control.Event.touchCancel.rawValue: NTControlEventTouchCancel,
                                                                     NTNodeConsts.Control.Event.valueChanged.rawValue: NTControlEventValueChanged,
                                                                     NTNodeConsts.Control.Event.primaryActionTriggered.rawValue: NTControlEventPrimaryActionTriggered,
                                                                     NTNodeConsts.Control.Event.allEvents.rawValue: NTControlEventAllEvents],
                                        
                                        NTNodeConsts.Control.state: [NTNodeConsts.Control.State.normal.rawValue: NTControlStateNormal,
                                                                     NTNodeConsts.Control.State.disabled.rawValue: NTControlStateDisabled,
                                                                     NTNodeConsts.Control.State.highlighted.rawValue: NTControlStateHighlighted,
                                                                     NTNodeConsts.Control.State.selected.rawValue: NTControlStateSelected]]
        
        return constants
    }
}


























