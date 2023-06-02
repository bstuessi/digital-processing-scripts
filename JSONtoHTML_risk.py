import json
from pprint import pprint
from bs4 import BeautifulSoup

def generate_html(json_data, soup):
    soup.find('title').string = 'Floppy disk file format reports with file risk assessments'
    header = soup.new_tag('h1')
    header.string = 'Floppy disk file format reports'
    body = soup.find('body')
    body.append(header)
    for AIPdir, attributes in json_data.items():
        newH2 = soup.new_tag('h2', id=AIPdir)
        newH2.string = AIPdir
        body.append(newH2)
        
        note = soup.new_tag('h3', attrs={'class':'note'})
        note.string = f"Content note: {attributes['note']}"
        body.append(note)

        
        formats = soup.new_tag('div', attrs={'class':'formats'})
        format_h3 = soup.new_tag('h3')
        format_h3.string = "Formats:"
        formats.append(format_h3)
        format_ul = soup.new_tag('ul')
        
        for formdict in attributes['formats']:
            li = soup.new_tag('li')
            if formdict['format'] == '':
                li.string = f"Unidentified: {formdict['count']}"
               
            else:
                li.string = f"{formdict['format']}: {formdict['count']} ({formdict['risk']})"
                
            format_ul.append(li)
        formats.append(format_ul)
        body.append(formats)
        tree_tag = soup.new_tag('div', attrs={'class':'file-tree'})
        tree_button = soup.new_tag('button', atrrs={'class':'dropdown-btn'})
        tree_button['onclick'] = "toggleDropdown(this)"
        tree_button.string = "See file tree"
        tree_tag.append(tree_button)
        file_tree_path = f"/home/bcadmin/Desktop/AIPs/{AIPdir}/reports/brunnhilde/tree.txt"
        with open(file_tree_path, "r") as file:
            tree = file.read()
            #tree = tree.replace('\n', '<br>')
            file_tree_pre = soup.new_tag('pre')
            file_tree_pre.append(tree)
            dropdown_div = soup.new_tag('div', attrs={'class':'dropdown-content'})
            dropdown_div.append(file_tree_pre)
        tree_tag.append(dropdown_div)
        body.append(tree_tag)
    return str(soup)
    

def save_to_html(json_file_path, html_file_path):
    with open(json_file_path, 'r') as json_file:
        json_data = json.load(json_file)
    with open('reportTemplate.html', 'r') as html_file:
        soup = BeautifulSoup(html_file, 'html.parser')
    html_content = generate_html(json_data, soup)

    with open(html_file_path, 'w') as html_file:
        html_file.write(html_content)

# Usage example
json_file_path = '/home/bcadmin/Desktop/AIPs/formatReport.json'  # Path to your JSON file
html_file_path = '/home/bcadmin/Desktop/AIPs/formatReport.html'  # Path where the HTML file will be saved

save_to_html(json_file_path, html_file_path)
