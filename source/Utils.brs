sub Utils() as Object
    this = {
        extend: utils_extend
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

