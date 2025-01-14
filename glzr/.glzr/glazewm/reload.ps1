taskkill /IM zebar.exe /F
taskkill /IM tacky-borders.exe /F
Start-Process zebar -NoNewWindow
sleep 10
Start-Process C:\Users\bart\Apps\tacky-borders.exe -NoNewWindow
exit
