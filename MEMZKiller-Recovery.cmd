@echo off
title MEMZKiller Recovery
echo.
echo  MEMZKiller Recovery - SADECE Windows Kurtarma Ortami (WinRE)
echo  Bu arac boot kaydini onarmayi dener; dosyalari silmez.
echo.
set /p confirm=Devam etmek icin ONAR yazin: 
if /I not "%confirm%"=="ONAR" goto cancelled
echo.
echo [1/3] MBR onariliyor...
bootrec /fixmbr
echo [2/3] Boot sector onariliyor...
bootrec /fixboot
echo [3/3] BCD yeniden olusturuluyor...
bootrec /rebuildbcd
echo.
echo Tamamlandi. Ciktilari kontrol edin, sonra yeniden baslatin.
pause
exit /b
:cancelled
echo Iptal edildi.
pause
