# PowerShell script to configure relative script loading paths for GitHub Pages subfolders
$htmlFiles = Get-ChildItem -Path "c:/Users/1011/Downloads/pricollogistics-website-combined" -Filter "*.html" | Select-Object -ExpandProperty Name

foreach ($file in $htmlFiles) {
    $filePath = Join-Path "c:/Users/1011/Downloads/pricollogistics-website-combined" $file
    
    # Read file content safely
    $content = [System.IO.File]::ReadAllText($filePath)
    
    # Configure elementor base assets url prefix dynamically to match the GitHub Pages subfolder
    # Instead of relative "./js/", we configure it to use "/pricol_logistics/js/" so Webpack dynamically resolves chunks inside the sub-repository path
    $content = $content.Replace('"assets":"./js/"', '"assets":"/pricol_logistics/js/"')
    
    # Write changes back
    [System.IO.File]::WriteAllText($filePath, $content)
}

Write-Output "Successfully updated Elementor publicPath config for GitHub Pages subfolder."
