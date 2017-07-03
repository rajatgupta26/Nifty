//
//  ViewController.swift
//  Nifty
//
//  Created by rajatgupta26 on 06/01/2017.
//  Copyright (c) 2017 rajatgupta26. All rights reserved.
//

import UIKit
import Nifty
import AsyncDisplayKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let node = NTDisplayNode(scriptName: "Alpha")
//        node.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        
        self.view.addSubnode(node)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

