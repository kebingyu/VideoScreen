''
'' The starting point.  Shows the poster screen, gets playlist data,
'' and then shows the home screen.
''

sub Main()
  ' first initialize any theme settings
  globalConfig = Config()
  globalConfig.initTheme()

  ' VideoScreen()
  VideoScreenSG()
  
  sleep(25)

end sub
