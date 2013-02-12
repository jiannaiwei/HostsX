DNS 转发器 V2.3

此版本大部分的配置通过配置文件进行 (详见配置文件)，但保留了少数命令行参数。

dnsforwarder.exe [参数]
 [参数] 是区分大小写的
  -f <FILE>  指定配置文件。
  -q         安静模式。不显示任何信息。
  -e         只显示错误信息。
  -d         后台模式。
  -h         显示此帮助。

使用方法：
打开此程序后，将DNS设置为127.0.0.1

配置文件不是 XML 格式，用普通的文本编辑器即可。


http://micasmica.blogspot.com/2011/08/dns.html
http://micasmica.blogspot.tw/2011/08/dns.html

在命令提示符中执行 “nslookup www.google.com 127.0.0.1”可以看到效果。
 
#  cn域名
ExcludedDomain .cn,*cdn*
#  百度
ExcludedDomain bdstatic.com,bdimg.com,baidu.com,hao123.com,qianqian.com,skycn.com,baifubao.com,regsky.com,baidupcs.com,baidupcs.net
#  腾讯
ExcludedDomain qq.com,tencent.com,gtimg.com,3366.com,qzone.com,soso.com,tdimg.com,qstatic.com,paipaiimg.com,qqmail.com,pengyou.com,idqqimg.com
#  搜狐
ExcludedDomain sohu.com,sogou.com
#  新浪
ExcludedDomain weibo.com
#  网易
ExcludedDomain 163.com,126.com,126.net,127.net
#  优酷
ExcludedDomain youku.com,youku.tv,ykimg.com
#  土豆
ExcludedDomain tudou.com,tudouui.com
#  支付宝
ExcludedDomain alipay.com
#  其他视频网站
ExcludedDomain pplive.com,yinyuetai.com,letv.com,letvimg.com,ku6.com
#  京东商城
ExcludedDomain 360buy.com,360buyimg.com,360top.com
#  人人
ExcludedDomain renren.com,renren-inc.com,xnimg.cn
#  暴风
ExcludedDomain baofeng.com,baofeng.net
#  VeryCD
ExcludedDomain verycd.com,easymule.com,vcimg.com
#  迅雷
ExcludedDomain xunlei.com,gougou.com,kankan.com
#  360
ExcludedDomain 360safe.com,qhimg.com
#  银行
ExcludedDomain abchina.com,ccb.com,bankcomm.com,cmbchina.com,psbc.com,cebbank.com,pingan.com,ecitic.com,unionpay.com
#  其它
ExcludedDomain duotegame.com,hexun.com,xinhuanet.com,chinaunix.net,csdn.net,mop.com,fetionpic.com,kugou.com,hudong.com,kedou.com
#  Domain pointer
ExcludedDomain in-addr.arpa,ip6.arpa

禁止所有带有ad的域名的查询:
DisabledDomain *ad*
DisabledDomain *material*,*tongji*,*allyes*,*analytics*,*ggao*,*counter*,*cpm*

从网络载入Hosts并显示文件内容:
Hosts http://hostsx.googlecode.com/svn/trunk/HostsX.orzhosts
HostsDownloadPath C:\Windows\System32\drivers\etc\hosts
HostsScript type C:\Windows\System32\drivers\etc # `type' 为 Windows 控制台命令

AppendHosts 59.151.106.253 *.operachina.com
AppendHosts 203.69.113.128 *.phobos.apple.com

禁止所有com域名的查询:
DisabledDomain .com

除谷歌外全部使用UDP查询:
UDPServer 114.114.114.114 # 您可以指定其他的 UDP 服务器
PrimaryServer UDP
ExcludedDomain *.google.*,googleusercontent.com,googleadservices.com
