# IT Operations - Ron's Brain Active Directory

> **Agent 5 - Your Mission: Audit Ron's Brain Active Directory permissions
> and find the nested group misconfiguration that grants SillyFace access.**

## Background

Ron's brain runs an Active Directory system that controls which facial
expressions have permission to execute. His IT team (subconscious mind)
has set up security groups to keep `SillyFace.exe` locked down. But
there's a permissions misconfiguration hidden in nested group memberships.

There's also a CPU specs report that reveals some interesting details about
Ron's brain processing power (and its limitations).

## Prerequisites

- PowerShell (Linux: `sudo apt install powershell` or `sudo dnf install powershell`)
- Or just read the scripts and trace the logic manually

## Running on Linux/Mac

If you don't have PowerShell, you can install it:

```bash
# Fedora
sudo dnf install powershell

# Ubuntu/Debian
sudo apt install powershell

# Then run scripts with:
pwsh ./brain_ad_management.ps1
pwsh ./cpu_specs.ps1
pwsh ./permissions_audit.ps1
```

Or just read the scripts - the vulnerability is in the code itself.

## Step 1: Review Brain AD Structure

```bash
pwsh ./brain_ad_management.ps1
```

This shows the complete AD structure - OUs, Users, Groups, and their
memberships. Pay attention to the group hierarchy.

## Step 2: Check CPU Specs

```bash
pwsh ./cpu_specs.ps1
```

Look at Ron's brain specs. There's something funny in the processing
capabilities report.

## Step 3: Run the Permissions Audit

```bash
pwsh ./permissions_audit.ps1
```

This runs a security audit. Read the output carefully - there are WARNINGS
and one CRITICAL finding.

## Investigation Guide

1. **Map the group hierarchy** - Draw out which groups contain which
   sub-groups. Follow the nesting.
2. **Find Ron's effective permissions** - His account is in specific groups.
   Trace through ALL nested memberships.
3. **Look for the contradiction** - One group denies SillyFace, but a
   nested path grants it. Which one wins?
4. **Check the CPU specs Easter egg** - There's a processing limitation
   that's... suspicious.

## Hints (read only if stuck)

<details>
<summary>Hint 1 - The group structure</summary>

```
Ron is member of:
  -> SeriousFace_Admins (DENY SillyFace.exe)
  -> FrontalLobe_Users
       -> CortexControl_Group
            -> EmotionOverride_Admins (ALLOW SillyFace.exe !!)
```

There's a nested path that GRANTS permission even though the direct
group denies it.
</details>

<details>
<summary>Hint 2 - The precedence rule</summary>
In this (fake) AD setup, ALLOW permissions from nested groups take precedence
over DENY at the same level. It's a misconfiguration. Ron's subconscious
set up the deny rule but forgot about the nested allow.
</details>

<details>
<summary>Hint 3 - The CPU Easter egg</summary>
Check the `cpu_specs.ps1` output for "Humor Processing Unit". Its max clock
speed is suspiciously low and it lists known vulnerabilities.
</details>

<details>
<summary>Hint 4 - The full picture</summary>
The audit reveals: Ron's account effectively HAS SillyFace.exe permission
through the nested EmotionOverride_Admins group. His "denial" of silly
faces is just a surface-level ACL that gets overridden. The CPU specs
confirm his Humor Processing Unit crashes when handling unexpected input.
</details>

## What You're Looking For

1. Show the AD structure and group hierarchy on camera
2. Trace through the nested groups to find the hidden permission
3. Run the audit and highlight the CRITICAL finding
4. Bonus: show the CPU specs Easter egg

Film yourself tracing through the permission chain like a detective.

---

*"His access controls are denied, but his groups say otherwise." - CerebralGit Report*
