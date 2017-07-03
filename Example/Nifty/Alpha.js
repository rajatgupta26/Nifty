

var Renderer = {}

Renderer.render = function() {
    console.log("Node class - " + Node)
    console.log("Node.create - " + Node.create)
    console.log("Node.createWithIdentifier - " + Node.createWithIdentifier)
    
    const superNode = Node.create()
    superNode.backgroundColor = "fff00f"
    superNode.frame = {x: ScreenBounds.width/4, y: ScreenBounds.height/4, width: ScreenBounds.width/2, height: ScreenBounds.height/2}
    
    const childNode = Node.create()
    childNode.backgroundColor = "ff0000"
    
    superNode.addSubnode(childNode)
    
    const edgeInsets = {top: 20, left: 20, bottom: 20, right: 20}
    
    console.log("InsetSpec class - " + InsetSpec)
    console.log("InsetSpec.createWithInsetsAndChild - " + InsetSpec.createWithInsetsAndChild)

    superNode.layoutSpec = InsetSpec.createWithInsetsAndChild(edgeInsets, childNode)
    
    return superNode
}
