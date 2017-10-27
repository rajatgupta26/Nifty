

var Renderer = {}

Renderer.render = function() {
    console.log("Node class - " + Node)
    console.log("Node.create - " + Node.create)
    console.log("Node.createWithIdentifier - " + Node.createWithIdentifier)
    
    // Superview
    const superNode = Node.create()
    

    // const stackOptions = {"Spacing": 10, "JustifyContent": StackSpecConstants.JustifyContent.spaceBetween}
    const children = getChildren()
    children.forEach( (node) => {
        superNode.addSubnode(node)
    })

    const stackSpec = StackSpec.createWithOptionsAndChildren({}, getChildren())
    const insetSpec = InsetSpec.createWithInsetsAndChild({top: 25, left: 12, bottom: 25, right: 12}, stackSpec)    
    superNode.layoutSpec = insetSpec
    
    // Set background color for supernode
    superNode.backgroundColor = Color.withRGB(1, 0.5, 0.25, 1)

    // Set frame for super node
    superNode.frame = {x: 0, y: 0, width: ScreenBounds.width, height: ScreenBounds.height}
      
    
    function getChildren () {
        let children = []
        debugger
        //ImageNode test
        children = children.concat(imageTest())

        //TextNode test
        children = children.concat(textTest())

        //ButtonNode test
        // children = children.concat(buttonTest())
        
        return children
    }

    function imageTest() {
        const devopsImage = imageWithName("dev-ops")
        const genieImage = imageWithName("genie")
        const images = [devopsImage, genieImage]
        return images
    }

    function imageWithName(name) {
        // Create image
        const image = Image.createWithName(name)
    
        // Create image node
        const imageNode = ImageNode.create()
        // imageNode.preferredSize = image.size
        imageNode.image = image

        imageNode.onTouchUpInside = function (buttonNode) {
            console.log(name + " Pressed!")
        }

        return imageNode
    }

    function textTest() {
        const textNode = JSTextNode()
        textNode.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        textNode.relativePreferredSize = {width: 1, height: 0.2}
        return textNode
    }

    function JSTextNode() {
        return TextNode.create()
    }

    // function buttonTest() {
    //     const buttonNode = ButtonNode.create()
    //     buttonNode.title = "Press Me"
    //     buttonNode.backgroundColor = Color.redColor
    //     buttonNode.onTouchUpInside = (buttonNode) => {
    //         console.log("Button Pressed!")
    //     }
    //     return buttonNode
    // }

//    superNode.backgroundColor = "fff00f"
//    superNode.frame = {x: 10, y: 20, width: ScreenBounds.width - 20, height: ScreenBounds.height - 40}
//    
//    const childNode = Node.create()
//    childNode.backgroundColor = "ff0000"
//    
//    const greenChild = Node.create()
//    greenChild.backgroundColor = "00ff00"
//    greenChild.frame = {x: 20, y: 20, width: ScreenBounds.width - 80, height: ScreenBounds.height - 100}
//    
////    debugger
//    
//    const edgeInsets = {top: 10, left: 10, bottom: 10, right: 10}
//    
//    
////    const pinkNode = Node.create()
////    pinkNode.backgroundColor = "ff7777"
////    pinkNode.frame = {x: 0, y: 0, width: 35, height: 35}
////    pinkNode.autoresizingMask = 0
//    
//    
//    const stackedOne = Node.create()
//    stackedOne.backgroundColor = "000000"
////    stackedOne.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
////    stackedOne.autoresizingMask = 0
//    
//    const stackedTwo = Node.create()
//    stackedTwo.backgroundColor = "555555"
////    stackedTwo.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
////    stackedTwo.autoresizingMask = 0
//    
//    const stackedThree = Node.create()
//    stackedThree.backgroundColor = "aaaaaa"
////    stackedThree.frame = {x: 0, y: 0, width: ScreenBounds.width - 100, height: 40}
////    stackedThree.autoresizingMask = 0
//    
//    
//    
//    const stackOptions = {"Spacing": 10, "JustifyContent": StackSpecConstants.JustifyContent.spaceBetween}
//
////    debugger
//    
//    let stackSpec = StackSpec.createWithOptionsAndChildren(stackOptions, [AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedOne), AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedTwo), AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, stackedThree)])
//    
//    greenChild.addSubnode(stackedOne)
//    greenChild.addSubnode(stackedTwo)
//    greenChild.addSubnode(stackedThree)
//    
//    greenChild.layoutSpec = stackSpec
//    
////    greenChild.addSubnode(pinkNode)
////    
////    greenChild.layoutSpec = CenterSpec.createWithCenteringSizingAndChild(CenterSpecConstants.CenteringOption.none, CenterSpecConstants.SizingOption.minXY, AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.default, [InsetSpec.createWithInsetsAndChild(edgeInsets, pinkNode)]))
//    
//    childNode.addSubnode(greenChild)
//    
//    childNode.layoutSpec = AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.default, [InsetSpec.createWithInsetsAndChild(edgeInsets, AbsoluteSpec.createWithSizingAndChildren(AbsoluteSpecConstants.Sizing.sizeToFit, greenChild))])
//    
////    superNode.addSubnode(childNode)
//    
//    console.log("InsetSpec class - " + InsetSpec)
//    console.log("InsetSpec.createWithInsetsAndChild - " + InsetSpec.createWithInsetsAndChild)
//
////    superNode.layoutSpec = InsetSpec.createWithInsetsAndChild(edgeInsets, childNode)
//    
//    const backgroundNode = Node.create()
//    backgroundNode.backgroundColor = "000000"
//    
//    backgroundNode.addSubnode(childNode)
//
//    superNode.addSubnode(backgroundNode)
//    
//    superNode.layoutSpec = BackgroundSpec.createWithChildAndBackground(InsetSpec.createWithInsetsAndChild(edgeInsets, childNode), backgroundNode)
    
    return superNode
}


// (function RenderWidget(owner) {
//     owner.TestWidget = {}

//     TestWidget.prototype.render
// } (this))