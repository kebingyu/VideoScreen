sub UI() as Object
    this = {
        fullScreen: ui_fullScreen,
        position: ui_position
    }
    return this
end sub


''
''  Position and size node to fill screen
''  @param roSGNode node
'' 
function ui_fullScreen(node)

    info = CreateObject("roDeviceInfo")
    size = info.GetDisplaySize()

    node.translation = [0, 0]
    node.height = size.h
    node.width = size.w

end function


''
''  Position node and provide padding if padding object is passed
''  @param roSGNode node
''  @param string location
''  @param object padding
'' 
function ui_position(node, location, padding)

    info = CreateObject("roDeviceInfo")
    size = info.GetDisplaySize()    
    padding = Utils().extend({
        top: 0, 
        left: 0, 
        right: 0, 
        bottom: 0
    }, padding)
    
    ' TODO: create locations left and right
    if location = "top" then

        node.translation = [padding.left, padding.top]
        node.width = size.w - (padding.left + padding.right)

    else if location = "bottom" then
        
        node.translation = [padding.left, size.h - (node.height + padding.bottom)]
        node.width = size.w - (padding.left + padding.right)

    end if

end function

