sub init(uiHelper = UI(), api = AolOnAPI())

    m.list = m.top.findNode("coreList")

    ' m.top.setFocus(true)
    ' m.playlistsGroup = m.top.findNode("playlistsGroup")
    ' m.playlistRowList = m.top.findNode("playlistRowList")

    ' uiHelper.position(m.playlistRowList, "bottom", {
    '     top: 30,
    '     left: 30,
    '     right: 30,
    '     bottom: (-1 * m.playlistRowList.height) + 30
    ' }) 


    ' m.testTask = createObject("roSGNode", "testTask") 
    
    ' print "task done"

    '  m.list = m.top.findNode("coreList")

end sub


function getPlaylistsContent()
    
  m.playlistsContentRequest = createObject("roSGNode", "playlistsContentRequest")
  m.playlistsContentRequest.uri = m.top.playlistsContentUri
  m.playlistsContentRequest.observeField("content", "showPlaylists")
  m.playlistsContentRequest.control = "RUN"     

end function


sub showPlaylists()

    print "task done callback"
    print m.playlistsContentRequest.content
    m.list.content = m.playlistsContentRequest.content
    m.list.SetFocus(false)

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