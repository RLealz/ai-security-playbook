<#
.SYNOPSIS
    AI Security Playbook -- Vault-First Quarantine-Auditing Skill & Combo Installer (PowerShell)
.DESCRIPTION
    Installs built-in MIT Meta-Skills (security-router + 7 Combos) and selectively fetches
    upstream security skills from GitHub using git sparse-checkout + static quarantine auditing.
    Routes defensive skills to the active agent skills directory and offensive/red-team/pentest
    packs to an isolated security vault (-VaultDir / <TargetDir>-vault-security).
.EXAMPLE
    .\install.ps1 -List
    .\install.ps1 -Router -Target antigravity
    .\install.ps1 -Combo appsec-code-audit -Tier defensive -Target antigravity
    .\install.ps1 -Skill vibe-shield -Target antigravity
    .\install.ps1 -Skill cyber-monster -Target antigravity -VaultDir "$HOME\.gemini\config\skills-vault-security"
#>

param(
    [switch]$List,
    [switch]$Router,
    [string]$Combo,
    [string]$Skill,
    [switch]$All,
    [string]$Target = "claude",
    [string]$VaultDir = "",
    [ValidateSet("all", "defensive", "vault")]
    [string]$Tier = "all",
    [switch]$ForceActive,
    [switch]$AllowDocWarnings,
    [switch]$AllowVaultWarnings,
    [switch]$SkipAudit
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$RegistryPath = Join-Path $RepoRoot "registry.json"
$ScannerPy = Join-Path $RepoRoot "scripts\scan_quarantine.py"

if (-not (Test-Path $RegistryPath)) {
    Write-Error "registry.json not found at $RegistryPath"
    exit 1
}

$Registry = Get-Content $RegistryPath -Raw -Encoding UTF8 | ConvertFrom-Json

function Resolve-TargetDir([string]$TargetSpec) {
    $resolved = switch ($TargetSpec.ToLower()) {
        "claude"        { Join-Path (Get-Location) ".claude\skills" }
        "global-claude" { Join-Path $HOME ".claude\skills" }
        "cursor"        { Join-Path (Get-Location) ".cursor\skills" }
        "antigravity"   { Join-Path $HOME ".gemini\config\skills" }
        "codex"         { Join-Path (Get-Location) ".agents\skills" }
        default         { $TargetSpec }
    }
    return $resolved.TrimEnd('\', '/')
}

function Resolve-VaultRoot([string]$VaultSpec, [string]$DestRoot) {
    if (-not [string]::IsNullOrWhiteSpace($VaultSpec)) {
        return $VaultSpec.TrimEnd('\', '/')
    }
    return "$DestRoot-vault-security"
}

function Resolve-PythonBinary {
    $candidates = @("py", "python3", "python")
    foreach ($name in $candidates) {
        $cmd = Get-Command $name -ErrorAction SilentlyContinue
        if ($cmd) {
            try {
                $prev = $ErrorActionPreference
                $ErrorActionPreference = "Continue"
                & $cmd.Source --version *> $null
                $code = $LASTEXITCODE
                $ErrorActionPreference = $prev
                if ($code -eq 0) {
                    return $cmd.Source
                }
            } catch {
                # Skip Windows Store stubs or non-working shims
            }
        }
    }
    return $null
}

function Show-RegistryList {
    Write-Host "`n============================================================" -ForegroundColor Cyan
    Write-Host "  AI SECURITY PLAYBOOK -- SKILL, COMBO & VAULT REGISTRY (v$($Registry.version))" -ForegroundColor Cyan
    Write-Host "============================================================`n" -ForegroundColor Cyan

    Write-Host "[Built-in MIT Meta-Skills (Active Tier)]" -ForegroundColor Green
    foreach ($s in $Registry.localSkills) {
        Write-Host ("  - {0,-32} : {1}" -f $s.id, $s.description)
    }

    Write-Host "`n[7 Curated Workflow Combos (-Combo <name>)]" -ForegroundColor Yellow
    foreach ($prop in $Registry.combos.PSObject.Properties) {
        $c = $prop.Value
        $upList = ($c.upstreamSkills -join ", ")
        Write-Host ("  - {0,-28} : {1}" -f $prop.Name, $c.name)
        Write-Host ("    Upstream Skills              : {0}" -f $upList) -ForegroundColor DarkGray
    }

    Write-Host "`n[25 Upstream Security Skills (-Skill <id>)]" -ForegroundColor Magenta
    foreach ($u in $Registry.upstreamSkills) {
        Write-Host ("  - {0,-30} [{1,-9}] [{2}] ({3}) - {4}" -f $u.id, $u.tier, $u.category, $u.license, $u.repo)
    }

    Write-Host "`n[Cataloged Agent Frameworks: $($Registry.agentFrameworks.Count) | MCP Servers: $($Registry.mcpServers.Count) | Web Resources: $($Registry.securityResources.Count)]" -ForegroundColor Cyan
    Write-Host "  See skills/security-router/references/SECURITY_RESOURCES.md for the full framework & MCP matrix.`n" -ForegroundColor DarkGray
}

function Test-SkillSecurity([string]$ScanDir, [string]$SkillId, [string]$SkillTier) {
    if ($SkipAudit) {
        Write-Host "  [WARN] Skipping security audit for '$SkillId' (-SkipAudit specified)." -ForegroundColor Yellow
        return $true
    }

    if (-not (Test-Path $ScannerPy)) {
        Write-Error "Quarantine scanner not found at $ScannerPy"
        return $false
    }

    $pyBin = Resolve-PythonBinary
    if (-not $pyBin) {
        Write-Error "Python 3 is required to run scripts\scan_quarantine.py (pass -SkipAudit only if manually verified)."
        return $false
    }

    Write-Host "  [AUDIT] Running static quarantine scan on '$SkillId' (tier: $SkillTier)..." -ForegroundColor Cyan
    $prev = $ErrorActionPreference
    $ErrorActionPreference = "Continue"
    $rawJson = & $pyBin $ScannerPy --path $ScanDir --json 2>&1
    $exitCode = $LASTEXITCODE
    $ErrorActionPreference = $prev

    if ($exitCode -ne 0 -or [string]::IsNullOrWhiteSpace(($rawJson -join "`n"))) {
        Write-Warning "  [BLOCKED] Quarantine scanner failed for '$SkillId'."
        return $false
    }

    $results = @((($rawJson -join "`n") | ConvertFrom-Json))
    $allFindings = @()
    $hasFail = $false
    $hasWarn = $false
    $hasHardBlock = $false

    foreach ($res in $results) {
        if ($res.status -eq "FAIL") { $hasFail = $true }
        if ($res.status -eq "WARN") { $hasWarn = $true }
        foreach ($f in @($res.findings)) {
            $allFindings += $f
            if ($f.rule -eq "RULE_BIDI_TROJAN" -or $f.rule -eq "RULE_PKG_HOOK") {
                $hasHardBlock = $true
            }
        }
    }

    if ($allFindings.Count -gt 0) {
        Write-Host "  [FINDINGS] '$SkillId' reported $($allFindings.Count) finding(s):" -ForegroundColor Yellow
        foreach ($f in ($allFindings | Select-Object -First 20)) {
            Write-Host "    - [$($f.severity)] $($f.rule) @ $($f.file):$($f.line) ($($f.detail))" -ForegroundColor DarkYellow
        }
    }

    if ($hasHardBlock) {
        Write-Warning "  [BLOCKED] Hard-block finding (RULE_BIDI_TROJAN or RULE_PKG_HOOK) detected in '$SkillId'. Aborting install."
        return $false
    }

    if ($SkillTier -eq "defensive") {
        if ($hasFail -or $hasWarn) {
            if ($AllowDocWarnings) {
                Write-Host "  [WARN] Defensive skill '$SkillId' has non-Trojan doc findings (0 hard-blocks); proceeding via -AllowDocWarnings." -ForegroundColor Yellow
                return $true
            }
            if ($hasFail) {
                Write-Warning "  [BLOCKED] Defensive skill '$SkillId' failed static security audit. Inspect the files above; re-run with -AllowDocWarnings only if verified benign docs."
                return $false
            }
        }
        Write-Host "  [PASS] '$SkillId' passed static security audit (0 FAIL)." -ForegroundColor Green
        return $true
    }

    # Vault tier handling
    if ($hasFail -or $hasWarn) {
        if ($AllowVaultWarnings) {
            Write-Host "  [WARN] Vault pack '$SkillId' has findings (0 hard-blocks); proceeding into isolated vault via -AllowVaultWarnings." -ForegroundColor Yellow
            return $true
        }
        Write-Warning "  [PAUSED] Vault pack '$SkillId' triggered static findings above. Inspect those files manually and re-run with -AllowVaultWarnings to vault."
        return $false
    }

    Write-Host "  [PASS] Vault skill '$SkillId' passed static security audit." -ForegroundColor Green
    return $true
}

function Copy-DirContents([string]$Src, [string]$Dst) {
    New-Item -ItemType Directory -Force -Path $Dst | Out-Null
    Get-ChildItem -Path $Src -Force | Where-Object { $_.Name -ne ".git" } | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $Dst -Recurse -Force
    }
}

function Install-LocalSkill([string]$SkillId, [string]$DestRoot) {
    $LocalEntry = $Registry.localSkills | Where-Object { $_.id -eq $SkillId }
    if (-not $LocalEntry) {
        Write-Error "Local skill '$SkillId' not found in registry.json"
        return
    }
    $SrcDir = Join-Path $RepoRoot ($LocalEntry.path -replace '/', '\')
    $TargetDir = Join-Path $DestRoot $SkillId
    Copy-DirContents -Src $SrcDir -Dst $TargetDir
    Write-Host "  [INSTALLED] Local meta-skill '$SkillId' -> $TargetDir" -ForegroundColor Green
}

function Install-UpstreamSkill([string]$SkillId, [string]$DestRoot, [string]$VaultRoot) {
    $UpEntry = $Registry.upstreamSkills | Where-Object { $_.id -eq $SkillId }
    if (-not $UpEntry) {
        Write-Warning "Upstream skill '$SkillId' not found in registry.json. Skipping."
        return
    }

    $SkillTier = if ($UpEntry.tier) { $UpEntry.tier } else { "defensive" }
    if ($Tier -ne "all" -and $SkillTier -ne $Tier) {
        Write-Host "  [SKIP] '$SkillId' (tier=$SkillTier) excluded by -Tier $Tier filter." -ForegroundColor DarkGray
        return
    }

    $TargetBase = if ($SkillTier -eq "vault" -and -not $ForceActive) { $VaultRoot } else { $DestRoot }
    $TempRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("ai-sec-quarantine-" + [System.Guid]::NewGuid().ToString("N").Substring(0, 8))
    New-Item -ItemType Directory -Force -Path $TempRoot | Out-Null

    try {
        $RepoUrl = "https://github.com/$($UpEntry.repo).git"
        Write-Host "`n[FETCH] Cloning '$SkillId' from $($UpEntry.repo) (Tier: $SkillTier, License: $($UpEntry.license))..." -ForegroundColor Cyan

        $prev = $ErrorActionPreference
        $ErrorActionPreference = "Continue"
        if ($UpEntry.subPath -and $UpEntry.subPath -ne "") {
            $subClean = $UpEntry.subPath.TrimStart('/')
            if ($subClean -match '\.[A-Za-z0-9]+$') {
                & git clone --depth 1 --filter=blob:none --no-checkout -c core.hooksPath=NUL $RepoUrl $TempRoot 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Push-Location $TempRoot
                    & git sparse-checkout init --no-cone 2>&1 | Out-Null
                    & git sparse-checkout set "/$subClean" 2>&1 | Out-Null
                    & git checkout 2>&1 | Out-Null
                    Pop-Location
                }
            } else {
                & git clone --depth 1 --filter=blob:none --sparse -c core.hooksPath=NUL $RepoUrl $TempRoot 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) {
                    Push-Location $TempRoot
                    & git sparse-checkout set $UpEntry.subPath 2>&1 | Out-Null
                    Pop-Location
                }
            }
            $SourcePayload = Join-Path $TempRoot ($subClean -replace '/', '\')
        } else {
            & git clone --depth 1 --filter=blob:none -c core.hooksPath=NUL $RepoUrl $TempRoot 2>&1 | Out-Null
            $SourcePayload = $TempRoot
        }
        $cloneCode = $LASTEXITCODE
        $ErrorActionPreference = $prev

        if ($cloneCode -ne 0) {
            Write-Warning "  [ERROR] Failed to clone $($UpEntry.repo). Skipping '$SkillId'."
            return
        }

        if (-not (Test-Path $SourcePayload)) {
            Write-Warning "  [WARN] Subpath '$($UpEntry.subPath)' not found in $($UpEntry.repo); falling back to repo root."
            $SourcePayload = $TempRoot
        }

        if (Test-Path $SourcePayload -PathType Leaf) {
            $LeafStage = Join-Path $TempRoot "_leaf_stage"
            New-Item -ItemType Directory -Force -Path $LeafStage | Out-Null
            Copy-Item -Path $SourcePayload -Destination $LeafStage -Force
            $SourcePayload = $LeafStage
        }

        $GitFolder = Join-Path $TempRoot ".git"
        if (Test-Path $GitFolder) {
            Remove-Item -Path $GitFolder -Recurse -Force
        }

        if (-not (Test-SkillSecurity -ScanDir $SourcePayload -SkillId $SkillId -SkillTier $SkillTier)) {
            return
        }

        $FinalDest = Join-Path $TargetBase $SkillId
        Copy-DirContents -Src $SourcePayload -Dst $FinalDest
        if ($SkillTier -eq "vault" -and -not $ForceActive) {
            Write-Host "  [VAULTED] Isolated security skill '$SkillId' -> $FinalDest" -ForegroundColor Yellow
        } else {
            Write-Host "  [INSTALLED] Upstream skill '$SkillId' -> $FinalDest" -ForegroundColor Green
        }
    }
    finally {
        if (Test-Path $TempRoot) {
            Remove-Item -Path $TempRoot -Recurse -Force -ErrorAction SilentlyContinue
        }
    }
}

# --- Execution Flow ---

if ($List) {
    Show-RegistryList
    exit 0
}

$DestRoot = Resolve-TargetDir $Target
$VaultRoot = Resolve-VaultRoot -VaultSpec $VaultDir -DestRoot $DestRoot
New-Item -ItemType Directory -Force -Path $DestRoot | Out-Null

if ($Router) {
    if ($Tier -eq "vault") {
        Write-Host "Local Meta-Skills belong to tier 'defensive'; skipping due to -Tier vault." -ForegroundColor Yellow
        exit 0
    }
    Write-Host "Installing built-in MIT Security Meta-Skills to $DestRoot ..." -ForegroundColor Cyan
    foreach ($s in $Registry.localSkills) {
        Install-LocalSkill -SkillId $s.id -DestRoot $DestRoot
    }
    exit 0
}

if ($Combo) {
    $ComboProp = $Registry.combos.PSObject.Properties[$Combo]
    if (-not $ComboProp) {
        Write-Error "Unknown combo '$Combo'. Run .\install.ps1 -List to see available combos."
        exit 1
    }
    $ComboData = $ComboProp.Value
    Write-Host "Installing Security Combo '$Combo' ($($ComboData.name))..." -ForegroundColor Cyan
    Write-Host "  Active Dest : $DestRoot" -ForegroundColor DarkGray
    Write-Host "  Vault Dest  : $VaultRoot" -ForegroundColor DarkGray

    if ($Tier -ne "vault") {
        Install-LocalSkill -SkillId "security-router" -DestRoot $DestRoot
        Install-LocalSkill -SkillId $ComboData.localSkill -DestRoot $DestRoot
    }
    foreach ($upId in $ComboData.upstreamSkills) {
        Install-UpstreamSkill -SkillId $upId -DestRoot $DestRoot -VaultRoot $VaultRoot
    }
    exit 0
}

if ($Skill) {
    $IsLocal = $Registry.localSkills | Where-Object { $_.id -eq $Skill }
    if ($IsLocal) {
        Install-LocalSkill -SkillId $Skill -DestRoot $DestRoot
    } else {
        Install-UpstreamSkill -SkillId $Skill -DestRoot $DestRoot -VaultRoot $VaultRoot
    }
    exit 0
}

if ($All) {
    Write-Host "Installing ALL AI Security Playbook skills (Tier filter: $Tier)..." -ForegroundColor Cyan
    Write-Host "  Active Dest : $DestRoot" -ForegroundColor DarkGray
    Write-Host "  Vault Dest  : $VaultRoot" -ForegroundColor DarkGray
    if ($Tier -ne "vault") {
        foreach ($s in $Registry.localSkills) {
            Install-LocalSkill -SkillId $s.id -DestRoot $DestRoot
        }
    }
    foreach ($u in $Registry.upstreamSkills) {
        Install-UpstreamSkill -SkillId $u.id -DestRoot $DestRoot -VaultRoot $VaultRoot
    }
    exit 0
}

Write-Host "Usage:" -ForegroundColor Yellow
Write-Host "  .\install.ps1 -List                                                          # List Combos, Defensive & Vault Skills"
Write-Host "  .\install.ps1 -Router [-Target claude|antigravity|...]                       # Install built-in Router + 7 Combo skills"
Write-Host "  .\install.ps1 -Combo <combo-name> [-Tier all|defensive|vault] [-Target ...]  # Install Combo with vault-first routing"
Write-Host "  .\install.ps1 -Skill <skill-id> [-VaultDir <path>] [-AllowDocWarnings] [-AllowVaultWarnings]     # Fetch, audit, and install/vault one skill"
Write-Host "  .\install.ps1 -All [-Tier defensive|all] [-Target ...]                       # Install all skills matching tier filter"
