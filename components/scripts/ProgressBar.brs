sub init()
    m.trackRect = m.top.findNode("trackRect")
    m.fillRect = m.top.findNode("fillRect")
end sub

function updateProgress()
    m.fillRect.width = m.top.progress
end function

function updateRectSize()
    m.trackRect.height = m.top.rectSize[0]
    m.fillRect.height = m.top.rectSize[0]
    m.trackRect.width = m.top.rectSize[1]
end function
