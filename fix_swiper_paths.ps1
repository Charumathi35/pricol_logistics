# PowerShell script to change localhost elementor scripts to relative paths safely without breaking the user's layout
$htmlFiles = Get-ChildItem -Path "c:/Users/1011/Downloads/pricollogistics-website-combined" -Filter "*.html" | Select-Object -ExpandProperty Name

foreach ($file in $htmlFiles) {
    $filePath = Join-Path "c:/Users/1011/Downloads/pricollogistics-website-combined" $file
    
    # Read file content safely, ensuring we can write it back even if held
    $content = [System.IO.File]::ReadAllText($filePath)
    
    # Replace webpack chunk source loading paths inside script configs so elementor loads chunks locally instead of looking at localhost
    $content = $content.Replace('http:\/\/localhost\/pricollogistics\/wp-content\/plugins\/elementor\/assets\/', './js/')
    $content = $content.Replace('http://localhost/pricollogistics/wp-content/plugins/elementor/assets/', './js/')
    
    # Write it back
    [System.IO.File]::WriteAllText($filePath, $content)
}

Write-Output "Successfully patched localhost script config paths to relative paths."
