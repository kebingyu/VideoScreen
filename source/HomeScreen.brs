
sub HomeScreen(api = AolOnApi())

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("HomeScreenScene")
    screen.show()
    ' scene.playlists = api.getPlaylists("featured")

    scene.playlistsContentUri = Config().get("playlistsContentUri") 
    
    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        print msg

        if msgType = "roSGScreenEvent"

            if msg.isScreenClosed() then return

        end if

    end while

end sub


