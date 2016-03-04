sub init(uiHelper = UI(), api = AolOnAPI())

    
    m.top.setFocus(true)
    m.playlistsGroup = m.top.findNode("playlistsGroup")
    m.playlistRowList = m.top.findNode("playlistRowList")
    m.list = m.top.findNode("coreList")

    uiHelper.position(m.playlistRowList, "bottom", {
        top: 30,
        left: 30,
        right: 30,
        bottom: 100
    }) 



end sub


function getPlaylistsContent()
    
  m.playlistsContentRequest = createObject("roSGNode", "playlistsContentRequest")
  m.playlistsContentRequest.uri = m.top.playlistsContentUri
  m.playlistsContentRequest.observeField("content", "showPlaylists")
  m.playlistsContentRequest.control = "RUN"     

end function


sub showPlaylists()

    print "task done callback"
    content = m.playlistsContentRequest.content

    m.list.content = content
    print content.getChild(0).getField("title")
    print content.getChild(0).getChildCount()


    
    ' m.playlistRowList.itemContent = content
    m.playlistRowList.content = content
    ' m.playlistRowList.SetFocus(true)



    ' data = CreateObject("roSGNode", "ContentNode")
    ' row = data.CreateChild("ContentNode")
    ' row.title = "fooo"

    ' for i=1 to 10
    '     item = row.CreateChild("PosterRowListItemData")
    '     item.posterUrl = ""
    '     item.labelText = "HElllloo"
    ' end for

    ' m.playlistRowList.content = data    
    m.playlistRowList.SetFocus(true)



end sub


function playlistsChanged()

    ' print "WTF"


    ' playlist = m.top.playlists[0]



    ' m.items = playlist.items





    ' data = CreateObject("roSGNode", "ContentNode")
    
    ' row = data.CreateChild("ContentNode")
    
    ' row.title = playlist.name

    ' for each video in m.items
    '     item = row.CreateChild("PosterRowListItemData")
    '     item.posterUrl = video.sdPosterURL
    '     item.labelText = video.title
    ' end for

    ' m.playlistRowList.content = data    

end function