sub Main()
    '' Initialize theme settings
    globalConfig = Config()
    globalConfig.initTheme()

    '' Launch HomeScene
    screen = CreateObject("roSGScreen")
    m.port = CreateObject("roMessagePort")
    screen.setMessagePort(m.port)
    scene = screen.CreateScene("HomeScene")
    screen.show()

    '' Using "featured" playlist for testing
    scene.playlistsContentUri = "https://feedapi.b2c.on.aol.com/v1.0/app/pages/techcrunch/featured/playlists_full?device=ROKU&separateBodyTopic=false&imageDimensions=180x122,264x198&imageFormat=png&useThumbnailList=true"    

    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)

        print msg

        if msgType = "roSGScreenEvent"

            if msg.isScreenClosed() then return

        end if

    end while    

end sub
