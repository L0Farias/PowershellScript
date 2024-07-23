for /f %%f in ('type drive') do set drive=%%f
dir %drive%\custom\start* | findstr /e ".bat" >nul
if %errorlevel%==0 (%drive%\custom\start.bat) else (powershell -File %drive%\custom\start.ps1)
