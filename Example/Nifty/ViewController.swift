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

    fileprivate var _commonExecutor: NTExecutor!
    fileprivate var _rowCount: Int = 20
    
    private func _createTable() -> ASTableNode {
        let tableViewNode = ASTableNode()
        tableViewNode.allowsSelection = false
        tableViewNode.shouldAnimateSizeChanges = false
        tableViewNode.view.allowsSelection = false
        tableViewNode.view.separatorStyle = .none
        tableViewNode.view.scrollsToTop = true
        tableViewNode.view.showsHorizontalScrollIndicator = false
        tableViewNode.view.showsVerticalScrollIndicator = false
        tableViewNode.dataSource = self
        tableViewNode.delegate = self
        tableViewNode.leadingScreensForBatching = 2
//        tableViewNode.setTuningParameters(ASRangeTuningParameters.init(leadingBufferScreenfuls: 4, trailingBufferScreenfuls: 3), for: .preload)
//        tableViewNode.setTuningParameters(ASRangeTuningParameters.init(leadingBufferScreenfuls: 2, trailingBufferScreenfuls: 1.5), for: .display)
        return tableViewNode
    }
    
    fileprivate var tableViewNode: ASTableNode!

    fileprivate var _sharedContext: Bool = true
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        
        DispatchQueue.main.async {
            self._rowCount = 0
            self._sharedContext = !self._sharedContext
            
            self._resetTable()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _commonExecutor = NTExecutor(withDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self._resetTable()
    }
    
    fileprivate func _resetTable() {
        
        self._rowCount = 20

        tableViewNode?.removeFromSupernode()
        
        tableViewNode = _createTable()
        tableViewNode.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        tableViewNode.backgroundColor = UIColor.purple
        
        self.view.addSubnode(tableViewNode)
    }
}

extension ViewController: ASTableDataSource, ASTableDelegate {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return _rowCount
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRange(min: CGSize(width: self.view.bounds.width, height: 100), max: CGSize(width: self.view.bounds.width, height: 100))
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = MyCellNode(scriptName: "MyCell", moduleName: nil, properties: nil, executor: self._sharedContext ? self._commonExecutor : nil)
        return cell
    }
    
//    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
//        let nodeBlock: ASCellNodeBlock = { [unowned self] _ in
////            let executor = self?._commonExecutor ?? NTExecutor()
//            print("Common executor - \(self._commonExecutor)")
//            let cell = MyCellNode(scriptName: "MyCell", moduleName: nil, properties: nil, executor: self._sharedContext ? self._commonExecutor : nil)
//            return cell
//        }
//        return nodeBlock
//    }
    
    
    func shouldBatchFetch(for tableNode: ASTableNode) -> Bool {
        return true
    }
    
    func tableNode(_ tableNode: ASTableNode, willBeginBatchFetchWith context: ASBatchContext) {
        
        DispatchQueue.main.async {
            let step = 10
            let section: Int = 0
            var indexPaths: [IndexPath] = []
            
            let newTotalNumberOfPhotos = self._rowCount + step
            
            for index in self._rowCount..<newTotalNumberOfPhotos {
                indexPaths.append(IndexPath(row: index, section: section))
            }
            
            self._rowCount += step
            self.tableViewNode.insertRows(at: indexPaths, with: .none)
            
            context.completeBatchFetching(true)
        }
    }
    
    
}



extension ViewController: NTExecutorDelegate {
    
}


























