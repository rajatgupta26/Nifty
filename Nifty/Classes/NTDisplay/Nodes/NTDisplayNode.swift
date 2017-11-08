//
//  NTDisplayNode.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 03/07/17.
//
//

import UIKit
import AsyncDisplayKit

//Default js renderer name
let kNodeObjectName = "Renderer"
//NTIMP: Name of function in js object for rendering is fixed
let kNodeRenderFunctionName = "render"

public class NTDisplayNode: ASDisplayNode {
    
    private var _scriptName: String
    private var _moduleName: String

    private var _scriptURL: URL? {
        get {
            return _executor.delegate?.sourceURL(forScript: _scriptName, executor: _executor)
        }
    }
    
    private var _arguments: [[AnyHashable: Any]]?

    fileprivate var _ntLayoutElement: NTLayoutElement?
    
    private var _executor: NTExecutor!
    public var executor: NTExecutor {
        get {
            return _executor
        }
    }
    
//    public required init(withExecutor executor:  NTExecutor, scriptName: String, moduleName: String? = nil, initialProperties: [AnyHashable: Any]) {
//
//        super.init()
//
//        _executor = executor
//        _moduleName = moduleName
//    }
    
    public required init(scriptName: String, moduleName: String? = nil, args: [[AnyHashable: Any]]? = nil, executor: NTExecutor? = nil) {
        
        _scriptName = scriptName
        _moduleName = moduleName ?? kNodeObjectName
        
        super.init()
        
        _executor = executor ?? NTExecutor(withDelegate: self)
        _arguments = args
        
        DispatchQueue.global(qos: .userInteractive).async {
            self._ntLayoutElement = self._ntLayoutElementFrom(scriptNamed: self._scriptName, args:self._arguments)
            if let asNode = self._ntLayoutElement?.asLayoutElement as? ASDisplayNode {
                DispatchQueue.main.async {
                    self.addSubnode(asNode)
                }
            }
        }
    }
    
    //NTLOOK: disable default initializers
    
    
    private func _ntLayoutElementFrom(scriptNamed name: String, args:[[AnyHashable: Any]]?) -> NTLayoutElement? {
        
        do {
            
            if let module = _executor.value(forKey: _moduleName), module.isUndefined || module.isNull {
                _ = try _executor.evaluateScript(_scriptName)
            }
            
            //NTLOOK: Probably this can be further fine tuned. call function checks for object for key and type of object etc again.
            //entension on JSValue can also be done.
            if let ntLayoutElement = _executor.call(kNodeRenderFunctionName, onObject: _moduleName, withArguments: args)?.toObject() as? NTLayoutElement {
                return ntLayoutElement
            }
        }
        catch _ as NTExecutionError {
            //NTLOOK: Catch and handle proper exception types here
        }
        catch {
            
        }
        
        return nil
    }
}


extension NTDisplayNode {
    
    public override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if let element = _ntLayoutElement?.asLayoutElement {
//            return ASWrapperLayoutSpec(layoutElement: node)
            return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: element)
        }
        return ASAbsoluteLayoutSpec()
    }
}


extension NTDisplayNode: NTExecutorDelegate {
    // Using default implementations for all delegate methods here
}










//MARK: NTNode convenience
extension NTNode {
    
    open func executor() -> NTExecutor? {
        
        func displayNode() -> NTDisplayNode? {
            var node: ASDisplayNode? = self.asNode
            while !((node == nil) || (node is NTDisplayNode)) {
                node = node?.supernode
            }
            return node as? NTDisplayNode
        }
        
        if let currentDisplayNode = displayNode() {
            return currentDisplayNode.executor
        }
        return nil
    }
}





















