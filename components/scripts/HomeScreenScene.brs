sub init(uiHelper = UI(), api = AolOnAPI())
    
    m.top.setFocus(true)
    m.playlistsGroup = m.top.findNode("playlistsGroup")
    m.activeList = 0

end sub

function getPlaylistsContent()
    
  m.playlistsContentRequest = createObject("roSGNode", "playlistsContentRequest")
  m.playlistsContentRequest.uri = m.top.playlistsContentUri
  m.playlistsContentRequest.observeField("content", "showPlaylists")
  m.playlistsContentRequest.control = "RUN"     

end function

sub showPlaylists()

    content = m.playlistsContentRequest.content

    for i=0 to (content.getChildCount()-1)
        rowList = createObject("roSGNode", "PosterRowList")
        rowList.itemComponentName = "PosterRowListItem"
        rowList.height = 212
        rowList.width = 1000
        rowList.content = content.getChild(i)
        m.playlistsGroup.appendChild(rowList)
    end for

    setPlaylistsGroupFocus(0)

end sub

function setPlaylistsGroupFocus(index as integer)
    m.playlistsGroup.getChild(index).SetFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
  
    ' print key
    ' print press
    handled = false
    
    if press then
        
        '' probably should check if we're focused on the playlistsGroup 

        if (key = "down") then
            if m.activeList = (m.playlistsGroup.getChildCount()-1)
                m.activeList = 0
            else
                m.activeList = m.activeList + 1
            end if
            setPlaylistsGroupFocus(m.activeList)
        end if

        if (key = "up") then
            if m.activeList = 0
                m.activeList = m.playlistsGroup.getChildCount() - 1
            else
                m.activeList = m.activeList - 1
            end if
            setPlaylistsGroupFocus(m.activeList)
        end if        

    end if

    return handled
    
end function
