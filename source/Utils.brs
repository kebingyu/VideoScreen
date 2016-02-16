sub Utils() As Object
    this = {
        fullScreen = utils_fullScreen
    }
    return this
end sub


''
''  position and size node to fill screen
''
function utils_fullScreen(node)

    info = CreateObject("roDeviceInfo")
    size = info.GetDisplaySize()

    ' size = info.GetDisplayMode()

    node.x = 0
    node.y = 0
    node.width = size.width
    node.height = size.height
    
end function

