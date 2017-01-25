# Check Nvidia Graphic Card Performance
# By jasem.elayeb@gmail.com
# 24.01.2017
# This Plugin provides Basic Functions,  current GPU Memeory Usage, GPU Usage, and current Temprature, with no Warning and alerting.
# To be Done, Critical and Warning thresholds
# 
# Before using this plugin Download and Install Nvidia-WMI-Driver    http://www.nvidia.com/object/nvwmi-driver.html
# NSClient.ini Config 
#	[/settings/external scripts/scripts]
#	check_nvidia = cmd /c echo scripts\\check_nvidia.ps1; exit($lastexitcode) | powershell.exe -NoProfile -command -
#

$computer = $env:COMPUTERNAME
$namespace = "ROOT\cimv2\NV"
$gpuclass = "Gpu"
$tempclass = "ThermalProbe"

$GPU_Meters=Get-WmiObject -Class $gpuclass -ComputerName $computer -Namespace $namespace | Select-Object *
$TEMP_Meters=Get-WmiObject -Class $tempclass -ComputerName $computer -Namespace $namespace | Select-Object *
$nvidia_model=$GPU_Meters.productName
$gpu_usage=$GPU_Meters.percentGpuUsage
$mem_usage=$GPU_Meters.percentGpuMemoryUsage
$temperature=$TEMP_Meters.temperature

$output = "Nvidia $nvidia_model Memory:$mem_usage% GPU:$gpu_usage% Temp:$Temperature°C | Memory=$mem_usage;;;0; GPU=$gpu_usage;;;0; TEMP=$temperature;;;0;"

Write-Output $Output

exit 0
