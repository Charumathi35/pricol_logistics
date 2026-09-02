$sourceFile = "c:\Users\1011\Downloads\pricollogistics-website-combined\index.html"
$globalCssFile = "c:\Users\1011\Downloads\pricollogistics-website-combined\css\global-responsive-overrides.css"

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$sourceContent = [System.IO.File]::ReadAllText($sourceFile, $utf8NoBom)

# Find the elementor-76 CSS block (from line 5200 to 5580 roughly)
if ($sourceContent -match '(?s)(?:\.elementor-76 \.elementor-element\.elementor-element-31f28075.*?)(?:\@media\(max-width:1024px\)|</style>)') {
    # It might be safer to extract the entire style block that contains .elementor-76
    # Actually, we can use a regex to capture all rules starting with .elementor-76
    $matches = [regex]::Matches($sourceContent, '(?s)\.elementor-76 [^{]+\{.*?\}')
    
    $extractedCss = ""
    foreach ($m in $matches) {
        $rule = $m.Value -replace '\.elementor-76', '.elementor-187'
        $extractedCss += "$rule`n"
    }
    
    # Also handle media queries that contain .elementor-76
    $mediaMatches = [regex]::Matches($sourceContent, '(?s)\@media[^{]+\{(?:[^{]+\{.*?\})*\s*\}')
    foreach ($m in $mediaMatches) {
        if ($m.Value -match '\.elementor-76') {
            # Extract just the .elementor-76 rules inside the media query
            $mqHeader = ($m.Value -split '\{')[0] + " {`n"
            $innerRules = [regex]::Matches($m.Value, '(?s)\.elementor-76 [^{]+\{.*?\}')
            if ($innerRules.Count -gt 0) {
                $extractedCss += $mqHeader
                foreach ($im in $innerRules) {
                    $rule = $im.Value -replace '\.elementor-76', '.elementor-187'
                    $extractedCss += "    $rule`n"
                }
                $extractedCss += "}`n"
            }
        }
    }
    
    [System.IO.File]::AppendAllText($globalCssFile, "`n/* FOOTER 187 STYLES */`n" + $extractedCss, $utf8NoBom)
    Write-Host "Appended extracted CSS to global-responsive-overrides.css"
} else {
    Write-Host "Could not find elementor-76 styles"
}

$targetFiles = @(
    "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html"
)

foreach ($tFile in $targetFiles) {
    $tContent = [System.IO.File]::ReadAllText($tFile, $utf8NoBom)
    
    # Change wrapper back to elementor-187
    if ($tContent -match '<div data-elementor-type="footer" data-elementor-id="76" class="elementor elementor-76 elementor-location-footer">') {
        $newContent = $tContent -replace '<div data-elementor-type="footer" data-elementor-id="76" class="elementor elementor-76 elementor-location-footer">', '<div data-elementor-type="wp-post" data-elementor-id="187" class="elementor elementor-187">'
        [System.IO.File]::WriteAllText($tFile, $newContent, $utf8NoBom)
        Write-Host "Restored wrapper class in $tFile"
    }
}
