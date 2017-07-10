

var Renderer = {}

Renderer.render = function() {
    console.log("Node class - " + Node)
    console.log("Node.create - " + Node.create)
    console.log("Node.createWithIdentifier - " + Node.createWithIdentifier)
    
    const superNode = Node.create()
    superNode.backgroundColor = "fff00f"
    superNode.frame = {x: 10, y: 20, width: ScreenBounds.width - 20, height: ScreenBounds.height - 40}
    
    const childNode = Node.create()
    childNode.backgroundColor = "ff0000"
    
    const greenChild = Node.create()
    greenChild.backgroundColor = "00ff00"
    greenChild.frame = {x: 20, y: 20, width: ScreenBounds.width - 80, height: ScreenBounds.height - 100}
    
//    debugger
    
    const edgeInsets = {top: 10, left: 10, bottom: 10, right: 10}
    
    
//    const pinkNode = Node.create()
//    pinkNode.backgroundColor = "ff7777"
//    pinkNode.frame = {x: 0, y: 0, width: 35, height: 35}
//    pinkNode.autoresizingMask = 0
    
    
    const stackedOne = Node.create()
    stackedOne.backgroundColor = "000000"
//    stackedOne.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
//    stackedOne.autoresizingMask = 0
    
    const stackedTwo = Node.create()
    stackedTwo.backgroundColor = "555555"
//    stackedTwo.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
//    stackedTwo.autoresizingMask = 0
    
    const stackedThree = Node.create()
    stackedThree.backgroundColor = "aaaaaa"
//    stackedThree.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
//    stackedThree.autoresizingMask = 0
    
    
    
    const stackOptions = {"Spacing": 10, "JustifyContent": StackSpecConstants.JustifyContent.spaceBetween}
    
//    debugger
    
    let stackSpec = StackSpec.createWithOptionsAndChildren(stackOptions, [AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedOne), AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedTwo), AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedThree)])
    
    greenChild.addSubnode(stackedOne)
    greenChild.addSubnode(stackedTwo)
    greenChild.addSubnode(stackedThree)
    
    greenChild.layoutSpec = stackSpec
    
//    greenChild.addSubnode(pinkNode)
//    
//    greenChild.layoutSpec = CenterSpec.createWithCenteringSizingAndChild(CenterSpecConstants.CenteringOption.none, CenterSpecConstants.SizingOption.minXY, AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.default, [InsetSpec.createWithInsetsAndChild(edgeInsets, pinkNode)]))
    
    childNode.addSubnode(greenChild)
    
    childNode.layoutSpec = AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.default, [InsetSpec.createWithInsetsAndChild(edgeInsets, AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, greenChild))])
    
//    superNode.addSubnode(childNode)
    
    console.log("InsetSpec class - " + InsetSpec)
    console.log("InsetSpec.createWithInsetsAndChild - " + InsetSpec.createWithInsetsAndChild)

//    superNode.layoutSpec = InsetSpec.createWithInsetsAndChild(edgeInsets, childNode)
    
    const backgroundNode = Node.create()
    backgroundNode.backgroundColor = "000000"
    
    backgroundNode.addSubnode(childNode)

    superNode.addSubnode(backgroundNode)
    
    superNode.layoutSpec = BackgroundSpec.createWithChildAndBackground(InsetSpec.createWithInsetsAndChild(edgeInsets, childNode), backgroundNode)
    
    return superNode
}
