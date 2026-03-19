#Requires -Version 5.1
<#
.SYNOPSIS
    Ron's Brain Active Directory Management
    CerebralGit Export v3.7.2

.DESCRIPTION
    Displays the complete Active Directory structure of Ron's brain,
    including Organizational Units, Users, Groups, and memberships.

    There's a permissions misconfiguration hidden in the group nesting.
    Can you find it?
#>

$ErrorActionPreference = "Continue"

# ============================================================
# BRAIN ACTIVE DIRECTORY SCHEMA
# ============================================================

$OUs = @(
    @{ Name = "FrontalLobe";    Description = "Decision making and expression control" }
    @{ Name = "TemporalLobe";   Description = "Memory and emotional processing" }
    @{ Name = "Cerebellum";     Description = "Motor control and coordination" }
    @{ Name = "BrainStem";      Description = "Core autonomic functions" }
    @{ Name = "Amygdala";       Description = "Emotional responses and fear" }
)

$Users = @(
    @{ Name = "Ron";              OU = "FrontalLobe";  Title = "Primary Consciousness"; Enabled = $true }
    @{ Name = "SubconsciousRon";  OU = "TemporalLobe"; Title = "Background Processor";  Enabled = $true }
    @{ Name = "EmotionalRon";     OU = "Amygdala";     Title = "Feeling Handler";       Enabled = $true }
    @{ Name = "MotorControlRon";  OU = "Cerebellum";   Title = "Movement Coordinator";  Enabled = $true }
    @{ Name = "ReflexRon";        OU = "BrainStem";    Title = "Automatic Responder";   Enabled = $true }
    @{ Name = "HumorDaemon";      OU = "TemporalLobe"; Title = "Humor Processor";       Enabled = $false }  # DISABLED!
)

$Groups = @(
    @{
        Name = "SeriousFace_Admins"
        Description = "Controls serious facial expression - DENY SillyFace.exe"
        Members = @("Ron")
        DeniedPrograms = @("SillyFace.exe", "Giggle.dll", "Smirk.sys")
    }
    @{
        Name = "ExpressionLock_Group"
        Description = "Locks facial expressions to approved list"
        Members = @("Ron", "MotorControlRon")
        DeniedPrograms = @("SillyFace.exe")
    }
    @{
        Name = "FrontalLobe_Users"
        Description = "General frontal lobe access"
        Members = @("Ron", "SubconsciousRon")
        SubGroups = @("CortexControl_Group")  # <-- NESTED GROUP!
    }
    @{
        Name = "CortexControl_Group"
        Description = "Advanced cortex control functions"
        Members = @("SubconsciousRon")
        SubGroups = @("EmotionOverride_Admins")  # <-- ANOTHER NESTING LEVEL!
    }
    @{
        Name = "EmotionOverride_Admins"
        Description = "Emergency emotion override capabilities"
        Members = @("EmotionalRon")
        AllowedPrograms = @("SillyFace.exe", "Laugh.exe", "Cry.exe", "Surprise.exe")
        # ^^ THIS GROUP ALLOWS SillyFace.exe!
        # Ron is in FrontalLobe_Users -> CortexControl_Group -> EmotionOverride_Admins
        # Through nested membership, Ron INHERITS SillyFace.exe permission!
    }
    @{
        Name = "HumorProcessing_Group"
        Description = "Handles humor detection and response"
        Members = @("HumorDaemon", "SubconsciousRon")
        AllowedPrograms = @("Chuckle.exe")
        # Note: HumorDaemon account is DISABLED but still in the group
    }
    @{
        Name = "AutoResponse_Group"
        Description = "Automatic/reflex responses"
        Members = @("ReflexRon")
        AllowedPrograms = @("Blink.exe", "Flinch.exe", "Startle.exe")
    }
)

# ============================================================
# DISPLAY FUNCTIONS
# ============================================================

function Show-Header {
    Write-Host ""
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host "   RON'S BRAIN - ACTIVE DIRECTORY MANAGEMENT CONSOLE" -ForegroundColor Cyan
    Write-Host "   CerebralGit Export v3.7.2" -ForegroundColor DarkCyan
    Write-Host "  ====================================================" -ForegroundColor Cyan
    Write-Host ""
}

function Show-OUs {
    Write-Host "  ORGANIZATIONAL UNITS:" -ForegroundColor Yellow
    Write-Host "  ----------------------" -ForegroundColor DarkYellow
    foreach ($ou in $OUs) {
        Write-Host "    OU=$($ou.Name)" -ForegroundColor Green -NoNewline
        Write-Host " - $($ou.Description)" -ForegroundColor Gray
    }
    Write-Host ""
}

function Show-Users {
    Write-Host "  USER ACCOUNTS:" -ForegroundColor Yellow
    Write-Host "  ----------------------" -ForegroundColor DarkYellow
    foreach ($user in $Users) {
        $status = if ($user.Enabled) { "[ENABLED] " } else { "[DISABLED]" }
        $color = if ($user.Enabled) { "Green" } else { "Red" }
        Write-Host "    $status " -ForegroundColor $color -NoNewline
        Write-Host "$($user.Name)" -ForegroundColor White -NoNewline
        Write-Host " (OU=$($user.OU), Title=$($user.Title))" -ForegroundColor Gray
    }
    Write-Host ""
}

function Show-Groups {
    Write-Host "  SECURITY GROUPS:" -ForegroundColor Yellow
    Write-Host "  ----------------------" -ForegroundColor DarkYellow
    foreach ($group in $Groups) {
        Write-Host "    GROUP: $($group.Name)" -ForegroundColor Magenta
        Write-Host "      Description: $($group.Description)" -ForegroundColor Gray
        Write-Host "      Members: $($group.Members -join ', ')" -ForegroundColor White

        if ($group.SubGroups) {
            Write-Host "      Sub-Groups: $($group.SubGroups -join ', ')" -ForegroundColor Cyan
        }
        if ($group.DeniedPrograms) {
            Write-Host "      DENIED: $($group.DeniedPrograms -join ', ')" -ForegroundColor Red
        }
        if ($group.AllowedPrograms) {
            Write-Host "      ALLOWED: $($group.AllowedPrograms -join ', ')" -ForegroundColor Green
        }
        Write-Host ""
    }
}

function Show-GroupHierarchy {
    Write-Host "  GROUP NESTING HIERARCHY:" -ForegroundColor Yellow
    Write-Host "  ----------------------" -ForegroundColor DarkYellow
    Write-Host "    Ron" -ForegroundColor White
    Write-Host "     +-- SeriousFace_Admins" -ForegroundColor Red -NoNewline
    Write-Host " [DENY SillyFace.exe]" -ForegroundColor DarkRed
    Write-Host "     +-- ExpressionLock_Group" -ForegroundColor Red -NoNewline
    Write-Host " [DENY SillyFace.exe]" -ForegroundColor DarkRed
    Write-Host "     +-- FrontalLobe_Users" -ForegroundColor Yellow
    Write-Host "          +-- CortexControl_Group" -ForegroundColor Yellow
    Write-Host "               +-- EmotionOverride_Admins" -ForegroundColor Green -NoNewline
    Write-Host " [ALLOW SillyFace.exe !!!]" -ForegroundColor Green
    Write-Host ""
    Write-Host "    WARNING: Nested group membership creates ALLOW path!" -ForegroundColor Red
    Write-Host ""
}

# ============================================================
# MAIN
# ============================================================

Show-Header
Show-OUs
Show-Users
Show-Groups
Show-GroupHierarchy

Write-Host "  Run permissions_audit.ps1 for full security analysis." -ForegroundColor Cyan
Write-Host ""
