

Function VideoScreen()

    episode = {
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
            url: "http://tvideos.5min.com//972/5194972/519497184_4.mp4?hdnea=exp=1455638945~acl=/*~hmac=71dd7330805c52e46791bf684cbc6ac9ce17bb28b54b2a6a4f79a2653b307ab3"
        }
    }

    showVideoScreen(episode)
    
End Function



Function showVideoScreen(episode As Object)

    if type(episode) <> "roAssociativeArray" then
        print "invalid data passed to showVideoScreen"
        return -1
    endif

    port = CreateObject("roMessagePort")
    screen = CreateObject("roVideoScreen")

    ' Note: HDBranded controls whether the "HD" logo is displayed for a
    ' title. This is separate from IsHD because its possible to
    ' have an HD title where you don't want to show the HD logo
    ' branding for the title. Set these two as appropriate for
    ' your content
    ' episode.HDBranded = false
    ' episode.IsHD = false
   
    ' Note: The preferred way to specify stream info in v2.6 is to use
    ' the Stream roAssociativeArray content meta data parameter.
 
   ' now just tell the screen about the title to be played, set the
   ' message port for where you will receive events and call show to
   ' begin playback.  You should see a buffering screen and then
   ' playback will start immediately when we have enough data buffered.
    
    screen.SetContent(episode)
    screen.SetMessagePort(port)
    screen.Show()

   ' Wait in a loop on the message port for events to be received. 
   ' We will just quit the loop and return to the calling function
   ' when the users terminates playback, but there are other things
   ' you could do here like monitor playback position and see events
   ' from the streaming player.  Look for status messages from the video
   ' player for status and failure events that occur during playback
    while true
       msg = wait(0, port)
    
       if type(msg) = "roVideoScreenEvent" then
           print "showVideoScreen | msg = "; msg.GetMessage() " | index = "; msg.GetIndex()
           if msg.isScreenClosed()
               print "Screen closed"
               exit while
            else if msg.isStatusMessage()
                  print "status message: "; msg.GetMessage()
            else if msg.isPlaybackPosition()
                  print "playback position: "; msg.GetIndex()
            else if msg.isFullResult()
                  print "playback completed"
                  exit while
            else if msg.isPartialResult()
                  print "playback interrupted"
                  exit while
            else if msg.isRequestFailed()
                  print "request failed - error: "; msg.GetIndex();" - "; msg.GetMessage()
                  exit while
            end if
       end if
    end while
End Function