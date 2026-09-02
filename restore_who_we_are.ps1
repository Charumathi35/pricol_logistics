$backupFile = "c:\Users\1011\Downloads\temp_unzip\company-overview.html"
$backupContent = [System.IO.File]::ReadAllText($backupFile, [System.Text.Encoding]::UTF8)

$startStr = '<div class="elementor-element elementor-element-b9cc03c e-flex e-con-boxed e-con e-parent"'
$startIndex = $backupContent.IndexOf($startStr)
$endStr = '<div class="elementor-element elementor-element-1a33efc7 e-flex e-con-boxed e-con e-parent"'
$endIndex = $backupContent.IndexOf($endStr, $startIndex)

if ($startIndex -gt -1 -and $endIndex -gt -1) {
    $blockToRestore = $backupContent.Substring($startIndex, $endIndex - $startIndex)
    
    $file = "c:\Users\1011\Downloads\pricollogistics-website-combined\company-overview.html"
    $content = [System.IO.File]::ReadAllText($file, [System.Text.Encoding]::UTF8)
    
    # 1. Remove the custom cards I added
    $customStart = $content.IndexOf("<div class=`"custom-who-we-are-cards-wrapper`">")
    if ($customStart -gt -1) {
        # Find the end of the custom cards wrapper (it ends right before `<script>` of the tabs or `<style>` of the tabs)
        $customEnd = $content.IndexOf("<style>", $customStart)
        if ($customEnd -eq -1 -or $customEnd -gt ($customStart + 5000)) {
            $customEnd = $content.IndexOf("<script>", $customStart)
        }
        
        # Remove the <style> block of the custom cards as well
        $styleStart = $content.LastIndexOf("<style>", $customStart)
        
        $content = $content.Substring(0, $styleStart) + "`n" + $blockToRestore + "`n" + $content.Substring($customEnd)
        [System.IO.File]::WriteAllText($file, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Restored the original Elementor style successfully!"
    } else {
        Write-Host "Custom cards not found!"
    }
} else {
    Write-Host "Could not find block in backup."
}
