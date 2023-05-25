import json
from pprint import pprint

def generate_html(json_data):
    html_content = '<!DOCTYPE html><html lang="en"><head><title>File format report</title><meta charset="utf-8"><style type="text/css">body {font-family: Arial, Helvetica, sans-serif;margin: 100px 20px 20px 20px;padding: 10px;width: 95%;}</style></head><body>'
    #html_content = 'header { position: fixed;top: 0;width: 95%;padding-bottom: 10px;border-bottom: 2px solid #000;background: white;z-index: 1001; }'
    # html_content = '<h1>Floppy disk file format report</h1>'
    for AIPdir, attributes in json_data.items():
        html_content += f"<h2>{AIPdir}</h2>"
        html_content += f"<h3>Content note: {attributes['note']}</h3>"
        html_content += f"<h3>Formats:</h3><ul>"
        for formdict in attributes['formats']:
            if formdict['format'] == '':
                html_content += f"<li>Unidentified: {formdict['count']}</li>"
            else:
                html_content += f"<li>{formdict['format']}: {formdict['count']}</li>"
        html_content += "</ul>"
    
    html_content += "</body></html>"
    return html_content
    

def save_to_html(json_file_path, html_file_path):
    with open(json_file_path, 'r') as json_file:
        json_data = json.load(json_file)
    html_content = generate_html(json_data)
    
    with open(html_file_path, 'w') as html_file:
        html_file.write(html_content)

# Usage example
json_file_path = '/home/bcadmin/Desktop/AIPs/formatReport.json'  # Path to your JSON file
html_file_path = '/home/bcadmin/Desktop/AIPs/formatReport.html'  # Path where the HTML file will be saved

save_to_html(json_file_path, html_file_path)
