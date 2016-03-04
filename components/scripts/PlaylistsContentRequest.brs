sub init()
    m.top.functionName = "getContent"
end sub

sub getContent()
    
    util = Utils()
    
    request = ParseJson(util.getStringFromURL(m.top.uri))

    if request.response <> invalid

        response = request.response

        content = createObject("RoSGNode", "ContentNode")    

        if response.data <> invalid

            for each playlist in response.data.playlists

                playlistNode = content.createChild("ContentNode")
                playlistItem = playlistNode.createChild("ContentNode")
                playlistItem.title = playlist.name

                for each item in playlist.items

                    videoData = item.video
                    video = playlistItem.CreateChild("VideoItemData")

                    '' formatted release date
                    releasedate = CreateObject("roDateTime")
                    releasedate.FromSeconds(videoData.publishDate)

                    video.id = util.validStr(videoData.id)
                    video.contentid = util.validStr(videoData.id)
                    video.title = util.validStr(videoData.title)
                    video.description = util.validStr(videoData.description)
                    video.shortDescriptionLine1 = util.validStr(videoData.title)
                    video.shortDescriptionLine2 = util.validStr(videoData.description)
                    video.sdPosterURL = util.validStr(videoData.thumbnailList[0].url)
                    video.hdPosterURL = util.validStr(videoData.thumbnailList[1].url)
                    video.releaseDate = releasedate.asDateStringNoParam()
                    video.length = videoData.duration
                    video.rating = util.validStr(videoData.rating)
                    video.categories = util.validStr(videoData.category)
                    video.streamFormat = "mp4"
                    video.contentType =  "episode"
                    video.renditions = videoData.renditions

                end for

            end for

        end if 

        m.top.content = content

    else
        '' TODO: Handle request error
    end if

end sub