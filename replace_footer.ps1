$sourceFile = "c:\Users\1011\Downloads\pricollogistics-website-combined\sustainability.html"
$targetFiles = @(
    "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html"
)

$utf8NoBom = New-Object System.Text.UTF8Encoding $false
$sourceContent = [System.IO.File]::ReadAllText($sourceFile, $utf8NoBom)

if ($sourceContent -match '(?s)(<div data-elementor-type="footer".*?)<div id="scroll-to-top"') {
    $footerHtml = $matches[1]
    
    foreach ($tFile in $targetFiles) {
        $tContent = [System.IO.File]::ReadAllText($tFile, $utf8NoBom)
        
        if ($tContent -match '(?s)<div data-elementor-type="wp-post" data-elementor-id="187".*?(?=<div id="scroll-to-top")') {
            $newContent = $tContent -replace '(?s)<div data-elementor-type="wp-post" data-elementor-id="187".*?(?=<div id="scroll-to-top")', $footerHtml
            [System.IO.File]::WriteAllText($tFile, $newContent, $utf8NoBom)
            Write-Host "Successfully updated $tFile"
        } else {
            Write-Host "Could not find elementor-187 in $tFile"
        }
    }
} else {
    Write-Host "Footer not found in source file!"
}
