
特别感谢longsan168对于p处理方面的建议，修改意见，专业上的提醒，以及技术上的支持！
特别感谢sunnyboy8888，vcAngel对于数据方面给我的参考和建议；
特别感谢爽爽亲手绘制的图标~一个卡哇伊的小猴子~ 摸摸~娃哈哈；

--------------------------------------------------------
曾使用过的部分数据或代码来自于：世界之窗论坛，
Proxomitron中文站，赢政天下论坛（孤星释狼等），豆瓣小组，
完美者精品论坛（烈火等），霏凡论坛（雪山猎人），
Opera论坛（EZibo等）；夜雨十三天，lingshao（迅雷等），
pt42 soft，sino blog等，X林的网站屏蔽工具的批处理代码，
部分深山红叶维护光盘里的批处理内容，在此表示感谢！
--------------------------------------------------------
感谢未央生，fyi151，lyplay，对于域名转向的建议；
感谢 mickeymouse 对于Hosts的解答；
感谢 bucket，0Cat0 对于fs2u数据的建议；
感谢 hudike，zwy11等对于早期数据的一些误过滤；
感谢 laovo 提供的Hosts修复工具；
感谢 深度诱惑 反馈的百度图片误过滤问题；
感谢 zwy11 对于Blogger，YouTube等GFW相关问题方面的知识普及；
感谢 sebaby 对于数据整理方面和色情网站屏蔽以及数据及时性方面的建议；
感谢 hgldg 等对于色情网站屏蔽方面的建议；
感谢 harveylee 提供的Xmarks的相关数据；
感谢 youth9999 对于土豆网相关问题的建议；
感谢 move 峰旭 等提出的关于自动更新的建议；
感谢 北风其凉 给出的关于UUSEE的建议；
感谢 theshuang 给出的关于搜狗拼音以及银行ssl验误过滤的相关意见；
感谢 laotongbao 给出的增加webgame的相关意见，并感谢其共享的数据；
感谢 fjj0310 sebaby 等对于QQ弹出Hosts修改提示的提醒；
感谢 daewoo223 对于盛大误过滤的反馈；
感谢 xwan008对于灵格斯翻译的相关功能误过滤的提醒；
感谢 wupeng_84对于WMP的过滤提出的相关意见；
感谢 33W66 0Cat0 对于驱动之家过滤后不能显示评论数目的提醒；
感谢 macemo对于P处理执行后显示结果的相关建议；
感谢 夜色茫茫 的不吝夸赞；
感谢 fyi151 sebaby 对于后续版本中的一些小bug的反馈以及相关修改意见；
感谢 汤成翥 给出的关于谷歌拼音同步的问题的建议；
感谢 toshiba 对于百度图片搜索误过滤的反馈；
感谢 YYUU 给出的部分建议和支持；
感谢 mecal 对于不同系统环境下的P处理执行给出的反馈；
感谢 samcsli 对于数据以及其他方面的建议和意见；
感谢 ch4sedream 给出的DropBox的新Ip；
感谢 深度诱惑 反馈的Webqq的登录误过滤问题；
感谢 H2O2 aleax 等对于Xmarks给出的更新建议；
感谢博客上的一些朋友反馈的Vista和Win7的相关问题。
感谢 徐俊 反馈的诸多网页的细节问题。
感谢 bark 基于G+数据整理的恶意行为网站，已并入进程中。


常见问题和帮助：
--------------------------------------------------------
File Location:
Windows9x: %windir%\hosts
Windows32: %windir%\system32\drivers\etc\hosts
Windows64: %windir%\system64\drivers\etc\hosts
Ubuntu:    sudo gedit /etc/hosts
重启网络：sudo /etc/init.d/networking restart
!Ubuntu关闭IPv6
编辑 /etc/modprobe.d/aliases
修改:alias net-pf-10 ipv6 为:alias net-pf-10 off
Mac:       sudo niload -v -m hosts
对于广告屏蔽建议使用0.0.0.0，对于验证屏蔽建议使用127.0.0.1
--------------------------------------------------------
常见问题答疑：
1.关于最近一些朋友反馈的脚本错误等问题，
如sopcast等的请使用Pavel的sopcast去广告补丁试试
--------------------------------------------------------
Acrylic安装使用说明：
在cmd下运行ipconfig /all
1.找到 DNS Servers 后面的那个 IP 地址并记下来，比如是 212.216.112.112;
2.打开 AcrylicConfiguration.ini，把这个 IP 地址填到 PrimaryServerAddress=后面;
3.修改你的本地连接里面的 DNS 地址：在控制面板找到网络连接，选中 TCP/IP，点击属性，勾选使用下面的 DNS 服务器地址，在首选 DNS 服务器里输入 127.0.0.1; 
4.保存之后运行AcrylicTool.bat即可; 
--------------------------------------------------------
黑底湖蓝字(03)  黑底白字(07) 红底亮白字(4f)
紫底白字(5f)  亮白底黑字(f0) 绿底白字(2f)                                 
背景 文字 color %a%%b%：0.黑色1.蓝色2.绿色3.浅绿色4.红色 5.紫色
6.黄色7.白色8.灰色9.浅蓝色 A.浅绿B.浅蓝C.浅红D.淡紫E.浅黄F.亮白
-------------------------------------------------------------------
如何使用ipv6登录

以下是不同的作业系统的IPV6设置方法

1. Windows XP：在CMD执行以下指令

程序代码:
ipv6 install

2. Vista与Win7:
a. 事先在网上搜索可用的“ISATAP隧道点IP”(注1)取代下方的 XX.XX.XX.XX
b. 在CMD执行以下指令

程序代码:
net start iphlpsvc
sc config iphlpsvc start= auto
netsh interface ipv6 isatap set state enabled
netsh interface ipv6 isatap set router XX.XX.XX.XX

3. Mac OS X
V10.2(Jaguar)以后的Mac OS都捆绑了IPv6,而Mac OS 9则还没有任何的IPv6支持。
a. 打开终端窗口。输入 /sbin/ifconfig -a 列出所有接口。你应该能看到类似这样的信息:

程序代码:
en0: flags=8863 mtu 1500
inet6 fe80::203:93ff:fe67:80b2%en0 prefixlen 64 scopeid 0x4
ether 00:03:93:67:80:b2
inet 192.168.1.101 netmask 0xffffff00 broadcast 192.168.1.255
media: autoselect (none) status: active

b. 找到标记 status: active 的那个接口,通常会是en0。如果不是,切记在后续的操作中用实际接口替换。输入:
程序代码:
sudo ip6config start-v6 en0; sudo ip6config start-stf en0


4. 测试线上IPv6 网站, 如果能正常出现画面就表示IPV6设置正确且可用
http://ipv6.google.com
5. 更多的OS配置方法请参阅以下网页：
http://www.ipv6day.org/action.php?n=Sicn.Configuration

注1:
在此提供些许“ISATAP隧道点IP”，其他请自行上网查找

上海 isatap.sjtu.edu.cn
德国 isatap.UNI-MUENSTER.DE
台湾 nc9.giga.net.tw
台湾 isatap.ipv6.chttl.com.tw
韩国 isatap.ngix.ne.kr
波兰 isatap.icpnet.pl
