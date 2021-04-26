@echo off
chcp 65001 >nul 2>nul
:: title BLOCK Win10AU!
mode con cols=80 lines=60
echo 禁用Windows10自动更新
echo 请先退出360等安全管家！
echo 请确认右键选择“以管理员身份运行”此脚本
echo.
:: echo 请按任意键继续，若需要取消，请按ctrl+c后确认... &pause>nul
 
echo ===============================================================================
echo 结束进程...
 
taskkill /im Windows10UpgraderApp.exe
del /f /q "%USERPROFILE%\Desktop\微软 Windows 10 易升.lnk"
del /f /q "%USERPROFILE%\Desktop\Windows 10 Update Assistant.lnk"
 
echo ===============================================================================
echo 添加防火墙规则中，请耐心等待...
 
netsh advfirewall firewall delete rule name="Block_Windows10UpgraderApp" >nul 2>nul
netsh advfirewall firewall add rule name="Block_Windows10UpgraderApp" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\Windows10UpgraderApp.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_WinREBootApp32" >nul 2>nul
netsh advfirewall firewall add rule name="Block_WinREBootApp32" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\WinREBootApp32.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_WinREBootApp64" >nul 2>nul
netsh advfirewall firewall add rule name="Block_WinREBootApp64" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\WinREBootApp64.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_bootsect" >nul 2>nul
netsh advfirewall firewall add rule name="Block_bootsect" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\bootsect.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_DW20" >nul 2>nul
netsh advfirewall firewall add rule name="Block_DW20" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\DW20.EXE" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_DWTRIG20" >nul 2>nul
netsh advfirewall firewall add rule name="Block_DWTRIG20" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\DWTRIG20.EXE" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_GatherOSState" >nul 2>nul
netsh advfirewall firewall add rule name="Block_GatherOSState" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\GatherOSState.EXE" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_GetCurrentRollback" >nul 2>nul
netsh advfirewall firewall add rule name="Block_GetCurrentRollback" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\GetCurrentRollback.EXE" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_HttpHelper" >nul 2>nul
netsh advfirewall firewall add rule name="Block_HttpHelper" dir=in program="%SYSTEMDRIVE%\Windows10Upgrade\HttpHelper.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_UpdateAssistant" >nul 2>nul
netsh advfirewall firewall add rule name="Block_UpdateAssistant" dir=in program="%SYSTEMROOT%\UpdateAssistant\UpdateAssistant.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_UpdateAssistantCheck" >nul 2>nul
netsh advfirewall firewall add rule name="Block_UpdateAssistantCheck" dir=in program="%SYSTEMROOT%\UpdateAssistant\UpdateAssistantCheck.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_Windows10Upgrade" >nul 2>nul
netsh advfirewall firewall add rule name="Block_Windows10Upgrade" dir=in program="%SYSTEMROOT%\UpdateAssistant\Windows10Upgrade.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_UpdateAssistantV2" >nul 2>nul
netsh advfirewall firewall add rule name="Block_UpdateAssistantV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\UpdateAssistant.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_UpdateAssistantCheckV2" >nul 2>nul
netsh advfirewall firewall add rule name="Block_UpdateAssistantCheckV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\UpdateAssistantCheck.exe" action=block >nul 2>nul
netsh advfirewall firewall delete rule name="Block_Windows10UpgradeV2" >nul 2>nul
netsh advfirewall firewall add rule name="Block_Windows10UpgradeV2" dir=in program="%SYSTEMROOT%\UpdateAssistantV2\Windows10Upgrade.exe" action=block >nul 2>nul
 
echo ==============================================================================
echo 设置系统自动更新软件权限为无权限...
 
echo y|cacls C:\Windows\UpdateAssistant\*.exe /t /p everyone:n
echo y|cacls C:\Windows10Upgrade\*.exe /t /p everyone:n
echo.
 
echo ==============================================================================
echo 设置注册表阻止更新服务重启...
 
if exist %SYSTEMDRIVE%\tepm.reg del /q /f %SYSTEMDRIVE%\tepm.reg
echo Windows Registry Editor Version 5.00 > %SYSTEMDRIVE%\tepm.reg
echo.>> %SYSTEMDRIVE%\tepm.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]>> %SYSTEMDRIVE%\tepm.reg
echo "DoNotConnectToWindowsUpdateInternetLocations"=dword:00000001 >> %SYSTEMDRIVE%\tepm.reg
 
echo "FailureActions"=hex:\>> %SYSTEMDRIVE%\tepm.reg
echo  80,46,7e,33,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00,03,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  14,00,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  60,ea,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00 >> %SYSTEMDRIVE%\tepm.reg
echo.>> %SYSTEMDRIVE%\tepm.reg
 
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]>> %SYSTEMDRIVE%\tepm.reg
echo "NoAutoUpdate"=dword:00000001>> %SYSTEMDRIVE%\tepm.reg
 
echo.>> %SYSTEMDRIVE%\tepm.reg
echo [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WaaSMedicSvc]>> %SYSTEMDRIVE%\tepm.reg
echo "start"=dword:00000004>> %SYSTEMDRIVE%\tepm.reg
echo "FailureActions"=hex:\>> %SYSTEMDRIVE%\tepm.reg
echo  80,46,7e,33,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00,03,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  14,00,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  60,ea,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00,00,00,00,00,\>> %SYSTEMDRIVE%\tepm.reg
echo  00,00,00,00 >> %SYSTEMDRIVE%\tepm.reg
echo.>> %SYSTEMDRIVE%\tepm.reg
REG IMPORT %SYSTEMDRIVE%\tepm.reg
del /q /f %SYSTEMDRIVE%\tepm.reg
 
echo ==============================================================================
 
echo 停止Windows Update服务...
net stop wuauserv
sc config wuauserv start= disabled
 
echo 停止 Windows Update Medic Service 服务...
net stop WaaSMedicSvc
sc config WaaSMedicSvc start= disabled
 
echo ==============================================================================
echo 删除自动更新相关的计划任务...
 
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistant" /f
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantAllUsersRun" /f
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantCalendarRun" /f
schtasks /delete /TN "\Microsoft\Windows\UpdateOrchestrator\UpdateAssistantWakeupRun" /f
 
echo ==============================================================================
echo 任务结束，程序将自动退出...
echo.
:: echo 请检查执行日志，是否有异常! &pause>nul
exit
