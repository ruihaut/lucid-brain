# tests/lint.ps1 — build-time structural + frontmatter lint (dependency-free).
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$fail = @()

$required = @(
  'CLAUDE.md','VISION.md','README.md','.mcp.json','.claude/settings.json',
  '.claude/commands/bootstrap.md','.claude/commands/specialize.md',
  '.claude/commands/sprint-plan.md','.claude/commands/review.md',
  '.claude/commands/retro.md','.claude/commands/status.md',
  'team/roster.md','scrum/backlog.md',
  'catalog/_TEMPLATE.md','catalog/director-general.md',
  'catalog/directors/dev-director.md','catalog/directors/design-director.md','catalog/directors/marketing-director.md',
  'catalog/specialists/backend.md','catalog/specialists/frontend.md','catalog/specialists/qa.md',
  'catalog/specialists/code-reviewer.md','catalog/specialists/ui-ux.md','catalog/specialists/copywriter.md',
  '.claude/skills/karpathy/SKILL.md','.claude/skills/agent-designer/SKILL.md',
  '.claude/skills/write-a-skill/SKILL.md','.claude/skills/self-improving-agent/SKILL.md',
  '.claude/skills/skill-security-auditor/SKILL.md','.claude/skills/impeccable/SKILL.md'
)
foreach ($f in $required) { if (-not (Test-Path (Join-Path $root $f))) { $fail += "MISSING: $f" } }

$fmFiles = @()
$fmFiles += Get-ChildItem (Join-Path $root 'catalog') -Recurse -Filter *.md -ErrorAction SilentlyContinue | Where-Object { $_.Name -notlike '_*' }
$fmFiles += Get-ChildItem (Join-Path $root '.claude/commands') -Filter *.md -ErrorAction SilentlyContinue
$fmFiles += Get-ChildItem (Join-Path $root '.claude/skills') -Recurse -Filter SKILL.md -ErrorAction SilentlyContinue
foreach ($file in $fmFiles) {
  $c = Get-Content -Raw $file.FullName
  if ($c -notmatch '(?s)^\s*---.*?\bname:\s*\S+.*?\bdescription:\s*\S+.*?---' -and
      $c -notmatch '(?s)^\s*---.*?\bdescription:\s*\S+.*?---') {
    $fail += "BAD FRONTMATTER: $($file.FullName.Substring($root.Length+1))"
  }
}

$claude = Get-Content -Raw (Join-Path $root 'CLAUDE.md')
foreach ($a in @('Think Before Coding','Simplicity First','Surgical Changes','Goal-Driven','BEGIN GENERATED: DG PROFILE','END GENERATED: DG PROFILE')) {
  if ($claude -notmatch [regex]::Escape($a)) { $fail += "CLAUDE.md missing: $a" }
}

if ($fail.Count) { $fail | ForEach-Object { Write-Host "FAIL: $_" }; exit 1 }
Write-Host "LINT OK"; exit 0
