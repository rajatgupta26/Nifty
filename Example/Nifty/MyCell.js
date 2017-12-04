

var Renderer = {}

Renderer.render = function() {    
    // Superview
    const superNode = Node.create()

    debugger

    const stackOptions = {"Direction": StackSpecConstants.Direction.horizontal}
    const children = getChildren()
    children.forEach( (node) => {
        superNode.addSubnode(node)
    })

    const stackSpec = StackSpec.createWithOptionsAndChildren(stackOptions, children)
    const insetSpec = InsetSpec.createWithInsetsAndChild({top: 25, left: 12, bottom: 25, right: 12}, stackSpec)    
    superNode.layoutSpec = insetSpec
    
    // Set background color for supernode
    superNode.backgroundColor = Color.withRGB(1, 0.5, 0.25, 1)

    // Set frame for super node
    superNode.frame = {x: 0, y: 0, width: ScreenBounds.width, height: 100}
      
    
    function getChildren () {
        let children = []
        // debugger
        //ImageNode test
        children = children.concat(imageTest())

        //TextNode test
        children = children.concat(textTest())
        children = children.concat(textTest())
        // children = children.concat(textTest())
        
        //ButtonNode test
        // children = children.concat(buttonTest())
        
        return children
    }

    function imageTest() {
        const devopsImage = imageWithName("dev-ops")
        const genieImage = imageWithUrl("https://vignette4.wikia.nocookie.net/poohadventures/images/8/8c/Genie.png")
        genieImage.preferredSize = {width: ScreenBounds.width*0.225, height:90}
        const images = [devopsImage, genieImage]
        return images
    }

    function imageWithUrl(url) {
        const networkImageNode = NetworkImageNode.create()
        networkImageNode.url = url
        
        return networkImageNode
    }

    function imageWithName(name) {
        // Create image
        const image = Image.createWithName(name)
    
        // Create image node
        const imageNode = ImageNode.create()
        // imageNode.preferredSize = image.size
        imageNode.image = image

        // debugger
        console.log("Image node enabled? - " + imageNode.enabled)

        let dispatcher = {}
        dispatcher.touchHandler = function touchHandler(sender, event) {
            // debugger
            if (event == ControlNodeConstants.Event.touchUpInside) {

                const textNode = this.supernode.subnodes.find((element) => {
                    return element.text != undefined || element.text != null
                })
    
                function makeid(length) {
                    var text = "";
                    var possible = " ABCDEFGHI JKLMNOPQRST UVWXYZabc defghijklmnop qrstuvwxyz012 3456789 ";
                  
                    for (var i = 0; i < length; i++)
                      text += possible.charAt(Math.floor(Math.random() * possible.length));
                  
                    return text;
                }
    
                textNode.text = makeid(Math.floor(Math.random() * 1000))
                }
            console.log("Image Pressed: Sender - " + sender + ", this - ", this)
            
        }.bind(imageNode)

        imageNode.nt_setDispatcher(dispatcher)

        return imageNode
    }

    function textTest() {
        const textNode = TextNode.create()
        textNode.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
        // textNode.relativePreferredSize = {width: 1, height: 0.2}
        textNode.minSize = {width: ScreenBounds.width/5, height: 50}
        textNode.maxSize = {width: ScreenBounds.width/3, height: 100}
        textNode.preferredSize = {width: ScreenBounds.width*0.3, height: 80}
        textNode.tag = 1234

        var count = 0
        let dispatcher = {}
        dispatcher.timerHandler = function timerHandler() {
            debugger
            count = count + 1
            textNode.text = count
        }.bind(textNode, count)

        let timer = Timer.create()
        timer.nt_setDispatcher(dispatcher)
        timer.setupTimerWithInterval(1.0, true)

        return textNode
    }

    
    return superNode
}
