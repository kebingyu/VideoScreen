sub AolOnAPI() as Object
    this = {
        getPages: aolOnApi_getPages,
        getPlaylists: aolOnApi_getPlaylists,
        ' getRenditionsForVideo: aolOnApi_getRenditionsForVideo
        getRenditionByQuality: aolOnApi_getRenditionByQuality
    }
    return this
end sub

function aolOnApi_getPages(util = Utils())
  
    pages = []
    url = "https://feedapi.b2c.on.aol.com/v1.0/app/pages/techcrunch?region=us&device=ROKU"
    response = ParseJson(util.getStringFromURL(url)).response

    if response.data <> invalid
  
        for each item in response.data.pages
            pages.push({
            id: item.pageId,
                shortDescriptionLine1: item.pageName
            })
        end for
  
    endif 
  
    return pages

end function


function aolOnApi_getPlaylists(pageId, util = Utils())
  
    playlists = []
  
    ' todo: url encode page id with roUrlTransfer?
    pageId = util.strReplace(pageId, " ", "%20")
  
    url = "https://feedapi.b2c.on.aol.com/v1.0/app/pages/techcrunch/" + pageId + "/playlists_full?device=ROKU&separateBodyTopic=false&imageDimensions=180x122,264x198&imageFormat=png&useThumbnailList=true"
  
    ' todo: handle error if response key doesn't exist
    response = ParseJson(util.getStringFromURL(url)).response

    if response.data <> invalid

        for each playlist in response.data.playlists
            playlistData = {}
            playlistData.id = playlist.id
            playlistData.name = playlist.name
            playlistData.items = []

            for each item in playlist.items
                video = item.video

                ' formatted release date
                releasedate = CreateObject("roDateTime")
                releasedate.FromSeconds(video.publishDate)

                playlistData.items.Push({
                    id: util.validStr(video.id),
                    contentid: util.validStr(video.id),
                    title: util.validStr(video.title),
                    description: util.validStr(video.description),
                    shortDescriptionLine1: util.validStr(video.title),
                    shortDescriptionLine2: util.validStr(video.description),
                    sdPosterURL: util.validStr(video.thumbnailList[0].url),
                    hdPosterURL: util.validStr(video.thumbnailList[1].url),
                    releaseDate: releasedate.asDateStringNoParam(),
                    length: video.duration,
                    rating: util.validStr(video.rating),
                    categories: util.validStr(video.category),
                    streamFormat: "mp4",
                    contentType:  "episode",
                    renditions: video.renditions
                })        
            end for

            playlists.push(playlistData)

        end for

    end if 

    return playlists

end function

' function aolOnApi_getRenditionsForVideo(video)

'     for each rendition in video.renditions
'         if UCase(util.validStr(rendition.format)) = "MP4"
'             newStream = {
'                 url:  util.validStr(rendition.url)
'             }
'             video.streams.Push(newStream)
'         end if
'     next
' end function

function aolOnApi_getRenditionByQuality(video, uiHelper = UI(), util = Utils())
    
    quality = uiHelper.getUIResolutionName()
    url = ""

    for each rendition in video.renditions
        if UCase(util.validStr(rendition.quality)) = UCase(quality)
            url = rendition.url
            exit for
        end if
    end for

    return url

end function 



