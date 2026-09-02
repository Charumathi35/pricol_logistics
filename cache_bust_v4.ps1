$files = @(
    "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\index.html"
)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f, $utf8NoBom)
    
    # Cache bust global-responsive-overrides.css to v=4
    $newContent = $content -replace 'href="./css/global-responsive-overrides.css\?v=3"', 'href="./css/global-responsive-overrides.css?v=4"'
    
    [System.IO.File]::WriteAllText($f, $newContent, $utf8NoBom)
    Write-Host "Updated link in $f"
}
