

var Renderer = {}

Renderer.render = function() {
    console.log("Node class - " + Node)
    console.log("Node.create - " + Node.create)
    console.log("Node.createWithIdentifier - " + Node.createWithIdentifier)
    

    class NTNode {
        constructor() {
            this.setup()
        }

        setup() {
            this.node = this.loadNativeNode()
            this.setDispatcher()
        }

        loadNativeNode() {
            return Node.create()
        }

        setDispatcher() {

        }
    }

    class NTControlNode extends NTNode {
        loadNativeNode() {
            return ControlNode.create()
        }

        setDispatcher() {
            this.dispatcher = new NTControlNodeDispatcher()
            this.node.nt_setDispatcher(this.dispatcher)
        }

        setCallback(event, callback) {
            let eventConsts = ControlNodeConstants.Event
            
            switch (event) {
                case eventConsts.touchDown:
                this.dispatcher.touchDown = callback
                break;

                case eventConsts.touchDownRepeat:
                this.dispatcher.touchDownRepeat = callback
                break;

                case eventConsts.touchDragInside:
                this.dispatcher.touchDragInside = callback
                break;

                case eventConsts.touchDragOutside:
                this.dispatcher.touchDragOutside = callback
                break;

                case eventConsts.touchUpInside:
                this.dispatcher.touchUpInside = callback
                break;

                case eventConsts.touchUpOutside:
                this.dispatcher.touchUpOutside = callback
                break;

                case eventConsts.touchCancel:
                this.dispatcher.touchCancel = callback
                break;

                case eventConsts.valueChanged:
                this.dispatcher.valueChanged = callback
                break;

                case eventConsts.primaryActionTriggered:
                this.dispatcher.primaryActionTriggered = callback
                break;

                case eventConsts.allEvents:
                this.dispatcher.allEvents = callback
                break;
            }
        }
    }

    class NTImageNode extends NTControlNode {
        loadNativeNode() {
            return ImageNode.create()
        }
    }

    class NTTextNode extends NTControlNode {
        loadNativeNode() {
            return TextNode.create()
        }
    }


    class NTControlNodeDispatcher {
        constructor() {
            this.touchHandler = this.touchHandler.bind(this)
        }

        touchHandler(sender, event) {
            console.log("Touch up inside: Sender - " + sender + ", Event - " + event)
            let eventConsts = ControlNodeConstants.Event
            
            switch (event) {
                case eventConsts.touchDown:
                console.log("Touch down")
                if (this.touchDown) {
                    this.touchDown(sender, event)
                }
                break;

                case eventConsts.touchDownRepeat:
                console.log("Touch down repeat")
                if (this.touchDownRepeat) {
                    this.touchDownRepeat(sender, event)
                }
                break;

                case eventConsts.touchDragInside:
                console.log("Touch drag inside")
                if (this.touchDragInside) {
                    this.touchDragInside(sender, event)
                }
                break;

                case eventConsts.touchDragOutside:
                console.log("Touch drag outside")
                if (this.touchDragOutside) {
                    this.touchDragOutside(sender, event)
                }
                break;

                case eventConsts.touchUpInside:
                console.log("Touch up inside")
                if (this.touchUpInside) {
                    this.touchUpInside(sender, event)
                }
                break;

                case eventConsts.touchUpOutside:
                console.log("Touch up outside")
                if (this.touchUpOutside) {
                    this.touchUpOutside(sender, event)
                }
                break;

                case eventConsts.touchCancel:
                console.log("Touch cancel")
                if (this.touchCancel) {
                    this.touchCancel(sender, event)
                }
                break;

                case eventConsts.valueChanged:
                console.log("Value changed")
                if (this.valueChanged) {
                    this.valueChanged(sender, event)
                }
                break;

                case eventConsts.primaryActionTriggered:
                console.log("Primary action triggerd")
                if (this.primaryActionTriggered) {
                    this.primaryActionTriggered(sender, event)
                }
                break;

                case eventConsts.allEvents:
                console.log("All events")
                if (this.allEvents) {
                    this.allEvents(sender, event)
                }
                break;
            
                default:
                    break;
            }
        }
    }
    
    debugger
    console.log("Control node constants - " + ControlNodeConstants.Event)

    const superNode = new NTNode()

    superNode.node.backgroundColor = Color.withRGB(1, 0.75, 0.25, 1)
    superNode.node.relativePreferredSize = {width: 1, height: 1}
    superNode.node.frame = {x: 0, y: 0, width: ScreenBounds.width, height: ScreenBounds.height}
    
    const genie = new NTImageNode()
    genie.node.image = Image.createWithName("genie")

    const onTouchUpInsideCallBack = function (sender, event) {
        debugger
        console.log("Image Pressed: Sender - " + sender + ", this - ", this)

        const textNode = this.supernode.subnodes.find((element) => {
            return element.text != undefined || element.text != null
        })

        textNode.text = randomText(Math.floor(Math.random() * 1000))
    }.bind(genie.node)

    genie.setCallback(ControlNodeConstants.Event.touchUpInside, onTouchUpInsideCallBack)

    const textNode = new NTTextNode()
    textNode.node.text = randomText(1000)
    textNode.node.relativePreferredSize = {width: 1, height: 0.2}
    textNode.backgroundColor = Color.withRGB(0, 0.75, 0.25, 1)    
    debugger
    textNode.node.tag = 1234

    superNode.node.addSubnode(genie.node)
    superNode.node.addSubnode(textNode.node)

    const stackSpec = StackSpec.createWithOptionsAndChildren({}, [genie.node, textNode.node])
    const insetSpec = InsetSpec.createWithInsetsAndChild({top: 25, left: 12, bottom: 25, right: 12}, stackSpec)    
    superNode.node.layoutSpec = insetSpec

    return superNode.node

    function randomText(length) {
        debugger
        var text = "";
        var possible = " ABCDEFGHI JKLMNOPQRST UVWXYZabc defghijklmnop qrstuvwxyz012 3456789 ";
        
        for (var i = 0; i < length; i++)
            text += possible.charAt(Math.floor(Math.random() * possible.length));
        
        return text;
    }

    
    // // Superview
    // const superNode = Node.create()
    

    // // const stackOptions = {"Spacing": 10, "JustifyContent": StackSpecConstants.JustifyContent.spaceBetween}
    // const children = getChildren()
    // children.forEach( (node) => {
    //     superNode.addSubnode(node)
    // })

    // const stackSpec = StackSpec.createWithOptionsAndChildren({}, children)
    // const insetSpec = InsetSpec.createWithInsetsAndChild({top: 25, left: 12, bottom: 25, right: 12}, stackSpec)    
    // superNode.layoutSpec = insetSpec
    
    // // Set background color for supernode
    // superNode.backgroundColor = Color.withRGB(1, 0.5, 0.25, 1)

    // // Set frame for super node
    // superNode.frame = {x: 0, y: 0, width: ScreenBounds.width, height: ScreenBounds.height}
      
    
    // function getChildren () {
    //     let children = []
    //     // debugger
    //     //ImageNode test
    //     children = children.concat(imageTest())

    //     //TextNode test
    //     children = children.concat(textTest())

    //     //ButtonNode test
    //     // children = children.concat(buttonTest())
        
    //     return children
    // }

    // function imageTest() {
    //     const devopsImage = imageWithName("dev-ops")
    //     const genieImage = imageWithName("genie")
    //     const images = [devopsImage, genieImage]
    //     return images
    // }

    // function imageWithName(name) {
    //     // Create image
    //     const image = Image.createWithName(name)
    
    //     // Create image node
    //     const imageNode = ImageNode.create()
    //     // imageNode.preferredSize = image.size
    //     imageNode.image = image

    //     // debugger
    //     console.log("Image node enabled? - " + imageNode.enabled)

    //     let dispatcher = {}
    //     dispatcher.touchHandler = function touchHandler(sender) {
    //         // debugger
    //         console.log("Image Pressed: Sender - " + sender + ", this - ", this)

    //         const textNode = this.supernode.subnodes.find((element) => {
    //             return element.text != undefined || element.text != null
    //         })

    //         function makeid(length) {
    //             var text = "";
    //             var possible = " ABCDEFGHI JKLMNOPQRST UVWXYZabc defghijklmnop qrstuvwxyz012 3456789 ";
              
    //             for (var i = 0; i < length; i++)
    //               text += possible.charAt(Math.floor(Math.random() * possible.length));
              
    //             return text;
    //         }

    //         textNode.text = makeid(Math.floor(Math.random() * 1000))
            
    //     }.bind(imageNode)

    //     imageNode.nt_setDispatcher(dispatcher)

    //     return imageNode
    // }

    // function textTest() {
    //     const textNode = JSTextNode()
    //     textNode.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
    //     textNode.relativePreferredSize = {width: 1, height: 0.2}
    //     textNode.tag = 1234
    //     return textNode
    // }

    // function JSTextNode() {
    //     return TextNode.create()
    // }

    
    // return superNode
}
