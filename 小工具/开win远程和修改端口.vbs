Set WshShell=CreateObject("Wscript.Shell")

Function Imput()
	imputport = InputBox("������һ���˿ںţ�ע�⣺����˿ں�Ŀǰ���ܱ���������ʹ�ã������Ӱ���ն˷���","����Զ�̺͸����ն˶˿ں�", "3389", 10, 10)

If imputport<>"" Then
	If IsNumeric(imputport) Then
		opentemi = "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\" 
		WshShell.RegWrite opentemi&"fDenyTSConnections",0,"REG_DWORD" 

		path1 = "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\Tds\tcp\"
		WshShell.RegWrite path1&"PortNumber",imputport,"REG_DWORD"
			
		path2 = "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\"
		WshShell.RegWrite path2&"PortNumber",imputport,"REG_DWORD"
		
		wscript.echo "�����ɹ�"
	Else wscript.echo "�����������������"
		Imput()
	

	End If
		Else wscript.echo "�����Ѿ�ȡ��"
	End If
End Function
Imput()
set WshShell = nothing


