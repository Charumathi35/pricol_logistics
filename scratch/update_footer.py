import glob

html_files = glob.glob('*.html')
target_string = '</body>'
replacement = '<script src="./js/custom-footer.js"></script></body>'

for file in html_files:
    try:
        with open(file, 'r', encoding='utf-8') as f:
            content = f.read()
            
        if '<script src="./js/custom-footer.js"></script>' not in content:
            content = content.replace(target_string, replacement)
            
            with open(file, 'w', encoding='utf-8') as f:
                f.write(content)
        print(f'Updated {file}')
    except Exception as e:
        print(f'Failed on {file}: {e}')
