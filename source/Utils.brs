sub Utils() as Object
    this = {
        extend: utils_extend,
        getStringFromURL: utils_getStringFromURL,
        strReplace: utils_strReplace,
        isNonEmptyStr: utils_isNonEmptyStr,
        validStr: utils_validStr,
        isNullOrEmpty: utils_isNullOrEmpty,
        isStr: utils_isStr
    }
    return this
end sub


''
''  Merge the contents of object1 into the target object
''  @param object target
''  @param object object1
'' 
function utils_extend(target, object1)
    for each prop in target
        if object1[prop] <> invalid then
            target[prop] = object1[prop]
        end if
    end for
    return target
end function


''
''  Calls the given URL and returns its result as a string.
''  Modified from NWM_Utilities.brs in the Roku SDK
''  @param string url
''  @param string bcovPolicy
''
function utils_getStringFromURL(url, bcovPolicy = "")
  result = ""
  timeout = 10000

  ut = CreateObject("roURLTransfer")

  ' allow for https
  ut.SetCertificatesFile("common:/certs/ca-bundle.crt")
  ut.AddHeader("X-Roku-Reserved-Dev-Id", "")
  ut.InitClientCertificates()

  ut.SetPort(CreateObject("roMessagePort"))
  
  if bcovPolicy <> ""
    ut.AddHeader("BCOV-Policy", bcovPolicy)
  end if
  
  ut.SetURL(url)
  
  if ut.AsyncGetToString()
    event = wait(timeout, ut.GetPort())
    if type(event) = "roUrlEvent"
      ' print ValidStr(event.GetResponseCode())
      result = event.GetString()
    elseif event = invalid
      ut.AsyncCancel()
      ' reset the connection on timeouts
      ' ut = CreateURLTransferObject(url)
      ' timeout = 2 * timeout
    else
      print "roUrlTransfer::AsyncGetToString(): unknown event"
    endif
  end if
  return result
end function


''
''  Replace substrings in a string. Return new string
''  @param string basestr
''  @param string oldsub
''  @param string newsub
''
function utils_strReplace(basestr As String, oldsub As String, newsub As String) As String
    newstr = ""

    i = 1
    while i <= Len(basestr)
        x = Instr(i, basestr, oldsub)
        if x = 0 then
            newstr = newstr + Mid(basestr, i)
            exit while
        endif

        if x > i then
            newstr = newstr + Mid(basestr, i, x-i)
            i = x
        endif

        newstr = newstr + newsub
        i = i + Len(oldsub)
    end while

    return newstr
end function

''
'' Check for a valid string, otherwise return empty string
'' @param dynamic obj
''
function utils_validStr(obj As Dynamic) As String
    if utils_isNonEmptyStr(obj) return obj
    return ""
end function

''
'' Determine if the given object supports the ifString interface
'' and returns a string of non zero length
'' @param dynamic obj
''
function utils_isNonEmptyStr(obj)
    if utils_isNullOrEmpty(obj) return false
    return true
end function

''
'' Determine if the given object is invalid or supports
'' the ifString interface and returns a string of non zero length
'' @param dynamic obj
''
function utils_isNullOrEmpty(obj)
    if obj = invalid return true
    if not utils_isStr(obj) return true
    if Len(obj) = 0 return true
    return false
end function

''
'' Determine if the given object supports the ifString interface
'' @params dynamic obj
''
function utils_isStr(obj as dynamic) As Boolean
    if obj = invalid return false
    if GetInterface(obj, "ifString") = invalid return false
    return true
end function
