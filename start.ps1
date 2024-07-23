mode 50,15
Add-Type -AssemblyName PresentationCore,PresentationFramework
$log = {if ($exitCode.ExitCode -eq 0){Write-Host " Sucesso" -f Green}else{Write-Host " Erro" -f Red}}
while ($true){
    $explorer = Get-Process | ? {$_.name -eq "explorer"}
    if ($explorer){taskkill /im explorer.exe /f}
    break
}

cls
Write-Host "Instalando Softwares" -f Green 
""
Write-Host "Instalando Office..." -NoNewline
$officeDirFiles = $PSScriptRoot + '\office\Office2021'
$officeSetupFiles = $PSScriptRoot + '\office\config_temp.xml'
$xml = (Get-Content $PSScriptRoot\office\config.xml).Replace("Office2021Path",$officeDirFiles)
$xml > $officeSetupFiles
$exitCode = Start-Process $PSScriptRoot\office\setup.exe -ArgumentList "/configure $PSScriptRoot\office\config_temp.xml" -Wait -WindowStyle Hidden -PassThru
rd $officeSetupFiles -Force -Confirm:$false
&$log
sleep 10

Write-Host "Instalando Foxit Pdf Reader..." -NoNewline
$exitCode = Start-Process $PSScriptRoot\FoxitPDFReader20232.exe -ArgumentList "/sAll" -Wait -PassThru
&$log
sleep 10

Write-Host "Instalando Chrome..." -NoNewline
$exitCode = Start-Process $PSScriptRoot\chrome.msi -ArgumentList "/qn" -Wait -PassThru
&$log
sleep 10

Write-Host "Instalando Firefox..." -NoNewline
$exitCode = Start-Process $PSScriptRoot\Firefox Setup 117.0.1.exe -ArgumentList "/qn" -Wait -PassThru
&$log
sleep 10

Write-Host "Instalando WinRAR..." -NoNewline
$exitCode = Start-Process $PSScriptRoot\winrar.exe -ArgumentList "/S" -Wait -PassThru
&$log

$msg = [System.Windows.MessageBox]::Show("Instalação concluída!`nClique em ""Ok"" para finalizar e reiniciar o computador.",'Instalação do sistema','Ok','Information')
shutdown /r /f /t 0