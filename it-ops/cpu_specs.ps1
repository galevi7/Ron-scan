#Requires -Version 5.1
<#
.SYNOPSIS
    Ron's Brain CPU Specifications Report
    CerebralGit Export v3.7.2

.DESCRIPTION
    Displays detailed specifications of Ron's brain processing units.
    Pay attention to the Humor Processing Unit specs...
#>

$ErrorActionPreference = "Continue"

function Show-CPUReport {
    Write-Host ""
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   RON'S BRAIN - CPU SPECIFICATIONS REPORT" -ForegroundColor Cyan
    Write-Host "   CerebralGit Hardware Analysis" -ForegroundColor DarkCyan
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""

    $cpuSpecs = @(
        @{
            Name = "Frontal Processing Unit (FPU)"
            Cores = 8
            ClockSpeed = "3.2 GHz"
            Cache = "16 MB"
            Status = "OPTIMAL"
            Notes = "Handles decision making, planning, serious face maintenance"
            Vulnerabilities = @()
        }
        @{
            Name = "Emotional Processing Unit (EPU)"
            Cores = 4
            ClockSpeed = "2.8 GHz"
            Cache = "8 MB"
            Status = "THROTTLED"
            Notes = "Suppressed to 40% capacity by SeriousFace_Admins group policy"
            Vulnerabilities = @("CVE-2026-FEELS: Emotion buffer overflow when receiving unexpected compliments")
        }
        @{
            Name = "Memory Processing Unit (MPU)"
            Cores = 6
            ClockSpeed = "3.0 GHz"
            Cache = "32 MB"
            Status = "OPTIMAL"
            Notes = "Excellent recall, especially for embarrassing moments of others"
            Vulnerabilities = @()
        }
        @{
            Name = "Humor Processing Unit (HPU)"
            Cores = 2
            ClockSpeed = "0.4 GHz"
            Cache = "512 KB"
            Status = "CRITICALLY UNDERPOWERED"
            Notes = "Deliberately nerfed to prevent silly face generation. Only 2 cores allocated."
            Vulnerabilities = @(
                "CVE-2026-HAHA: Cannot process humor and maintain serious face simultaneously"
                "CVE-2026-BAZINGA: Crashes when unexpected context switch between sincere and absurd input"
                "CVE-2026-DADJOKE: Dad joke parser has known infinite loop vulnerability"
                "CVE-2026-CROSSEYE: Visual cortex interrupt when someone crosses their eyes unexpectedly"
            )
        }
        @{
            Name = "Motor Control Unit (MCU)"
            Cores = 4
            ClockSpeed = "2.5 GHz"
            Cache = "4 MB"
            Status = "OPTIMAL"
            Notes = "Controls facial muscles. Currently locked to 'serious' expression profile"
            Vulnerabilities = @("CVE-2026-TWITCH: Facial muscle override possible if EmotionOverride_Admins permission is exploited")
        }
        @{
            Name = "Social Awareness Unit (SAU)"
            Cores = 6
            ClockSpeed = "3.4 GHz"
            Cache = "12 MB"
            Status = "OVERCLOCKED"
            Notes = "Running at 142% capacity. This is why Ron always looks composed in photos."
            Vulnerabilities = @("CVE-2026-OVERLOAD: Will crash if too many social inputs arrive simultaneously")
        }
    )

    foreach ($cpu in $cpuSpecs) {
        $statusColor = switch ($cpu.Status) {
            "OPTIMAL"                { "Green" }
            "THROTTLED"              { "Yellow" }
            "CRITICALLY UNDERPOWERED" { "Red" }
            "OVERCLOCKED"            { "Magenta" }
            default                  { "White" }
        }

        Write-Host "  -----------------------------------------------" -ForegroundColor DarkGray
        Write-Host "  $($cpu.Name)" -ForegroundColor White
        Write-Host "    Cores:       $($cpu.Cores)" -ForegroundColor Gray
        Write-Host "    Clock Speed: $($cpu.ClockSpeed)" -ForegroundColor Gray
        Write-Host "    L2 Cache:    $($cpu.Cache)" -ForegroundColor Gray
        Write-Host "    Status:      $($cpu.Status)" -ForegroundColor $statusColor
        Write-Host "    Notes:       $($cpu.Notes)" -ForegroundColor DarkGray

        if ($cpu.Vulnerabilities.Count -gt 0) {
            Write-Host "    Known Vulnerabilities:" -ForegroundColor Red
            foreach ($vuln in $cpu.Vulnerabilities) {
                Write-Host "      [!] $vuln" -ForegroundColor Red
            }
        }
        Write-Host ""
    }

    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   SUMMARY" -ForegroundColor Cyan
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Total Processing Cores: 30" -ForegroundColor White
    Write-Host "  Humor Cores:            2 (6.7% of total - SUSPICIOUSLY LOW)" -ForegroundColor Red
    Write-Host "  Known CVEs:             7" -ForegroundColor Red
    Write-Host "  Critical CVEs:          4 (all in Humor Processing Unit)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  ASSESSMENT: Ron's brain has deliberately allocated minimal" -ForegroundColor Yellow
    Write-Host "  resources to humor processing. This is his defense against" -ForegroundColor Yellow
    Write-Host "  silly faces. But the HPU has FOUR known vulnerabilities." -ForegroundColor Yellow
    Write-Host "  The most exploitable: CVE-2026-BAZINGA (context switch crash)" -ForegroundColor Red
    Write-Host ""
}

Show-CPUReport
