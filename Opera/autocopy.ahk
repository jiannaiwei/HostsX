~LButton::
    CoordMode, Mouse, Screen
    ;这一句，最好加上，不然在切换窗口的时候容易误触发；当然误触发应该也没啥事…
    MouseGetPos, x1, y1
    KeyWait, LButton, U
    WinGetActiveTitle, Title
    If Title contains Firefox, Opera, Internet Explorer
    {
        MouseGetPos, x2, y2
        if (abs(x1-x2)>10 or abs(y1-y2)>10)
        ;当然得拖动一段距离才触发
        send ^c
    }
return