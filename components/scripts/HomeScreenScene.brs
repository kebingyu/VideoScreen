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
        rowList.observeField("itemSelected", "playlistItemSelected")
        m.playlistsGroup.appendChild(rowList)
    end for

    setPlaylistsGroupFocus(0)

end sub

function playlistItemSelected()
    
    '' Should the main scene pop and push components into view, instead of trying to load a new scene on video selected?
    '' http://forums.roku.com/viewtopic.php?f=34&t=88621&p=513504&hilit=scene+navigate#p513504
    '' https://blog.roku.com/developer/2016/03/03/scenegraph-tutorial/
    print "selected"
    ' m.items[m.posterRowList.rowItemSelected[1]]

    ' playlist = m.playlistsGroup.focusedChild
    ' column = playlist.rowItemSelected[1]

    playlist = m.playlistsGroup.getChild(m.activeList)

    print playlist.content.getChild(0).getChildCount()

end function

function setPlaylistsGroupFocus(index as integer)
    m.playlistsGroup.getChild(index).SetFocus(true)
end function

function onKeyEvent(key as String, press as Boolean) as Boolean
  
    ' print key
    ' print press
    handled = false
    
    if press then
        
        '' probably should check if we're focused on the playlistsGroup 
        if m.playlistsGroup.isInFocusChain() then

            if (key = "down") then
                if m.activeList = (m.playlistsGroup.getChildCount()-1)
                    m.activeList = 0
                else
                    m.activeList = m.activeList + 1
                end if
                setPlaylistsGroupFocus(m.activeList)
                handled = true
            end if

            if (key = "up") then
                if m.activeList = 0
                    m.activeList = m.playlistsGroup.getChildCount() - 1
                else
                    m.activeList = m.activeList - 1
                end if
                setPlaylistsGroupFocus(m.activeList)
                handled = true
            end if        
        
        end if

    end if

    return handled

end function
