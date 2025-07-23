# Neovim Performance Benchmarking Script
# This script measures Neovim startup times and analyzes performance

param(
    [int]$Runs = 10,
    [switch]$Verbose,
    [string]$OutputFile = "nvim_benchmark_results.txt"
)

Write-Host "Neovim Performance Benchmark" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan

# Function to measure startup time
function Measure-NvimStartup {
    param(
        [string]$TestName,
        [string[]]$Args = @()
    )
    
    $times = @()
    Write-Host "Running $TestName ($Runs runs)..." -ForegroundColor Yellow
    
    for ($i = 1; $i -le $Runs; $i++) {
        if ($Verbose) { Write-Host "  Run $i/$Runs" -ForegroundColor Gray }
        
        $startTime = Get-Date
        $process = Start-Process -FilePath "nvim" -ArgumentList ($Args + @("--headless", "+qa")) -Wait -PassThru -NoNewWindow
        $endTime = Get-Date
        
        $duration = ($endTime - $startTime).TotalMilliseconds
        $times += $duration
        
        if ($Verbose) { Write-Host "    Time: $([math]::Round($duration, 2))ms" -ForegroundColor Gray }
    }
    
    $avg = ($times | Measure-Object -Average).Average
    $min = ($times | Measure-Object -Minimum).Minimum
    $max = ($times | Measure-Object -Maximum).Maximum
    $median = ($times | Sort-Object)[[math]::Floor($times.Count / 2)]
    
    return @{
        TestName = $TestName
        Average = [math]::Round($avg, 2)
        Minimum = [math]::Round($min, 2)
        Maximum = [math]::Round($max, 2)
        Median = [math]::Round($median, 2)
        AllTimes = $times
    }
}

# Clear any previous results
if (Test-Path $OutputFile) { Remove-Item $OutputFile }

# Test scenarios
$results = @()

# 1. Normal startup
$results += Measure-NvimStartup "Normal Startup"

# 2. Startup with profiling
$results += Measure-NvimStartup "Startup with Profiling" @("--startuptime", "startup.log")

# 3. Minimal startup (no plugins)
$results += Measure-NvimStartup "Minimal Startup" @("-u", "NONE")

# 4. Startup with specific file
$testFile = "test_file.txt"
"Sample content for testing" | Out-File -FilePath $testFile -Encoding UTF8
$results += Measure-NvimStartup "Startup with File" @($testFile)

# Display results
Write-Host "`nBENCHMARK RESULTS" -ForegroundColor Green
Write-Host "==================" -ForegroundColor Green

$output = @()
$output += "Neovim Performance Benchmark Results"
$output += "Generated: $(Get-Date)"
$output += "System: $env:COMPUTERNAME - $env:OS"
$output += "Runs per test: $Runs"
$output += ""

foreach ($result in $results) {
    $line = "{0,-25} | Avg: {1,7}ms | Min: {2,7}ms | Max: {3,7}ms | Median: {4,7}ms" -f 
        $result.TestName, $result.Average, $result.Minimum, $result.Maximum, $result.Median
    
    Write-Host $line -ForegroundColor White
    $output += $line
}

# Save results to file
$output += ""
$output += "Detailed timing data:"
foreach ($result in $results) {
    $output += "$($result.TestName): $($result.AllTimes -join ', ')ms"
}

$output | Out-File -FilePath $OutputFile -Encoding UTF8

Write-Host "`nResults saved to: $OutputFile" -ForegroundColor Cyan

# Cleanup
if (Test-Path $testFile) { Remove-Item $testFile }

# Check for startup.log and provide analysis
if (Test-Path "startup.log") {
    Write-Host "`nStartup profiling log created: startup.log" -ForegroundColor Cyan
    Write-Host "Use 'nvim startup.log' to view detailed timing breakdown" -ForegroundColor Gray
}

Write-Host "`nBenchmark complete!" -ForegroundColor Green