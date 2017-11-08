//
//  MyCellNode.swift
//  Nifty
//
//  Created by Rajat Kumar Gupta on 06/11/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import Nifty

class MyCellNode: ASCellNode {

    public var scriptName: String
    public var moduleName: String?
    public var properties: [AnyHashable: Any]?
    
    private var _ntDisplayNode: NTDisplayNode!
    
    private var _executor: NTExecutor!
    
    public required init(scriptName: String, moduleName: String? = nil, properties: [AnyHashable: Any]? = nil, executor: NTExecutor? = nil) {
        self.scriptName = scriptName
        
        super.init()
        
        self.moduleName = moduleName
        self.properties = properties
        self._executor = executor ?? NTExecutor(withDelegate: self)
        
        let args = self.properties != nil ? [self.properties!] : nil
        
        self._ntDisplayNode = NTDisplayNode(scriptName: scriptName, moduleName: self.moduleName, args: args, executor: self._executor)
        self.addSubnode(self._ntDisplayNode)
    }
    
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: _ntDisplayNode)
    }
}


extension MyCellNode: NTExecutorDelegate {
    
}
