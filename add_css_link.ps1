$files = @(
    "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html"
)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f, $utf8NoBom)
    if ($content -notmatch 'global-responsive-overrides\.css') {
        $newContent = $content -replace '</head>', "`t<link rel=`"stylesheet`" href=`"./css/global-responsive-overrides.css`" media=`"all`">`n</head>"
        [System.IO.File]::WriteAllText($f, $newContent, $utf8NoBom)
        Write-Host "Added CSS link to $f"
    } else {
        Write-Host "CSS link already exists in $f"
    }
}
