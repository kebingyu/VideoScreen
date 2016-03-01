sub init(uiHelper = UI())

    ' TEST DATA
    m.episode = {
        id: 519497184,
        contentid: 519497184,
        title: "Microsoft's Fetch App Identifies Your Dog",
        description: "Fetch is an app that recognizes breeds of dogs and tells you what dog you look like the most. Or if you're human, it let's you know your spirit dog might be.",
        shortDescriptionLine1: "Microsoft's Fetch App Identifies Your Dog",
        shortDescriptionLine2: "Fetch is an app that recognizes breeds of dogs and tells you what dog you look like the most. Or if you're human, it let's you know your spirit dog might be.",
        length: 82,
        rating: "nonadult",
        streamFormat: "mp4",
        contentType:  "episode",
        stream: {  
            url: "http://cdn.vidible.tv/prod/2016-03/01/56d4ee0be4b080b62b960b24_854x480_v1.mp4?hdnea=exp=1456936060~acl=/*~hmac=1e5b0cfa735c8146e16058ee089dbf28b1bcc3bb502dacdaaebe2e1c727de59a"
        }
    }
    ' @END TEST DATA
    
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


    m.menuGroup = m.top.findNode("menuGroup")

    m.titleLabel = m.top.findNode("titleLabel")
    m.titleLabel.text = m.episode.title

    uiHelper.position(m.titleLabel, "top", {
        top: 30,
        left: 30,
        right: 30
    })

    m.posterRowList = m.top.findNode("posterRowList")
    
    print "posterrowlist"

    uiHelper.position(m.posterRowList, "bottom", {
        top: 30,
        left: 30,
        right: 30,
        bottom: (-1 * m.posterRowList.height) + 30
    })    

    setPosterAnimation()

    setVideo()   

end sub


function playlistChanged()

    ' Load playlist videos into posterRowList

    items = m.top.playlist.items
    data = CreateObject("roSGNode", "ContentNode")
    row = data.CreateChild("ContentNode")
    row.title = "Playlist"

    for each video in items
        print video
        item = row.CreateChild("PosterRowListItemData")
        item.posterUrl = video.sdPosterURL
        item.labelText = video.title
    end for

    m.posterRowList.content = data    

end function


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
    videoContent.title = m.episode.title
    videoContent.streamFormat = m.episode.streamFormat
    videoContent.url = m.episode.stream.url
    m.video.content = videoContent
    m.video.control = "play"

end function


function toggleRelated()
    
    if m.posterAnimation.state <> "running" then
        if m.posterRowList.hasFocus() then
            m.posterInterp.keyValue = [ m.posterRowList.translation, m.initialPosterTranslation ]
            m.posterAnimation.control = "start"
            m.progressBar.visible = true
            m.posterRowList.SetFocus(false)
            m.top.setFocus(true)
        else
            m.progressBar.visible = false
            m.posterInterp.keyValue = [ m.initialPosterTranslation, [m.initialPosterTranslation[0], m.initialPosterTranslation[1] - 200] ]
            m.posterAnimation.control = "start"
            m.posterRowList.SetFocus(true)
        end if
    end if

end function

function toggleMenu(key)
    
    if m.menuGroup.visible then
        if key = "up" then
            if m.posterRowList.hasFocus() then
                toggleRelated()
            else
                m.menuGroup.visible = false
            endif
        else
            toggleRelated()
        endif
    else
        m.menuGroup.visible = true
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

        else if key = "up" OR key = "down" then
            
            if m.video.state <> "buffering" then
                toggleMenu(key)
            end if

        end if            
    
    end if

    return handled

end function





