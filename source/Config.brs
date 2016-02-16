''
'' Used to manage account settings and theme
'' todo: remove brightcove settings
''


Function Config() As Object
  this = {
    ' the name to show on top of screens
    appName: "AOL Alpha Roku Channel"
    initTheme: initTheme
  }

  return this

End Function

Function initTheme()

  '' Theme setup, adjust to your needs.
  app = CreateObject("roAppManager")
  theme = CreateObject("roAssociativeArray")

  theme.OverhangOffsetSD_X = "72"
  theme.OverhangOffsetSD_Y = "31"

  ' theme.OverhangSliceSD = "pkg:/images/Overhang_Background_SD.png"
  ' theme.OverhangSliceHD = "pkg:/images/Overhang_Background_HD.png"
  ' theme.OverhangSliceSD = "pkg:/images/splash_screen_hd.png"
  ' theme.OverhangSliceHD = "pkg:/images/splash_screen_sd.png"
  

  theme.OverhangOffsetHD_X = "125"
  theme.OverhangOffsetHD_Y = "35"
  ' theme.OverhangLogoSD  = "pkg:/images/Overhang_Logo_SD.png"
  ' theme.OverhangLogoHD  = "pkg:/images/Overhang_Logo_HD.png"

  theme.BackgroundColor = "#f7f7f7"

  theme.BreadcrumbTextLeft = "#d6d6d6"
  theme.BreadcrumbTextRight = "#d6d6d6"
  theme.BreadcrumbDelimeter = chr(46)

  '' Note these are actually buttons NOT on Springboard
  theme.ButtonMenuNormalText = "#a1a1a1"
  theme.ButtonMenuHighlightText = "#765F4D"
  ' theme.ButtonHighlightColor = "#FDFF00"
  ' theme.ButtonMenuNormalColor = "#cc0000"
  ' theme.ButtonNormalColor = "#00cc00"
  ' theme.ButtonMenuNormalOverlayColor = "#0000cc"
  ' theme.ButtonMenuHighlightColor = "#00ECFF"
  ' theme.ButtonNormalColor = "#a1a1a1"
  theme.ParagraphBodyText = "#a1a1a1"
  theme.ParagraphHeaderText = "#a1a1a1"
  theme.PosterScreenLine1Text = "#a1a1a1"
  theme.PosterScreenLine2Text = "#a1a1a1"
  theme.EpisodeSynopsisText = "#a1a1a1"
  theme.SpringboardTitleText = "#a1a1a1"
  theme.SpringboardActorColor = "#a1a1a1"
  theme.SpringboardSynopsisText = "#a1a1a1"
  theme.SpringboardGenreColor = "#a1a1a1"
  theme.SpringboardButtonNormalColor = "#cc0000"
  theme.SpringboardButtonHighlightColor = "#00cc00"

  app.SetTheme(theme)

End Function
