@echo off
color 0A
title 3389���Ӻۼ����bat
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Terminal Server Client" /f
del /a /f /q %HOMEPATH%\Documents\Default.rdp
del /a /f /q %HOMEPATH%\Documents\Զ������\Default.rdp
echo ����ִ�гɹ������ֶ��鿴�Ƿ������
ping 127.0.0.1 -c 5 > nul
exit