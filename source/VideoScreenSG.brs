

sub VideoScreenSG(api = AolOnApi())

    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("VideoScreenScene")
    screen.show()


    

    ' print api.getPages()
    playlists = api.getPlaylists("featured")

    scene.playlist = playlists[0]


    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        print msg

        if msgType = "roSGScreenEvent"

            if msg.isScreenClosed() then return

        end if

    end while

end sub


