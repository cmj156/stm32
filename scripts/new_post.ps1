Param(
  [Parameter(Mandatory=$true)][string]$Title,
  [string]$Tags = "标签1,标签2",
  [string]$Categories = "分类",
  [switch]$Draft,
  [string]$BlogPath = "D:\\diansai\\STM32 B\\STM32博客"
)

# 生成 slug
$slug = $Title.ToLower() -replace '[^a-z0-9\s-]','' -replace '\s+','-' -replace '-+','-'
$date = Get-Date -Format yyyy-MM-dd
$filename = "$date-$slug.md"
$dir = Join-Path $BlogPath "content\posts"
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
$filepath = Join-Path $dir $filename

$tagsYaml = ($Tags -split ',') | ForEach-Object { '"' + ($_.Trim()) + '"' } -join ', '
$catsYaml = ($Categories -split ',') | ForEach-Object { '"' + ($_.Trim()) + '"' } -join ', '
$draftYaml = if ($Draft.IsPresent) { 'true' } else { 'false' }

$content = @"
---
title: "$Title"
date: $date
draft: $draftYaml
tags: [ $tagsYaml ]
categories: [ $catsYaml ]
---

正文内容...

"@

Set-Content -Path $filepath -Value $content -Encoding UTF8
Write-Output "Created: $filepath"
