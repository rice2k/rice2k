#requires -Version 5.1
<#
.SYNOPSIS
  Preview or update GitHub search metadata for selected public Rice2K repositories.
.EXAMPLE
  .\Update-Repo-Metadata.ps1
.EXAMPLE
  .\Update-Repo-Metadata.ps1 -Apply
#>
[CmdletBinding()]
param([switch]$Apply)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$Owner = 'rice2k'

# Explicit allowlist: public, first-party projects only. No private repositories or forks.
# Description replaces About text only where explicitly provided.
# Empty Website leaves the existing homepage field untouched.
$Projects = @(
  @{Name='rice2k'; Desc='Rice2K profile: Windows utilities, GraalOnline tools, retro web preservation, and searchable open-source projects.'; Topics=@('windows-tools','graalonline','retro-web','open-source','developer-portfolio'); Website=''},
  @{Name='rice2k-startdeck'; Desc='RiceDeck browser start page with weather, favorites, anime releases, and searchable Rice2K Project Explorer.'; Topics=@('startpage','browser-dashboard','bookmarks','github-pages','project-directory','windows'); Website='https://rice2k.github.io/rice2k-startdeck/'},
  @{Name='Cyber-Tool-Atlas'; Desc='Free searchable directory of cybersecurity utilities, defensive tools, and security learning resources.'; Topics=@('cybersecurity','security-tools','tool-directory','cybersecurity-resources','github-pages'); Website='https://rice2k.github.io/Cyber-Tool-Atlas/'},
  @{Name='old-free-online-resources'; Desc='Searchable archive of 1990s and 2000s free online resources, old websites, and retro web directories.'; Topics=@('retro-web','old-web','web-archive','internet-history','wayback-machine','link-directory'); Website='https://rice2k.github.io/old-free-online-resources/'},
  @{Name='Graalians-Discord-Server-Tool-Hub'; Desc='GraalOnline development hub with GMAP, NW level, GANI, GS2 and preservation tools for Graalians.'; Topics=@('graalonline','graalians','gs2','gmap','gani','level-editor'); Website='https://rice2k.github.io/Graalians-Discord-Server-Tool-Hub/'},
  @{Name='Rice2k-Folder-Vault'; Desc='Experimental C# Windows encrypted folder vault with Argon2id, AES-GCM, and read-only Explorer mounting; alpha, testing pending.'; Topics=@('windows','csharp','encryption','file-vault','argon2id','dokannet','alpha-software'); Website=''},
  @{Name='Rice2k-Encryption-Software'; Desc='Windows file and folder encryption application in early development; security-focused preview, not for sole backup use.'; Topics=@('windows','csharp','encryption','file-encryption','desktop-app','cryptography','preview'); Website=''},
  @{Name='Computer-Asset-System-Info'; Desc='Windows IT asset inventory and helpdesk diagnostics utility with hardware, security, storage and network information.'; Topics=@('windows','it-support','computer-inventory','diagnostics','python','helpdesk'); Website=''},
  @{Name='rice2k-magic-tasks'; Desc='Windows task planner with reminders, drag-and-drop organization, calendar and focus features.'; Topics=@('windows','python','task-planner','productivity','calendar','focus-mode'); Website=''},
  @{Name='Rice2k-Macro-Studio'; Desc='Windows macro recorder and automation studio for mouse, keyboard, smart UI targets and browser actions.'; Topics=@('windows','automation','macro-recorder','mouse-keyboard','desktop-app'); Website=''},
  @{Name='rice2k-computer-cleaner'; Desc='Windows PC maintenance and safe cleanup app with health scans, software update review and diagnostics.'; Topics=@('windows','pc-maintenance','system-cleaner','diagnostics','desktop-tool'); Website=''},
  @{Name='CoolKids-Archive-Website'; Desc='Documented restoration of the early-2000s CoolKid website, recovered graphics, pages and software artifacts.'; Topics=@('web-preservation','retro-web','internet-history','website-restoration','historical-archive'); Website=''},
  @{Name='AOL-Progz'; Desc='Historical catalog of AOL/AIM-era programs, original links, research sources, recovered files and screenshots.'; Topics=@('aol','aim','internet-history','retrocomputing','old-web','archive'); Website=''},
  @{Name='BTK-Graal-Guild-site-Remake-Archive'; Desc='Restored GraalOnline BTK guild site with Wayback references, local pages, images, and forum archives.'; Topics=@('graalonline','guild','web-preservation','retro-web','wayback-machine'); Website='https://rice2k.github.io/BTK-Graal-Guild-site-Remake-Archive/'},
  @{Name='rice2k-rainmeter-control-bar'; Desc='Windows Rainmeter control bar with desktop widgets, system status and GitHub Pages showcase.'; Topics=@('rainmeter','windows','desktop-widget','desktop-customization','system-monitor'); Website='https://rice2k.github.io/rice2k-rainmeter-control-bar/'},
  @{Name='WiFi-Vault-Pro'; Desc='Windows network diagnostics suite for Wi-Fi profiles, adapters, connectivity checks and troubleshooting.'; Topics=@('windows','wifi','network-diagnostics','python','troubleshooting'); Website=''},
  @{Name='Neo-Password-Generator-'; Desc='Browser password and passphrase generator using Web Crypto API, with no account or backend.'; Topics=@('password-generator','passphrase-generator','web-crypto','javascript','privacy'); Website=''},
  @{Name='Graalians-Archives'; Desc='Organization and preservation of historical GraalOnline and Graalians archive material.'; Topics=@('graalonline','graalians','preservation','archive'); Website=''},
  @{Name='rice2ks-web-directory-recreation'; Desc='Versioned restoration and documentation of the Rice2K classic web directory.'; Topics=@('web-directory','retro-web','web-preservation','internet-history'); Website=''},
  @{Name='Graal-Links'; Desc='Community links and reference resources for GraalOnline history and development.'; Topics=@('graalonline','graal','link-directory','community-resources'); Website=''},
  @{Name='SubSeven-Historical-Archive'; Desc='Historical SubSeven software research and preservation archive; documentation only.'; Topics=@('software-history','internet-history','digital-preservation','historical-archive'); Website=''},
  @{Name='Methodus2000'; Desc='Historical archive of Methodus 2000 AOL-era tools and retro computing culture.'; Topics=@('aol','internet-history','retrocomputing','historical-archive'); Website=''}
)

function Get-GhJson([string]$Endpoint) {
  $lines = & gh api $Endpoint 2>&1
  if ($LASTEXITCODE -ne 0) { throw ("Cannot read " + $Endpoint + ": " + ($lines -join ' ')) }
  return (($lines -join [Environment]::NewLine) | ConvertFrom-Json)
}
function Set-GhJson([string]$Method,[string]$Endpoint,[hashtable]$Body) {
  $temp = [IO.Path]::GetTempFileName()
  try {
    $json = ConvertTo-Json -InputObject $Body -Compress -Depth 8
    [IO.File]::WriteAllText($temp,$json,(New-Object System.Text.UTF8Encoding($false)))
    $output = & gh api --method $Method $Endpoint --input $temp 2>&1
    if ($LASTEXITCODE -ne 0) { throw ("Cannot update " + $Endpoint + ": " + ($output -join ' ')) }
  } finally {
    Remove-Item -LiteralPath $temp -Force -ErrorAction SilentlyContinue
  }
}

if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
  throw 'Install GitHub CLI from https://cli.github.com/ and run: gh auth login'
}
$me = Get-GhJson 'user'
if ($me.login -ine $Owner) {
  throw ("You are signed in as " + $me.login + ", not " + $Owner + ". Run gh auth login for rice2k.")
}
Write-Host ("Mode: " + $(if ($Apply) {'APPLY'} else {'PREVIEW'}) + " for " + $Owner) -ForegroundColor Cyan
$planned=0;$updated=0;$skipped=0;$errors=0

foreach ($item in $Projects) {
  $repoPath = 'repos/' + $Owner + '/' + $item.Name
  try {
    $current = Get-GhJson $repoPath
    if ($current.private -or $current.fork -or $current.archived -or $current.owner.login -ine $Owner) {
      Write-Host ('[SKIP] ' + $item.Name + ' is private, forked, archived, or outside this account.')
      $skipped++;continue
    }
    $patch=@{}
    if ($item.Desc -and $current.description -cne $item.Desc) { $patch.description=$item.Desc }
    if ($item.Website -and $current.homepage -cne $item.Website) { $patch.homepage=$item.Website }
    $existing = @($current.topics | Where-Object { $_ -is [string] -and $_ })
    $allTopics = @($existing + @($item.Topics) | ForEach-Object { $_.ToLowerInvariant() } | Sort-Object -Unique)
    $addTopics = @($allTopics | Where-Object { $_ -notin $existing })
    $topicsChanged = $addTopics.Count -gt 0
    if ($allTopics.Count -gt 20) { Write-Warning ('Too many topics on ' + $item.Name); $topicsChanged=$false }
    if (-not $topicsChanged -and $patch.Count -eq 0) {
      Write-Host ('[OK] ' + $item.Name + ' already up-to-date');$skipped++;continue
    }

    $planned++
    Write-Host ('[' + $(if ($Apply) {'UPDATE'} else {'PREVIEW'}) + '] ' + $item.Name) -ForegroundColor Yellow
    if ($patch.ContainsKey('description')) {Write-Host ('  Description: ' + $patch.description)}
    if ($patch.ContainsKey('homepage')) {Write-Host ('  Homepage: ' + $patch.homepage)}
    if ($topicsChanged) {Write-Host ('  Add topics: ' + ($addTopics -join ', '))}
    if ($Apply) {
      if ($patch.Count -gt 0) {Set-GhJson 'PATCH' $repoPath $patch}
      if ($topicsChanged) {Set-GhJson 'PUT' ($repoPath + '/topics') @{ names=$allTopics }}
      $updated++
    }
  } catch {
    Write-Warning ($item.Name + ': ' + $_.Exception.Message)
    $errors++
  }
}
Write-Host ('Candidates: ' + $planned + '; updated: ' + $updated + '; unchanged/skipped: ' + $skipped + '; errors: ' + $errors) -ForegroundColor Cyan
if (-not $Apply) {Write-Host 'Preview only: no changes were made. Run with -Apply to apply the listed updates.'}
if ($errors -gt 0) {exit 1}
