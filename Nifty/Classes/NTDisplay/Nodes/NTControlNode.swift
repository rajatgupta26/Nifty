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
    
    //MARK: Actions 
    var onTouchDown: NTControlNodeCallback? {get set}
    var onTouchDownRepeat: NTControlNodeCallback? {get set}
    var onTouchDragInside: NTControlNodeCallback? {get set}
    var onTouchDragOutside: NTControlNodeCallback? {get set}
    var onTouchUpInside: NTControlNodeCallback? {get set}
    var onTouchUpOutside: NTControlNodeCallback? {get set}
    var onTouchCancel: NTControlNodeCallback? {get set}
    var onValueChanged: NTControlNodeCallback? {get set}
    var onPrimaryActionTriggered: NTControlNodeCallback? {get set}
    var onAllEvents: NTControlNodeCallback? {get set}
    
    func removeAllActions()
}



@objc public class NTControlNode: NTNode, NTControlNodeExport {
    
    private var _controlNode: ASControlNode? {
        get {
            return self.asNode as? ASControlNode
        }
    }
    
    public override func loadNode() -> ASDisplayNode {
        return ASControlNode()
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
    
    @objc private func _onTouchDown() {
        if let callback = onTouchDown {
            callback(self)
        }
    }
    
    @objc private func _onTouchDownRepeat() {
        if let callback = onTouchDownRepeat {
            callback(self)
        }
    }

    @objc private func _onTouchDragInside() {
        if let callback = onTouchDragInside {
            callback(self)
        }
    }

    @objc private func _onTouchDragOutside() {
        if let callback = onTouchDragOutside {
            callback(self)
        }
    }

    @objc private func _onTouchUpInside() {
        if let callback = onTouchUpInside {
            callback(self)
        }
    }

    @objc private func _onTouchUpOutside() {
        if let callback = onTouchUpOutside {
            callback(self)
        }
    }

    @objc private func _onTouchCancel() {
        if let callback = onTouchCancel {
            callback(self)
        }
    }

    @objc private func _onValueChanged() {
        if let callback = onValueChanged {
            callback(self)
        }
    }

    @objc private func _onPrimaryActionTriggered() {
        if let callback = onPrimaryActionTriggered {
            callback(self)
        }
    }
    
    @objc private func _onAllEvents() {
        if let callback = onAllEvents {
            callback(self)
        }
    }
    

    
    public var onTouchDown: NTControlNodeCallback? {
        didSet {
            if self.onTouchDown != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchDown), forControlEvents: .touchDown)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchDown), forControlEvents: .touchDown)
            }
        }
    }
    
    public var onTouchDownRepeat: NTControlNodeCallback? {
        didSet {
            if self.onTouchDownRepeat != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchDownRepeat), forControlEvents: .touchDownRepeat)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchDownRepeat), forControlEvents: .touchDownRepeat)
            }
        }
    }
    
    public var onTouchDragInside: NTControlNodeCallback? {
        didSet {
            if self.onTouchDragInside != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchDragInside), forControlEvents: .touchDragInside)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchDragInside), forControlEvents: .touchDragInside)
            }
        }
    }
    
    public var onTouchDragOutside: NTControlNodeCallback? {
        didSet {
            if self.onTouchDragOutside != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchDragOutside), forControlEvents: .touchDragOutside)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchDragOutside), forControlEvents: .touchDragOutside)
            }
        }
    }
    
    public var onTouchUpInside: NTControlNodeCallback? {
        didSet {
            if self.onTouchUpInside != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchUpInside), forControlEvents: .touchUpInside)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchUpInside), forControlEvents: .touchUpInside)
            }
        }
    }
    
    public var onTouchUpOutside: NTControlNodeCallback? {
        didSet {
            if self.onTouchUpOutside != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchUpOutside), forControlEvents: .touchUpOutside)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchUpOutside), forControlEvents: .touchUpOutside)
            }
        }
    }
    
    public var onTouchCancel: NTControlNodeCallback? {
        didSet {
            if self.onTouchCancel != nil {
                self._controlNode?.addTarget(self, action: #selector(_onTouchCancel), forControlEvents: .touchCancel)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onTouchCancel), forControlEvents: .touchCancel)
            }
        }
    }
    
    public var onValueChanged: NTControlNodeCallback? {
        didSet {
            if self.onValueChanged != nil {
                self._controlNode?.addTarget(self, action: #selector(_onValueChanged), forControlEvents: .valueChanged)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onValueChanged), forControlEvents: .valueChanged)
            }
        }
    }
    
    public var onPrimaryActionTriggered: NTControlNodeCallback? {
        didSet {
            if self.onPrimaryActionTriggered != nil {
                self._controlNode?.addTarget(self, action: #selector(_onPrimaryActionTriggered), forControlEvents: .primaryActionTriggered)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onPrimaryActionTriggered), forControlEvents: .primaryActionTriggered)
            }
        }
    }
    
    public var onAllEvents: NTControlNodeCallback? {
        didSet {
            if self.onAllEvents != nil {
                self._controlNode?.addTarget(self, action: #selector(_onAllEvents), forControlEvents: .allEvents)
            } else {
                self._controlNode?.removeTarget(self, action: #selector(_onAllEvents), forControlEvents: .allEvents)
            }
        }
    }
    
    
    public func removeAllActions() {
        self._controlNode?.removeTarget(nil, action: nil, forControlEvents: .allEvents)
    }
}




extension NTControlNode {
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





















