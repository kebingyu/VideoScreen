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

    m.video.ObserveField("state", "statusChanged")
    m.video.ObserveField("bufferingStatus", "bufferingChanged")
    m.video.ObserveField("position", "positionChanged")

    m.posterRowList = m.top.findNode("posterRowList")
    
    uiHelper.position(m.posterRowList, "bottom", {
        top: 30,
        left: 30,
        right: 30,
        bottom: (-1 * m.posterRowList.height) + 30
    })    

    setPosterAnimation()

    setVideo()      

end sub

function setPosterAnimation()

    ' Set up values for poster animation
    m.posterAnimation = m.top.findNode("posterRowListAnimation")
    m.posterInterp = m.top.findNode("posterRowListInterp")
    m.initialPosterTranslation = m.posterRowList.translation
    m.posterInterp.key = [0.0, 1.0]

end function

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
    ' show a preloader graphic?
end function

function setVideo() as void

    ' TEST DATA
    videoContent = createObject("RoSGNode", "ContentNode")
    ' videoContent.id = 519497184
    ' videoContent.contentid = 519497184
    videoContent.title = "Microsoft's Fetch App Identifies Your Dog"
    ' videoContent.description = "Fetch is an app that recognizes breeds of dogs and tells you what dog you look like the most. Or if you're human, it let's you know your spirit dog might be."
    ' videoContent.shortDescriptionLine1 = "Microsoft's Fetch App Identifies Your Dog"
    ' videoContent.shortDescriptionLine2 = "Fetch is an app that recognizes breeds of dogs and tells you what dog you look like the most. Or if you're human, it let's you know your spirit dog might be."
    ' videoContent.length = 82
    ' videoContent.rating = "nonadult"
    videoContent.streamFormat = "mp4"
    ' videoContent.contentType =  "episode"
    videoContent.url = "http://tvideos.5min.com//869/5194869/519486842_4.mp4?hdnea=exp=1455814160~acl=/*~hmac=dea2c90ba698675bc63e3870330e7673b922a2b9f57dcee1e36a8f1978a33d68"


    ' videoContent.title = "Test Video"
    ' videoContent.streamformat = "mp4"
    m.video.content = videoContent
    m.video.control = "play"

end function

function toggleMenu()
    if m.posterAnimation.state <> "running"
        if m.posterRowList.hasFocus() then
            m.posterInterp.keyValue = [ m.posterRowList.translation, m.initialPosterTranslation ]
            m.posterAnimation.control = "start"
            m.posterRowList.SetFocus(false)
            m.top.setFocus(true)
        else
            m.posterInterp.keyValue = [ m.initialPosterTranslation, [m.initialPosterTranslation[0], m.initialPosterTranslation[1] - 200] ]
            m.posterAnimation.control = "start"
            m.posterRowList.SetFocus(true)
        end if
    end if
end function


function onKeyEvent(key as String, press as Boolean) as Boolean
    
    print key
    
    handled = false
    
    if press then
    
        if key = "play" then
        
            if m.video.state = "paused" then
                m.video.control = "resume"
            else
                m.video.control = "pause"
            endif
    
        else if key = "rewind" then
        
            m.video.position = m.video.position - 60
            m.video.seek = m.video.position
        
        else if key = "fastforward" then    
            
            m.video.position = m.video.position + 60
            m.video.seek = m.video.position

        else if (key = "up") then
            toggleMenu()
        else if (key = "down") then    
            toggleMenu()
        end if            
    
    end if

    return handled

end function





