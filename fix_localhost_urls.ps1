# Powershell script to replace localhost WordPress URLs with relative paths for GitHub Pages
$htmlFiles = Get-ChildItem -Path "c:/Users/1011/Downloads/pricollogistics-website-combined" -Filter "*.html" | Select-Object -ExpandProperty Name

foreach ($file in $htmlFiles) {
    $filePath = Join-Path "c:/Users/1011/Downloads/pricollogistics-website-combined" $file
    $content = Get-Content $filePath -Raw
    
    # Replace the Elementor assets url that points to localhost with local relative path
    $content = $content -replace 'http:\\/\\/localhost\\/pricollogistics\\/wp-content\\/plugins\\/elementor\\/assets\\/', './js/'
    $content = $content -replace 'http://localhost/pricollogistics/wp-content/plugins/elementor/assets/', './js/'
    
    # Replace any other raw localhost URLs inside JS configurations
    $content = $content -replace 'http:\\/\\/localhost\\/pricollogistics\\/wp-content\\/uploads', './images'
    $content = $content -replace 'http://localhost/pricollogistics/wp-content/uploads', './images'

    # Fix theme JS assets
    $content = $content -replace '/wp-content/themes/fabrik/vamtam/assets/js/', './js/'
    $content = $content -replace '/wp-includes/js/', './js/'
    
    Set-Content -Path $filePath -Value $content
}

Write-Output "Successfully updated localhost URLs to relative paths in all HTML files."
