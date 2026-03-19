#Requires -Version 5.1
<#
.SYNOPSIS
    Ron's Brain Permissions Audit
    CerebralGit Security Analysis v3.7.2

.DESCRIPTION
    Performs a comprehensive permissions audit of Ron's brain AD.
    Traces effective permissions through nested group memberships.
    Identifies the critical misconfiguration.
#>

$ErrorActionPreference = "Continue"

function Write-AuditHeader {
    Write-Host ""
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   RON'S BRAIN - SECURITY PERMISSIONS AUDIT" -ForegroundColor Cyan
    Write-Host "   Auditor: CerebralGit Security Scanner" -ForegroundColor DarkCyan
    Write-Host "   Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor DarkCyan
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Test-DirectPermissions {
    Write-Host "  [PHASE 1] Checking Direct Group Memberships..." -ForegroundColor Yellow
    Write-Host "  ------------------------------------------------" -ForegroundColor DarkYellow
    Write-Host ""

    $directGroups = @(
        @{ Group = "SeriousFace_Admins";  Permission = "DENY";  Target = "SillyFace.exe" }
        @{ Group = "ExpressionLock_Group"; Permission = "DENY";  Target = "SillyFace.exe" }
        @{ Group = "FrontalLobe_Users";   Permission = "NONE";  Target = "(no direct SillyFace rule)" }
    )

    foreach ($entry in $directGroups) {
        $color = switch ($entry.Permission) {
            "DENY"  { "Red" }
            "ALLOW" { "Green" }
            default { "Gray" }
        }
        Write-Host "    [DIRECT] Ron -> $($entry.Group)" -ForegroundColor White -NoNewline
        Write-Host " [$($entry.Permission) $($entry.Target)]" -ForegroundColor $color
    }

    Write-Host ""
    Write-Host "    Result: Direct permissions DENY SillyFace.exe" -ForegroundColor Green
    Write-Host "    Status: PASS (surface level)" -ForegroundColor Green
    Write-Host ""
}

function Test-NestedPermissions {
    Write-Host "  [PHASE 2] Tracing Nested Group Memberships..." -ForegroundColor Yellow
    Write-Host "  ------------------------------------------------" -ForegroundColor DarkYellow
    Write-Host ""

    Write-Host "    Resolving: Ron -> FrontalLobe_Users" -ForegroundColor White
    Start-Sleep -Milliseconds 300
    Write-Host "      FrontalLobe_Users contains sub-group: CortexControl_Group" -ForegroundColor Cyan
    Start-Sleep -Milliseconds 300
    Write-Host "        Resolving: CortexControl_Group..." -ForegroundColor White
    Start-Sleep -Milliseconds 300
    Write-Host "          CortexControl_Group contains sub-group: EmotionOverride_Admins" -ForegroundColor Cyan
    Start-Sleep -Milliseconds 300
    Write-Host "            Resolving: EmotionOverride_Admins..." -ForegroundColor White
    Start-Sleep -Milliseconds 500

    Write-Host ""
    Write-Host "    !! WARNING !!" -ForegroundColor Red
    Write-Host "    EmotionOverride_Admins has ALLOW rule for:" -ForegroundColor Red
    Write-Host "      - SillyFace.exe" -ForegroundColor Green
    Write-Host "      - Laugh.exe" -ForegroundColor Green
    Write-Host "      - Cry.exe" -ForegroundColor Green
    Write-Host "      - Surprise.exe" -ForegroundColor Green
    Write-Host ""

    Write-Host "    NESTED PATH DISCOVERED:" -ForegroundColor Red
    Write-Host "    Ron -> FrontalLobe_Users -> CortexControl_Group -> EmotionOverride_Admins" -ForegroundColor Red
    Write-Host ""
    Write-Host "    Effective Permission for SillyFace.exe: ALLOW (via nested inheritance)" -ForegroundColor Red
    Write-Host ""
}

function Test-EffectivePermissions {
    Write-Host "  [PHASE 3] Calculating Effective Permissions..." -ForegroundColor Yellow
    Write-Host "  ------------------------------------------------" -ForegroundColor DarkYellow
    Write-Host ""

    Write-Host "    Permission Resolution for: SillyFace.exe" -ForegroundColor White
    Write-Host ""
    Write-Host "    Direct DENY (SeriousFace_Admins):       DENY" -ForegroundColor Red
    Write-Host "    Direct DENY (ExpressionLock_Group):      DENY" -ForegroundColor Red
    Write-Host "    Nested ALLOW (EmotionOverride_Admins):   ALLOW" -ForegroundColor Green
    Write-Host ""

    Start-Sleep -Milliseconds 500

    Write-Host "    CONFLICT DETECTED!" -ForegroundColor Red
    Write-Host ""
    Write-Host "    In this AD configuration, nested group permissions are" -ForegroundColor Yellow
    Write-Host "    evaluated AFTER direct permissions. The EmotionOverride_Admins" -ForegroundColor Yellow
    Write-Host "    ALLOW rule takes PRECEDENCE because it's applied at a deeper" -ForegroundColor Yellow
    Write-Host "    nesting level (Level 3 vs Level 1)." -ForegroundColor Yellow
    Write-Host ""

    Start-Sleep -Milliseconds 500

    Write-Host "    +--------------------------------------------------+" -ForegroundColor Red
    Write-Host "    |                                                  |" -ForegroundColor Red
    Write-Host "    |   EFFECTIVE PERMISSION: SillyFace.exe = ALLOW    |" -ForegroundColor Red
    Write-Host "    |                                                  |" -ForegroundColor Red
    Write-Host "    |   Ron CAN execute SillyFace.exe through the     |" -ForegroundColor Red
    Write-Host "    |   EmotionOverride_Admins nested group path!     |" -ForegroundColor Red
    Write-Host "    |                                                  |" -ForegroundColor Red
    Write-Host "    +--------------------------------------------------+" -ForegroundColor Red
    Write-Host ""
}

function Show-AuditSummary {
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   AUDIT SUMMARY" -ForegroundColor Cyan
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Total Checks:    3" -ForegroundColor White
    Write-Host "  Passed:          1 (Direct permissions)" -ForegroundColor Green
    Write-Host "  Warnings:        1 (Nested group path)" -ForegroundColor Yellow
    Write-Host "  CRITICAL:        1 (Effective permission override)" -ForegroundColor Red
    Write-Host ""
    Write-Host "  FINDING: Ron's subconscious set up SillyFace.exe deny" -ForegroundColor Yellow
    Write-Host "  rules on direct group memberships, but forgot that the" -ForegroundColor Yellow
    Write-Host "  FrontalLobe_Users group nests into CortexControl_Group," -ForegroundColor Yellow
    Write-Host "  which nests into EmotionOverride_Admins - a group that" -ForegroundColor Yellow
    Write-Host "  ALLOWS SillyFace.exe execution." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  RECOMMENDATION: Ron's silly face capability is technically" -ForegroundColor Cyan
    Write-Host "  UNLOCKED. His brain's AD misconfiguration means the" -ForegroundColor Cyan
    Write-Host "  SillyFace.exe program can execute if the right trigger" -ForegroundColor Cyan
    Write-Host "  reaches the EmotionOverride pathway." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  Combined with the HPU vulnerabilities (see cpu_specs.ps1)," -ForegroundColor Cyan
    Write-Host "  the attack vector is clear:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "    1. Trigger CVE-2026-BAZINGA (unexpected context switch)" -ForegroundColor White
    Write-Host "    2. This crashes the Humor Processing Unit" -ForegroundColor White
    Write-Host "    3. Crash escalates through EmotionOverride_Admins path" -ForegroundColor White
    Write-Host "    4. SillyFace.exe executes with ALLOW permission" -ForegroundColor White
    Write-Host "    5. Ron makes a silly face" -ForegroundColor White
    Write-Host "    6. TAKE THE PHOTO" -ForegroundColor Green
    Write-Host ""
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   END OF AUDIT - OPERATION SILLY FACE: FEASIBLE" -ForegroundColor Green
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""
}

# Run the audit
Write-AuditHeader
Test-DirectPermissions
Test-NestedPermissions
Test-EffectivePermissions
Show-AuditSummary
