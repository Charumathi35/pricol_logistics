$htmlFiles = Get-ChildItem -Path "c:/Users/1011/Downloads/pricollogistics-website-combined" -Filter "*.html" | Select-Object -ExpandProperty Name
$validPages = $htmlFiles | ForEach-Object { $_ -replace '\.html$', '' }

$missingPages = @{}

foreach ($file in $htmlFiles) {
    $filePath = Join-Path "c:/Users/1011/Downloads/pricollogistics-website-combined" $file
    $content = Get-Content $filePath -Raw
    
    $content = [regex]::Replace($content, 'href="\./"', 'href="./index.html"')
    $content = [regex]::Replace($content, 'href="http://localhost/pricollogistics/"', 'href="./index.html"')
    
    $pattern = 'href="\./([a-z0-9-]+)/"'
    $content = [regex]::Replace($content, $pattern, {
        param($match)
        $pageName = $match.Groups[1].Value
        
        if ($pageName -in $validPages) {
            return 'href="./' + $pageName + '.html"'
        } else {
            $missingPages[$pageName] = $true
            return 'href="#"'
        }
    })
    
    $pattern2 = 'href="http://localhost/pricollogistics/([a-z0-9-]+)/"'
    $content = [regex]::Replace($content, $pattern2, {
        param($match)
        $pageName = $match.Groups[1].Value
        
        if ($pageName -in $validPages) {
            return 'href="./' + $pageName + '.html"'
        } else {
            $missingPages[$pageName] = $true
            return 'href="#"'
        }
    })
    
    Set-Content -Path $filePath -Value $content
}

Write-Output "Missing pages that were replaced with #:"
$missingPages.Keys | ForEach-Object { Write-Output $_ }
