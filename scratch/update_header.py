import os
import re

# Read index.html
with open('index.html', 'r', encoding='utf-8') as f:
    index_content = f.read()

# Extract Header HTML
header_start = index_content.find('<div class="elementor-element elementor-element-285579d4')
header_end = index_content.find('<div class="elementor-element elementor-element-518d30e1')
header_html = index_content[header_start:header_end]

# Extract index.html inline CSS
style_start = index_content.find('<style id="elementor-frontend-inline-css">')
style_end = index_content.find('</style>', style_start) + 8
index_css = index_content[style_start:style_end].replace('id="elementor-frontend-inline-css"', 'id="index-header-css"')

# The fully wrapped replacement header
new_header_block = f"""
<div class="elementor elementor-76">
{header_html}
</div>
"""

# Iterate through all HTML files
for file in os.listdir('.'):
    if file.endswith('.html') and file != 'index.html':
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # 1. Replace the header block
        # The block starts at <a class="skip-link or <div class="ekit-template-content-markup ekit-template-content-header
        # and ends right before <div data-elementor-type="wp-page" or wp-post (not id 150)
        pattern = re.compile(r'(<a class="skip-link.*?|<div class="ekit-template-content-markup ekit-template-content-header.*?)<div data-elementor-type="wp-(?:page|post)" data-elementor-id="(?!150)', re.DOTALL)
        
        def replacement(match):
            return new_header_block + '<div data-elementor-type="wp-' + ('page' if 'wp-page' in content[match.end():match.end()+20] else 'post') + '" data-elementor-id="' # this is tricky because lookahead is better
            
        # Let's use re.sub with lookahead
        pattern2 = re.compile(r'(?:<a class="skip-link.*?)?<div class="ekit-template-content-markup ekit-template-content-header.*?(?=<div data-elementor-type="wp-(?:page|post)" data-elementor-id="(?!150))', re.DOTALL)
        
        new_content = pattern2.sub(new_header_block, content)
        
        # 2. Inject the CSS right before </head>
        if 'id="index-header-css"' not in new_content:
            new_content = new_content.replace('</head>', f'{index_css}\n</head>')
            
        with open(file, 'w', encoding='utf-8') as f:
            f.write(new_content)
        
        print(f"Updated {file}")
