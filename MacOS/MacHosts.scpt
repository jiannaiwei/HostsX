-- 需要管理员密码，
-- PS1:如果密码为空，则脚本运行时会弹出密码输入框
-- PS2:如果脚本保存为scpt，则弹出的密码输入框会说"AppleScropt 编辑器"需要输入密码
------如果保存为应用程序，则会用保存的程序的名称提示密码
property myPWD : ""

-- 一个可以获取最新hosts的URL（下载的hosts第一行最好是更新时间）
property hostsURL : "http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts"

-- 用于暂时保存更新的hosts文件的文件路径
property hostsTempPath : "~/hosts"

-- 自己的Hosts列表，如果这个文件路径不为空，则这个文件里面的内容将会追加到新的hosts文件后面
-- PS:自定义的Hosts文件第一行一定要为空行！！！！！
property hostsCustomPath : ""

-- 一个可以获取最新autoproxy.pac的URL
property pacURL : "http://hostsx.googlecode.com/svn/trunk/Autoproxy.pac"

-- autoproxy.pac保存位置
-- PS:这个文件路径一定要有文件存在，不然脚本不会更新autoproxy.pac
property pacSavePath : "~/Sites/autoproxy.pac"

--是否显示Growl提醒(TODO:如果服务器hosts跟本地hosts一致，则不要提醒)
property growlEnabled : true

--Growl提醒中的程序名字
property growlName : "GFW Auto Updater"

--Growl提醒用的Icon。将这个脚本储存为"应用程序"。如果保存的程序名字为abc.app，则这里填abc就能使用这个程序的icon。
--显示这个程序的包内容，然后修改Cotnents/Info.plist，在里面添加<key>LSUIElement</key><true/>就可以使程序不出现在dock上面。
property growlIconApp : "GFWAuoUpdater"
-- PS:如果需要更改提醒图标可以将代码区的"icon of application growlIconApp"换成:
------1. icon of file "file:///Users/someone/Growl"
------2. image from location "file:///Users/someone/pictures/stopWatch.png"



------------------------------------------------------------------------------
------------------------------------ 代码 ------------------------------------
------------------------------------------------------------------------------
set LF to ASCII character 10

------------------------------
-------- 更新Hosts -----------
------------------------------
set hostsMsg to ""
set hostsNewTime to ""
set hostsdlSuccess to true
set hostsNeedUpdate to false
set hostTempCreated to false

try
	-- 下载Hosts
	do shell script ("curl -o " & hostsTempPath & " " & hostsURL)
on error the msg
	set hostsMsg to msg
	set hostsdlSuccess to false
end try

-- 测试是否创建了临时的hosts文件
set hostsTempFile to POSIX file (do shell script ("echo " & hostsTempPath))
tell application "Finder" to set hostTempCreated to (exists hostsTempFile)

if hostsdlSuccess and hostTempCreated then
	
	-- 比较Hosts
	-- set oldTime to first paragraph of (read "/etc/hosts")
	set old_t to do shell script "head -n 1 /etc/hosts"
	set hostsNewTime to do shell script "head -n 1 " & hostsTempPath
	set hostsNeedUpdate to (old_t is not equal to hostsNewTime)
	
	if hostsNeedUpdate then
		-- 转换Line-ending
		do shell script "perl -pi -e 's/(\\r\\n|\\n|\\r)/\\n/g' " & hostsTempPath
		-- 合并更新
		set cmd to "sh -c \"cat " & hostsTempPath & " " & hostsCustomPath & " > /etc/hosts\""
		if (myPWD is equal to "") then
			do shell script cmd with administrator privileges
		else
			do shell script cmd password myPWD with administrator privileges
		end if
		do shell script "dscacheutil -flushcache"
	end if
	
	-- 删除temp文件
	-- PS1: 可以用命令行直接删除，不过要是命令行出问题了别找我就是了。。
	-- do shell script "rm " & hostsTempPath
	-- PS2: 用Finder比较安全，但是只是移动到废纸篓
	tell application "Finder" to delete hostsTempFile
end if


------------------------------
---- 更新autoproxy.pac -------
------------------------------
set pacTemp to pacSavePath & "1"
set pacMsg to ""
set pacdlSuccess to true
set needToUpdatePac to true

if (pacURL is equal to "") then
	set pacdlSuccess to true
	set needToUpdatePac to false
else
	try
		-- 下载Hosts
		do shell script ("curl -o " & pacTemp & " " & pacURL)
	on error the msg
		set pacMsg to msg
		set pacdlSuccess to false
	end try
	
	if pacdlSuccess then
		-- 比较
		set res to do shell script "diff -q " & pacTemp & " " & pacSavePath
		set needToUpdatePac to (res is not equal to "")
		
		--删除旧的文件
		-- PS1:命令行删除
		--do shell script "rm " & pacSavePath
		-- PS2:将用户~路径转换成绝对路径
		set tp to POSIX file (do shell script ("echo " & pacSavePath))
		tell application "Finder" to delete tp
		
		--将新的文件改名字
		do shell script "mv " & pacTemp & " " & pacSavePath
	end if
end if





------------------------------
-------- Growl提醒 -----------
------------------------------
if growlEnabled then
	--检查Growl有没有运行
	tell application "System Events"
		set growlEnabled to (count of (every process whose bundle identifier is "com.Growl.GrowlHelperApp")) > 0
	end tell
end if

if (growlEnabled) then
	tell application id "com.Growl.GrowlHelperApp"
		-- 登记
		set the notifications to {"Finished"}
		register as application growlName ¬
			all notifications notifications ¬
			default notifications notifications ¬
			icon of application growlIconApp
		
		-- 发送提醒
		set n to "Finished"
		set t to "任务完成"
		set d to ""
		
		-- Hosts更新通知文本
		if hostsdlSuccess then
			if not hostTempCreated then
				set d to "Hosts更新失败:" & LF & "不能创建临时文件！" & LF
			end if
			if hostsNeedUpdate then
				set d to "Hosts已更新：" & LF & hostsNewTime & LF
			end if
		else
			set d to "Hosts下载失败：" & LF
			-- hostsMsg可能会很长，所以这里截取最后的一部分
			set len to length of hostsMsg
			if (len is greater than 50) then
				set d to d & (text (len - 50) thru -1 of hostsMsg)
			else
				set d to d & hostsMsg
			end if
			set d to d & LF
		end if
		
		-- AutoProxy更新通知文本
		if pacdlSuccess then
			if needToUpdatePac then
				set d to "Autoproxy.pac已更新！"
			end if
		else
			set d to "Autoproxy.pac下载失败：" & LF
			-- msg可能会很长，所以这里截取最后的一部分
			set len to length of pacMsg
			if (len is greater than 50) then
				set d to d & (text (len - 50) thru -1 of pacMsg)
			else
				set d to d & pacMsg
			end if
		end if
		
		-- 如果没有任何信息，则表明所有文件均为最新版本
		if (d is equal to "") then set d to "所有文件已经为最新版本！"
		
		notify with name n title t description d application name growlName ¬
			icon of application growlIconApp
	end tell
end if
