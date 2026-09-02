$targetFiles = @(
    "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html",
    "c:\Users\1011\Downloads\pricollogistics-website-combined\pricol-group.html"
)
$utf8NoBom = New-Object System.Text.UTF8Encoding $false

foreach ($tFile in $targetFiles) {
    $tContent = [System.IO.File]::ReadAllText($tFile, $utf8NoBom)
    
    # Check if the footer is missing its wrapper
    if ($tContent -match '(?s)(<div class="elementor-element elementor-element-31f28075 e-flex e-con-boxed e-con e-parent".*?)(<div id="scroll-to-top")' -and $tContent -notmatch 'elementor-location-footer') {
        $footerContent = $matches[1]
        $scrollToTop = $matches[2]
        
        $newFooterContent = '<div data-elementor-type="footer" data-elementor-id="76" class="elementor elementor-76 elementor-location-footer">' + "`n" + $footerContent + "`n</div>`n"
        
        $newContent = $tContent.Replace($footerContent + $scrollToTop, $newFooterContent + $scrollToTop)
        
        [System.IO.File]::WriteAllText($tFile, $newContent, $utf8NoBom)
        Write-Host "Successfully added wrapper to $tFile"
    } else {
        Write-Host "Wrapper already exists or footer not found in $tFile"
    }
}
