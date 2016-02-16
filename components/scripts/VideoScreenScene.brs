' SEE CustomPlaybackScreen for handling seek, ff, rewind with remote control

sub init()

    uiHelper = UI()
    m.top.setFocus(true)
    m.progressBar = m.top.findNode("progressBar")

    uiHelper.position(m.progressBar, "bottom", {
        top: 30,
        left: 30,
        right: 30,
        bottom: 30 
    })

    m.progressBar.rectSize = [m.progressBar.height, m.progressBar.width]

    m.video = m.top.findNode("videoPlayer")

    uiHelper.fullScreen(m.video)

    ' m.video.ObserveField("state", "statusChanged")
    ' m.video.ObserveField("bufferingStatus", "bufferingChanged")
    m.video.ObserveField("position", "positionChanged")
    
    setVideo()      

end sub


function positionChanged()

    width = int((m.video.position / m.video.duration) * m.progressBar.width)

    if width > m.progressBar.width then
        width = m.progressBar.width
    end if

    m.progressBar.progress = width

end function


function statusChanged()
    ' print m.video.state
end function


function bufferingChanged()
    ' print m.video.bufferingStatus
end function


function setVideo() as void

    videoContent = createObject("RoSGNode", "ContentNode")
    videoContent.url = "http://tvideos.5min.com//972/5194972/519497184_4.mp4?hdnea=exp=1455638945~acl=/*~hmac=71dd7330805c52e46791bf684cbc6ac9ce17bb28b54b2a6a4f79a2653b307ab3"
    videoContent.title = "Test Video"
    videoContent.streamformat = "mp4"

    m.video.content = videoContent
    m.video.control = "play"

end function

function onKeyEvent(key as String, press as Boolean) as Boolean
    print key
    handled = false
    if press then
        if (key = "down") then
            m.video.control = "stop"
        end if
        if (key = "up") then
            m.video.control = "play"
        end if            
    end if
    return handled
end function
