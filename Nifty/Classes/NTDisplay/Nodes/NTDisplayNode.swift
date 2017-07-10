//
//  NTDisplayNode.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 03/07/17.
//
//

import UIKit
import AsyncDisplayKit

let kNodeObjectName = "Renderer"
let kNodeRenderFunctionName = "render"

public class NTDisplayNode: ASDisplayNode {
    
    private var _scriptName: String
    fileprivate var _ntNode: NTNode?
    
    private lazy var _executor: NTExecutor = NTExecutor(withDelegate: self)
    
    public required init(scriptName: String) {
        
        _scriptName = scriptName
        
        super.init()
        
        _ntNode = _ntNodeFrom(scriptNamed: _scriptName)
        if let asNode = _ntNode?.asLayoutElement as? ASDisplayNode {
            self.addSubnode(asNode)
        }
    }
    
    //NTLOOK: disable default initializers
    
    
    private func _ntNodeFrom(scriptNamed name: String) -> NTNode? {
        
        do {
            _ = try _executor.evaluateScript(_scriptName)

            if let ntNode = _executor.call(kNodeRenderFunctionName, onObject: kNodeObjectName, withArguments: nil)?.toObjectOf(NTNode.self) as? NTNode {
                return ntNode
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
        if let node = _ntNode?.asLayoutElement {
            return ASWrapperLayoutSpec(layoutElement: node)
//            return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: node)
        }
        return ASAbsoluteLayoutSpec()
    }
}


extension NTDisplayNode: NTExecutorDelegate {
    // Using default implementations for all delegate methods here
}
