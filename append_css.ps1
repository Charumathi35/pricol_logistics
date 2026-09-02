$css = @"
/* FORCE FOOTER TEXT COLOR WHITE */
.elementor-187 .elementor-element.elementor-element-31f28075 .elementor-heading-title,
.elementor-element-31f28075 .elementor-heading-title { color: white !important; }

.elementor-187 .elementor-element.elementor-element-31f28075 .elementor-icon-list-text, 
.elementor-187 .elementor-element.elementor-element-31f28075 .elementor-icon-list-item > a,
.elementor-element-31f28075 .elementor-icon-list-text,
.elementor-element-31f28075 .elementor-icon-list-item > a { color: white !important; }
"@

Add-Content -Path "c:\Users\1011\Downloads\pricollogistics-website-combined\css\global-responsive-overrides.css" -Value $css
Write-Host "Appended white color overrides"
