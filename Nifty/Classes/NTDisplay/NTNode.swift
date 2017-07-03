//
//  NTNode.swift
//  Pods
//
//  Created by Rajat Kumar Gupta on 28/06/17.
//
//

//MARK: @Concerns!!
/*
 NOTE: Right shifted once are fixed
 |  -  Find a better way to expose all constants and modules
 |     to JSContext, given that we plan to switch JVMs for
 |     async block invokations from 'Texture'
 |  -  Address memory management concerns. JSValues should
 |     be registered as JSManagedValues with JVM
 |  -  Look at how to store and invoke blocks as well.
 |     Checkout 'onDidLoad'
 -  how can we enable 'automaticallyManagesSubnodes' for
 '_node' ? If this is enabled, we'll need a way to
 listen to node hierarchy changes in order to update
 NTNode hierarchy as well. We'll need to make NTNode
 hierarchy changing methods synchronous as well.
 -  Layout specs?
 */

//MARK: @Not Implemented!!
/*
 public convenience init(viewBlock: @escaping AsyncDisplayKit.ASDisplayNodeViewBlock)
 public convenience init(viewBlock: @escaping AsyncDisplayKit.ASDisplayNodeViewBlock, didLoad didLoadBlock: AsyncDisplayKit.ASDisplayNodeDidLoadBlock? = nil)
 public convenience init(layerBlock: @escaping AsyncDisplayKit.ASDisplayNodeLayerBlock)
 public convenience init(layerBlock: @escaping AsyncDisplayKit.ASDisplayNodeLayerBlock, didLoad didLoadBlock: AsyncDisplayKit.ASDisplayNodeDidLoadBlock? = nil)
 open func setViewBlock(_ viewBlock: @escaping AsyncDisplayKit.ASDisplayNodeViewBlock)
 open func setLayerBlock(_ layerBlock: @escaping AsyncDisplayKit.ASDisplayNodeLayerBlock)
 open var view: UIView { get }
 open var layer: CALayer { get }
 open class var nonFatalErrorBlock: AsyncDisplayKit.ASDisplayNodeNonFatalErrorBlock
 open func layoutThatFits(_ constrainedSize: ASSizeRange) -> ASLayout
 
 open var transform: CATransform3D // default=CATransform3DIdentity
 open var subnodeTransform: CATransform3D // default=CATransform3DIdentity
 
 open func tintColorDidChange() // Notifies the node when the tintColor has changed.
 
 
 unowned(unsafe) open var shadowColor: CGColor? // default=opaque rgb black
 
 open var shadowOpacity: Double // default=0.0
 
 open var shadowOffset: CGSize // default=(0, -3)
 
 open var shadowRadius: Double // default=3
 
 open var borderWidth: Double // default=0
 
 unowned(unsafe) open var borderColor: CGColor? // default=opaque rgb black
 
 open func canBecomeFirstResponder() -> Bool // default==NO
 
 open func becomeFirstResponder() -> Bool // default==NO (no-op)
 
 open func canResignFirstResponder() -> Bool // default==YES
 
 open func resignFirstResponder() -> Bool // default==NO (no-op)
 
 open func isFirstResponder() -> Bool
 
 open func canPerformAction(_ action: Selector, withSender sender: Any) -> Bool
 
 
 
 
 //Focus Engine
 
 extension ASDisplayNode {
 
 
 // Accessibility support
 open var isAccessibilityElement: Bool
 
 open var accessibilityLabel: String?
 
 open var accessibilityHint: String?
 
 open var accessibilityValue: String?
 
 open var accessibilityTraits: UIAccessibilityTraits
 
 open var accessibilityFrame: CGRect
 
 @NSCopying open var accessibilityPath: UIBezierPath?
 
 open var accessibilityActivationPoint: CGPoint
 
 open var accessibilityLanguage: String?
 
 open var accessibilityElementsHidden: Bool
 
 open var accessibilityViewIsModal: Bool
 
 open var shouldGroupAccessibilityChildren: Bool
 
 open var accessibilityNavigationStyle: UIAccessibilityNavigationStyle
 
 
 // Accessibility identification support
 open var accessibilityIdentifier: String?
 }
 
 open var defaultLayoutTransitionDuration: TimeInterval
 open var defaultLayoutTransitionDelay: TimeInterval
 open var defaultLayoutTransitionOptions: UIViewAnimationOptions
 open func animateLayoutTransition(_ context: ASContextTransitioning)
 open func didCompleteLayoutTransition(_ context: ASContextTransitioning)
 open func transitionLayout(with constrainedSize: ASSizeRange, animated: Bool, shouldMeasureAsync: Bool, measurementCompletion completion: (() -> Swift.Void)? = nil)
 open func transitionLayout(withAnimation animated: Bool, shouldMeasureAsync: Bool, measurementCompletion completion: (() -> Swift.Void)? = nil)
 open func cancelLayoutTransition()
 */


import UIKit
import AsyncDisplayKit
import JavaScriptCore
import CwlUtils





public typealias NTNodeDidLoadBlock = (NTNode) -> ()





@objc public protocol NTNodeExport: JSExport {
    
    func displayNodeRecursiveDescription() -> String
    
    static func createWithIdentifier(_ identifier: String) -> NTNode
    static func create() -> NTNode
    
    //NTLOOK: not using constrained size range right now. Need to solve for this.
    var layoutSpec: NTLayoutElement? { get set }
    
    var identifier: String { get }
    
    var onDidLoad: NTNodeDidLoadBlock! { get set }
    
    var isSynchronous: Bool { get }
    var isNodeLoaded: Bool { get }
    var isLayerBacked: Bool { get set }
    var isVisible: Bool { get }
    var isInPreloadState: Bool { get }
    var isInDisplayState: Bool { get }
    var interfaceState: UInt { get }
    var calculatedSize: CGSize { get }
    var constrainedSizeForCalculatedLayout: [String: [String: Double]] { get }
    
    func addSubnode(_ subnode: NTNode)
    func insertSubnodeBelowSubnode(_ subnode: NTNode, _ below: NTNode)
    func insertSubnodeAboveSubnode(_ subnode: NTNode, _ above: NTNode)
    func insertSubnodeAt(_ subnode: NTNode, _ idx: Int)
    func replaceSubnodeWithnode(_ subnode: NTNode, _ replacementSubnode: NTNode)
    func removeFromSupernode()
    var subnodes: [NTNode]? { get }
    weak var supernode: NTNode? { get }
    
    var displaysAsynchronously: Bool { get set }
    var displaySuspended: Bool { get set }
    var shouldAnimateSizeChanges: Bool { get set }
    func recursivelySetDisplaySuspended(_ flag: Bool)
    func recursivelyClearContents()
    var placeholderEnabled: Bool { get set }
    var placeholderFadeDuration: Double { get set }
    var drawingPriority: Int { get set }
    var hitTestSlop: [String: Double] {get set}
    func pointIsInside(_ point: CGPoint) -> Bool
    
    func convertPointToNode(_ point: CGPoint, _ node: NTNode?) -> CGPoint
    func convertPointFromNode(_ point: CGPoint, _ node: NTNode?) -> CGPoint
    func convertRectToNode(_ rect: CGRect, _ node: NTNode?) -> CGRect
    func convertRectFromNode(_ rect: CGRect, _ node: NTNode?) -> CGRect
    var supportsLayerBacking: Bool { get }
    
    
    var clipsToBounds: Bool { get set }// default==NO {
    var isOpaque: Bool { get set }// default==YES
    var allowsGroupOpacity: Bool { get set }
    var allowsEdgeAntialiasing: Bool { get set }
    var edgeAntialiasingMask: UInt32 { get set }// default==all values from CAEdgeAntialiasingMask
    var isHidden: Bool { get set }// default==NO
    var needsDisplayOnBoundsChange: Bool { get set }// default==NO
    var autoresizesSubviews: Bool { get set }// default==YES (undefined for layer-backed nodes)
    var alpha: Double { get set }// default=1.0f
    var bounds: CGRect { get set }// default=CGRectZero
    var frame: CGRect { get set }// default=CGRectZero
    var anchorPoint: CGPoint { get set }// default={0.5, 0.5}
    var zPosition: Double { get set }// default=0.0
    var position: CGPoint { get set }// default=CGPointZero
    var cornerRadius: Double { get set }// default=0.0
    var contentsScale: Double { get set }// default=1.0f. See @contentsScaleForDisplay for more info
    
    var autoresizingMask: UInt { get set }// default==UIViewAutoresizingNone  (undefined for layer-backed nodes)
    var backgroundColor: String? { get set }// default=nil
    var tintColor: String! { get set }// default=Blue
    
    var contentMode: Int { get set }// default=UIViewContentModeScaleToFill
}




@objc public class NTNode: NSObject, NTNodeExport {
    
    fileprivate var _asNode: ASDisplayNode!
    
    fileprivate lazy var _subNodes: [NTNode] = []
    
    public var layoutSpec: NTLayoutElement?
    
    public var asNode: ASDisplayNode {
        get {
            return self._asNode
        }
    }
    
    fileprivate weak var _supernode: NTNode?
    
    private var _identifier: String = ""
    
    public var identifier: String {
        get {
            return self._identifier
        }
    }
    
    
    fileprivate let _mutex: PThreadMutex = PThreadMutex(type: .recursive)

    
    //MARK: Initializer
    required public convenience init(withIdentifier id: String) {
        self.init()
        _identifier = id
    }
    
    required public override init() {
        super.init()
        _asNode = self.loadNode()
        self._setup()
    }
    
    

    //Load appropriate async display node
    open func loadNode() -> ASDisplayNode {
        return ASDisplayNode()
    }
    
    public func _setup() {
        self._asNode.automaticallyManagesSubnodes = true
        //NTLOOK: Implement this
        self._asNode.layoutSpecBlock = { node, constrainedSize in
            if let spec = self.layoutSpec?.asLayoutElement as? ASLayoutSpec {
                return spec
            }
            return ASAbsoluteLayoutSpec()
        }
    }
    
    
    
    //MARK: NTNodeExport
    
    public static func createWithIdentifier(_ identifier: String) -> NTNode {
        let node = NTNode(withIdentifier: identifier)
        return node
    }
    
    public static func create() -> NTNode {
        let node = NTNode()
        return node
    }
    
    public var onDidLoad: NTNodeDidLoadBlock! {
        didSet {
            if let didLoad = self.onDidLoad {
                self._asNode.onDidLoad({ [weak self] _ in
                    if let strongSelf = self {
                        didLoad(strongSelf)
                    }
                })
            } else {
                //NTLOOK: This is fishy
                self._asNode.onDidLoad({ (_) in
                })
            }
        }
    }
    
    
}




extension NTNode {
    
    /**
     * @abstract Return the constrained size range used for calculating layout.
     *
     * @return The minimum and maximum constrained sizes used by calculateLayoutThatFits:.
     */
    open var constrainedSizeForCalculatedLayout: [String: [String: Double]] {
        get {
            return NTConverter.sizeRangeToMap(self._asNode.constrainedSizeForCalculatedLayout)
        }
    }
    
    
    /** @name Managing the nodes hierarchy */
    
    private func _removeSubnode(subnode: NTNode) {
        if let index = self._subNodes.index(of: subnode) {
            self._subNodes.remove(at: index)
            subnode._supernode = nil
        }
    }
    
    private func _insertSubnode(_ subnode: NTNode, at index: Int, removeSubnode subnodeToRemove: NTNode!) {
        
        if subnode != self {
            _mutex.trySync { () -> Void in
                if index <= self._subNodes.count {
                    subnode._supernode = self
                    if index == self._subNodes.count {
                        self._subNodes.append(subnode)
                    } else {
                        self._subNodes.insert(subnode, at: index)
                    }
                }
            }
        }
        
        if let subnodeToRemove = subnodeToRemove {
            _mutex.trySync { () -> Void in
                if subnodeToRemove._supernode == self {
                    self._removeSubnode(subnode: subnodeToRemove)
                }
            }
        }
    }
    
    /**
     * @abstract Add a node as a subnode to this node.
     *
     * @param subnode The node to be added.
     *
     * @discussion The subnode's view will automatically be added to this node's view, lazily if the views are not created
     * yet.
     */
    open func addSubnode(_ subnode: NTNode) {
        var count: Int = 0
        
        _mutex.trySync { () -> Void in
            count = self._subNodes.count
        }
        
        self._insertSubnode(subnode, at: count, removeSubnode: nil)
        self._asNode.addSubnode(subnode._asNode)
    }
    
    
    /**
     * @abstract Insert a subnode before a given subnode in the list.
     *
     * @param subnode The node to insert below another node.
     * @param below The sibling node that will be above the inserted node.
     *
     * @discussion If the views are loaded, the subnode's view will be inserted below the given node's view in the hierarchy
     * even if there are other non-displaynode views.
     */
    open func insertSubnodeBelowSubnode(_ subnode: NTNode, _ below: NTNode) {
        
        var index: Int?
        
        _mutex.trySync { () -> Void in
            index = self._subNodes.index(of: below)
        }
        
        if let index = index {
            self._insertSubnode(subnode, at: index, removeSubnode: nil)
            self._asNode.insertSubnode(subnode._asNode, belowSubnode: below._asNode)
        }
    }
    
    
    /**
     * @abstract Insert a subnode after a given subnode in the list.
     *
     * @param subnode The node to insert below another node.
     * @param above The sibling node that will be behind the inserted node.
     *
     * @discussion If the views are loaded, the subnode's view will be inserted above the given node's view in the hierarchy
     * even if there are other non-displaynode views.
     */
    open func insertSubnodeAboveSubnode(_ subnode: NTNode, _ above: NTNode) {
        
        var index: Int?
        
        _mutex.trySync { () -> Void in
            index = self._subNodes.index(of: above)
        }
        
        if let index = index {
            let actualIndex = index + 1
            self._insertSubnode(subnode, at: actualIndex, removeSubnode: nil)
            self._asNode.insertSubnode(subnode._asNode, aboveSubnode: above._asNode)
        }
    }
    
    
    /**
     * @abstract Insert a subnode at a given index in subnodes.
     *
     * @param subnode The node to insert.
     * @param idx The index in the array of the subnodes property at which to insert the node. Subnodes indices start at 0
     * and cannot be greater than the number of subnodes.
     *
     * @discussion If this node's view is loaded, ASDisplaynode insert the subnode's view after the subnode at index - 1's
     * view even if there are other non-displaynode views.
     */
    open func insertSubnodeAt(_ subnode: NTNode, _ idx: Int) {
        self._insertSubnode(subnode, at: idx, removeSubnode: nil)
        self._asNode.insertSubnode(subnode._asNode, at: idx)
    }
    
    
    /**
     * @abstract Replace subnode with replacementSubnode.
     *
     * @param subnode A subnode of self.
     * @param replacementSubnode A node with which to replace subnode.
     *
     * @discussion Should both subnode and replacementSubnode already be subnodes of self, subnode is removed and
     * replacementSubnode inserted in its place.
     * If subnode is not a subnode of self, this method will throw an exception.
     * If replacementSubnode is nil, this method will throw an exception
     */
    open func replaceSubnodeWithnode(_ subnode: NTNode, _ replacementSubnode: NTNode) {
        
        var index: Int?
        
        _mutex.trySync { () -> Void in
            index = self._subNodes.index(of: subnode)
        }
        
        if let index = index {
            self._insertSubnode(subnode, at: index, removeSubnode: replacementSubnode)
            self._asNode.replaceSubnode(subnode._asNode, withSubnode: replacementSubnode._asNode)
        }
    }
    
    
    /**
     * @abstract Remove this node from its supernode.
     *
     * @discussion The node's view will be automatically removed from the supernode's view.
     */
    open func removeFromSupernode() {
        _mutex.trySync { () -> Void in
            if let supernode = self._supernode {
                supernode._removeSubnode(subnode: self)
            }
        }
        self._asNode.removeFromSupernode()
    }
}




extension NTNode {
    /**
     * @abstract Returns whether the node is synchronous.
     *
     * @return NO if the node wraps a _ASDisplayView, YES otherwise.
     */
    open var isSynchronous: Bool {
        get {
            return self._asNode.isSynchronous
        }
    }
    
    
    /**
     * @abstract Returns whether a node's backing view or layer is loaded.
     *
     * @return YES if a view is loaded, or if layerBacked is YES and layer is not nil; NO otherwise.
     */
    open var isNodeLoaded: Bool {
        get {
            return self._asNode.isNodeLoaded
        }
    }
    
    
    /**
     * @abstract Returns whether the node rely on a layer instead of a view.
     *
     * @return YES if the node rely on a layer, NO otherwise.
     */
    open var isLayerBacked: Bool {
        get {
            return self._asNode.isLayerBacked
        }
        set {
            self._asNode.isLayerBacked = newValue
        }
    }
    
    
    /**
     * Returns YES if the node is – at least partially – visible in a window.
     *
     * @see didEnterVisibleState and didExitVisibleState
     */
    open var isVisible: Bool {
        get {
            return self._asNode.isVisible
        }
    }
    
    
    /**
     * Returns YES if the node is in the preloading interface state.
     *
     * @see didEnterPreloadState and didExitPreloadState
     */
    open var isInPreloadState: Bool {
        get {
            return self._asNode.isInPreloadState
        }
    }
    
    
    /**
     * Returns YES if the node is in the displaying interface state.
     *
     * @see didEnterDisplayState and didExitDisplayState
     */
    open var isInDisplayState: Bool {
        get {
            return self._asNode.isInDisplayState
        }
    }
    
    
    /**
     * @abstract Returns the Interface State of the node.
     *
     * @return The current ASInterfaceState of the node, indicating whether it is visible and other situational properties.
     *
     * @see ASInterfaceState
     */
    open var interfaceState: UInt {
        get {
            return self._asNode.interfaceState.rawValue
        }
    }
    
    
    /**
     * @abstract Return the calculated size.
     *
     * @discussion Ideal for use by subclasses in -layout, having already prompted their subnodes to calculate their size by
     * calling -measure: on them in -calculateLayoutThatFits.
     *
     * @return Size already calculated by -calculateLayoutThatFits:.
     *
     * @warning Subclasses must not override this; it returns the last cached measurement and is never expensive.
     */
    open var calculatedSize: CGSize {
        get {
            return self._asNode.calculatedSize
        }
    }
    
    
    /**
     * @abstract The receiver's immediate subnodes.
     */
    open var subnodes: [NTNode]? {
        get {
            return self._subNodes        }
    }
    
    
    /**
     * @abstract The receiver's supernode.
     */
    weak open var supernode: NTNode? {
        get {
            return self._supernode
        }
    }
    
    
    /** @name Drawing and Updating the View */
    
    /**
     * @abstract Whether this node's view performs asynchronous rendering.
     *
     * @return Defaults to YES, except for synchronous views (ie, those created with -initWithViewBlock: /
     * -initWithLayerBlock:), which are always NO.
     *
     * @discussion If this flag is set, then the node will participate in the current asyncdisplaykit_async_transaction and
     * do its rendering on the displayQueue instead of the main thread.
     *
     * Asynchronous rendering proceeds as follows:
     *
     * When the view is initially added to the hierarchy, it has -needsDisplay true.
     * After layout, Core Animation will call -display on the _ASDisplayLayer
     * -display enqueues a rendering operation on the displayQueue
     * When the render block executes, it calls the delegate display method (-drawRect:... or -display)
     * The delegate provides contents via this method and an operation is added to the asyncdisplaykit_async_transaction
     * Once all rendering is complete for the current asyncdisplaykit_async_transaction,
     * the completion for the block sets the contents on all of the layers in the same frame
     *
     * If asynchronous rendering is disabled:
     *
     * When the view is initially added to the hierarchy, it has -needsDisplay true.
     * After layout, Core Animation will call -display on the _ASDisplayLayer
     * -display calls  delegate display method (-drawRect:... or -display) immediately
     * -display sets the layer contents immediately with the result
     *
     * Note: this has nothing to do with -[CALayer drawsAsynchronously].
     */
    open var displaysAsynchronously: Bool {
        get {
            return self._asNode.displaysAsynchronously
        }
        set {
            self._asNode.displaysAsynchronously = newValue
        }
    }
    
    
    /**
     * @abstract Prevent the node's layer from displaying.
     *
     * @discussion A subclass may check this flag during -display or -drawInContext: to cancel a display that is already in
     * progress.
     *
     * Defaults to NO. Does not control display for any child or descendant nodes; for that, use
     * -recursivelySetDisplaySuspended:.
     *
     * If a setNeedsDisplay occurs while displaySuspended is YES, and displaySuspended is set to NO, then the
     * layer will be automatically displayed.
     */
    open var displaySuspended: Bool {
        get {
            return self._asNode.displaySuspended
        }
        set {
            self._asNode.displaySuspended = newValue
        }
    }
    
    
    /**
     * @abstract Whether size changes should be animated. Default to YES.
     */
    open var shouldAnimateSizeChanges: Bool {
        get {
            return self._asNode.shouldAnimateSizeChanges
        }
        set {
            self._asNode.shouldAnimateSizeChanges = newValue
        }
    }
    
    
    /**
     * @abstract Prevent the node and its descendants' layer from displaying.
     *
     * @param flag YES if display should be prevented or cancelled; NO otherwise.
     *
     * @see displaySuspended
     */
    open func recursivelySetDisplaySuspended(_ flag: Bool) {
        self._asNode.recursivelySetDisplaySuspended(flag)
    }
    
    
    /**
     * @abstract Calls -clearContents on the receiver and its subnode hierarchy.
     *
     * @discussion Clears backing stores and other memory-intensive intermediates.
     * If the node is removed from a visible hierarchy and then re-added, it will automatically trigger a new asynchronous display,
     * as long as displaySuspended is not set.
     * If the node remains in the hierarchy throughout, -setNeedsDisplay is required to trigger a new asynchronous display.
     *
     * @see displaySuspended and setNeedsDisplay
     */
    open func recursivelyClearContents() {
        self._asNode.recursivelyClearContents()
    }
    
    
    /**
     * @abstract Toggle displaying a placeholder over the node that covers content until the node and all subnodes are
     * displayed.
     *
     * @discussion Defaults to NO.
     */
    open var placeholderEnabled: Bool {
        get {
            return self._asNode.placeholderEnabled
        }
        set {
            self._asNode.placeholderEnabled = newValue
        }
    }
    
    /**
     * @abstract Set the time it takes to fade out the placeholder when a node's contents are finished displaying.
     *
     * @discussion Defaults to 0 seconds.
     */
    open var placeholderFadeDuration: Double {
        get {
            return self._asNode.placeholderFadeDuration
        }
        set {
            self._asNode.placeholderFadeDuration = newValue
        }
    }
    
    
    /**
     * @abstract Determines drawing priority of the node. Nodes with higher priority will be drawn earlier.
     *
     * @discussion Defaults to ASDefaultDrawingPriority. There may be multiple drawing threads, and some of them may
     * decide to perform operations in queued order (regardless of drawingPriority)
     */
    open var drawingPriority: Int {
        get {
            return self._asNode.drawingPriority
        }
        set {
            self._asNode.drawingPriority = newValue
        }
    }
    
    
    /** @name Hit Testing */
    
    /**
     * @abstract Bounds insets for hit testing.
     *
     * @discussion When set to a non-zero inset, increases the bounds for hit testing to make it easier to tap or perform
     * gestures on this node.  Default is UIEdgeInsetsZero.
     *
     * This affects the default implementation of -hitTest and -pointInside, so subclasses should call super if you override
     * it and want hitTestSlop applied.
     */
    open var hitTestSlop: [String: Double] {
        get {
            return NTConverter.edgeInsetsToMap(self._asNode.hitTestSlop)
        }
        set {
            self._asNode.hitTestSlop = NTConverter.mapToEdgeInsets(newValue)
        }
    }
    
    
    /**
     * @abstract Returns a Boolean value indicating whether the receiver contains the specified point.
     *
     * @discussion Includes the "slop" factor specified with hitTestSlop.
     *
     * @param point A point that is in the receiver's local coordinate system (bounds).
     * @param event The event that warranted a call to this method.
     *
     * @return YES if point is inside the receiver's bounds; otherwise, NO.
     */
    open func pointIsInside(_ point: CGPoint) -> Bool {
        return self._asNode.point(inside: point, with: nil)
    }
    
    
    /** @name Converting Between View Coordinate Systems */
    
    /**
     * @abstract Converts a point from the receiver's coordinate system to that of the specified node.
     *
     * @param point A point specified in the local coordinate system (bounds) of the receiver.
     * @param node The node into whose coordinate system point is to be converted.
     *
     * @return The point converted to the coordinate system of node.
     */
    open func convertPointToNode(_ point: CGPoint, _ node: NTNode?) -> CGPoint {
        return self._asNode.convert(point, to: node?._asNode)
    }
    
    
    /**
     * @abstract Converts a point from the coordinate system of a given node to that of the receiver.
     *
     * @param point A point specified in the local coordinate system (bounds) of node.
     * @param node The node with point in its coordinate system.
     *
     * @return The point converted to the local coordinate system (bounds) of the receiver.
     */
    open func convertPointFromNode(_ point: CGPoint, _ node: NTNode?) -> CGPoint {
        return self._asNode.convert(point, from: node?._asNode)
    }
    
    
    /**
     * @abstract Converts a rectangle from the receiver's coordinate system to that of another view.
     *
     * @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
     * @param node The node that is the target of the conversion operation.
     *
     * @return The converted rectangle.
     */
    open func convertRectToNode(_ rect: CGRect, _ node: NTNode?) -> CGRect {
        return self._asNode.convert(rect, to: node?._asNode)
    }
    
    
    /**
     * @abstract Converts a rectangle from the coordinate system of another node to that of the receiver.
     *
     * @param rect A rectangle specified in the local coordinate system (bounds) of node.
     * @param node The node with rect in its coordinate system.
     *
     * @return The converted rectangle.
     */
    open func convertRectFromNode(_ rect: CGRect, _ node: NTNode?) -> CGRect {
        return self._asNode.convert(rect, from: node?._asNode)
    }
    
    
    /**
     * Whether or not the node would support having .layerBacked = YES.
     */
    open var supportsLayerBacking: Bool {
        get {
            return self._asNode.supportsLayerBacking
        }
    }
    
    
    
    /**
     * Marks the view as needing display. Convenience for use whether the view / layer is loaded or not. Safe to call from a background thread.
     */
    open func setNeedsDisplay() {
        self._asNode.setNeedsDisplay()
    }
    
    
    /**
     * Marks the node as needing layout. Convenience for use whether the view / layer is loaded or not. Safe to call from a background thread.
     *
     * If the node determines its own desired layout size will change in the next layout pass, it will propagate this
     * information up the tree so its parents can have a chance to consider and apply if necessary the new size onto the node.
     *
     * Note: ASCellNode has special behavior in that calling this method will automatically notify
     * the containing ASTableView / ASCollectionView that the cell should be resized, if necessary.
     */
    open func setNeedsLayout() {
        self._asNode.setNeedsLayout()
    }
    
    
    /**
     * Performs a layout pass on the node. Convenience for use whether the view / layer is loaded or not. Safe to call from a background thread.
     */
    open func layoutIfNeeded() {
        self._asNode.layoutIfNeeded()
    }
    
    
    open var clipsToBounds: Bool // default==NO {
        {
        get {
            return self._asNode.clipsToBounds
        }
        set {
            self._asNode.clipsToBounds = newValue
        }
    }
    
    open var isOpaque: Bool // default==YES
        {
        get {
            return self._asNode.isOpaque
        }
        set {
            self._asNode.isOpaque = newValue
        }
    }
    
    
    open var allowsGroupOpacity: Bool
        {
        get {
            return self._asNode.allowsGroupOpacity
        }
        set {
            self._asNode.allowsGroupOpacity = newValue
        }
    }
    
    open var allowsEdgeAntialiasing: Bool
        {
        get {
            return self._asNode.allowsEdgeAntialiasing
        }
        set {
            self._asNode.allowsEdgeAntialiasing = newValue
        }
    }
    
    open var edgeAntialiasingMask: UInt32 // default==all values from CAEdgeAntialiasingMask
        {
        get {
            return self._asNode.edgeAntialiasingMask
        }
        set {
            self._asNode.edgeAntialiasingMask = newValue
        }
    }
    
    
    open var isHidden: Bool // default==NO
        {
        get {
            return self._asNode.isHidden
        }
        set {
            self._asNode.isHidden = newValue
        }
    }
    
    open var needsDisplayOnBoundsChange: Bool // default==NO
        {
        get {
            return self._asNode.needsDisplayOnBoundsChange
        }
        set {
            self._asNode.needsDisplayOnBoundsChange = newValue
        }
    }
    
    open var autoresizesSubviews: Bool // default==YES (undefined for layer-backed nodes)
        {
        get {
            return self._asNode.autoresizesSubviews
        }
        set {
            self._asNode.autoresizesSubviews = newValue
        }
    }
    
    
    open var alpha: Double // default=1.0f
        {
        get {
            return Double(self._asNode.alpha)
        }
        set {
            self._asNode.alpha = CGFloat(newValue)
        }
    }
    
    open var bounds: CGRect // default=CGRectZero
        {
        get {
            return self._asNode.bounds
        }
        set {
            self._asNode.bounds = newValue
        }
    }
    
    open var frame: CGRect // default=CGRectZero
        {
        get {
            return self._asNode.frame
        }
        set {
            self._asNode.frame = newValue
        }
    }
    
    open var anchorPoint: CGPoint // default={0.5, 0.5}
        {
        get {
            return self._asNode.anchorPoint
        }
        set {
            self._asNode.anchorPoint = newValue
        }
    }
    
    open var zPosition: Double // default=0.0
        {
        get {
            return Double(self._asNode.zPosition)
        }
        set {
            self._asNode.zPosition = CGFloat(newValue)
        }
    }
    
    open var position: CGPoint // default=CGPointZero
        {
        get {
            return self._asNode.position
        }
        set {
            self._asNode.position = newValue
        }
    }
    
    open var cornerRadius: Double // default=0.0
        {
        get {
            return Double(self._asNode.cornerRadius)
        }
        set {
            self._asNode.cornerRadius = CGFloat(newValue)
        }
    }
    
    open var contentsScale: Double // default=1.0f. See @contentsScaleForDisplay for more info
        {
        get {
            return Double(self._asNode.contentsScale)
        }
        set {
            self._asNode.contentsScale = CGFloat(newValue)
        }
    }
    
    
    open var autoresizingMask: UInt // default==UIViewAutoresizingNone  (undefined for layer-backed nodes)
        {
        get {
            return self._asNode.autoresizingMask.rawValue
        }
        set {
            self._asNode.autoresizingMask = UIViewAutoresizing(rawValue: newValue)
        }
    }
    
    
    
    /**
     * @abstract The node view's background color.
     *
     * @discussion In contrast to UIView, setting a transparent color will not set opaque = NO.
     * This only affects nodes that implement +drawRect like ASTextNode.
     */
    open var backgroundColor: String? // default=nil
        {
        get {
            return self._asNode.backgroundColor?.toHexString
        }
        set {
            if let hex = newValue {
                self._asNode.backgroundColor = UIColor(hex: hex)
            } else {
                self._asNode.backgroundColor = nil
            }
        }
    }
    
    open var tintColor: String! // default=Blue
        {
        get {
            return self._asNode.tintColor?.toHexString
        }
        set {
            if let hex = newValue {
                self._asNode.tintColor = UIColor(hex: hex)
            } else {
                self._asNode.tintColor = nil
            }
        }
    }
    
    open var contentMode: Int // default=UIViewContentModeScaleToFill
        {
        get {
            return self._asNode.contentMode.rawValue
        }
        set {
            if let mode = UIViewContentMode(rawValue: newValue) {
                self._asNode.contentMode = mode
            }
        }
    }
    
    
    open var isUserInteractionEnabled: Bool // default=YES (NO for layer-backed nodes)
        {
        get {
            return self._asNode.isUserInteractionEnabled
        }
        set {
            self._asNode.isUserInteractionEnabled = newValue
        }
    }
    
    
    open var isExclusiveTouch: Bool // default=NO
        {
        get {
            return self._asNode.isExclusiveTouch
        }
        set {
            self._asNode.isExclusiveTouch = newValue
        }
    }
    
    
    public func displayNodeRecursiveDescription() -> String {
        return self._asNode.displayNodeRecursiveDescription()
    }
}






extension NTNode: NTLayoutElement {
    
    public var layoutElementType: NTLayoutElementType {
        get {
            return .node
        }
    }
    
    public var sublayoutElements: [NTLayoutElement]? {
        get {
            return self.subnodes
        }
    }
    
    public var asLayoutElement: ASLayoutElement? {
        get {
            return _asNode
        }
    }
}







































extension NTNode: NTModule {
    
    public class func moduleName() -> String {
        return "Node"
    }
    
    public class func constantsToExport() -> [String : Any]? {
        let constantMap = ["RJInterfaceState": ["none": ASInterfaceState.measureLayout.rawValue,
                                                "preload": ASInterfaceState.preload.rawValue,
                                                "display": ASInterfaceState.display.rawValue,
                                                "visible": ASInterfaceState.visible.rawValue,
                                                "inHierarchy": ASInterfaceState.inHierarchy.rawValue],
                           "RJAutoResizing": ["flexibleLeft": UIViewAutoresizing.flexibleLeftMargin.rawValue,
                                              "flexibleRight": UIViewAutoresizing.flexibleRightMargin.rawValue,
                                              "flexiblewTop": UIViewAutoresizing.flexibleTopMargin.rawValue,
                                              "flexibleBottom": UIViewAutoresizing.flexibleBottomMargin.rawValue,
                                              "flexibleWidth": UIViewAutoresizing.flexibleWidth.rawValue,
                                              "flexibleHeight": UIViewAutoresizing.flexibleHeight.rawValue],
                           "RJContentMode":    ["scaleToFill": UIViewContentMode.scaleToFill.rawValue,
                                                "scaleAspectFit": UIViewContentMode.scaleAspectFit.rawValue,
                                                "scaleAspectFill": UIViewContentMode.scaleAspectFill.rawValue,
                                                "redraw": UIViewContentMode.redraw.rawValue,
                                                "center": UIViewContentMode.center.rawValue,
                                                "top": UIViewContentMode.top.rawValue,
                                                "bottom": UIViewContentMode.bottom.rawValue,
                                                "left": UIViewContentMode.left.rawValue,
                                                "right": UIViewContentMode.right.rawValue,
                                                "topLeft": UIViewContentMode.topLeft.rawValue,
                                                "topRight": UIViewContentMode.topRight.rawValue,
                                                "bottomLeft": UIViewContentMode.bottomLeft.rawValue,
                                                "bottomRight": UIViewContentMode.bottomRight.rawValue]]
        
        return constantMap
    }
}













