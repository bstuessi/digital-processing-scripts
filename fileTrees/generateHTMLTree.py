import subprocess
from bs4 import BeautifulSoup
import re

# Use file tree util to get a json file tree from a given directory
def getFileTreeJSON(dir_path):
    tree = subprocess.run(["tree", "-JDh", dir_path], capture_output=True, text=True, timeout=500)
    return tree.stdout

def generateHTML(dir_path, soup):
    tree_data = getFileTreeJSON(dir_path)
    tree_data = eval(tree_data)  # Convert JSON string to Python dict
    body = soup.find('body')
    digital_media_id_search = re.search('D-[\dA-E]{4,5}', tree_data[0]['name'])
    digital_media_id = digital_media_id_search.group()
    header = soup.new_tag('h1')
    header.string = digital_media_id + " File Tree"
    body.append(header)
    def process_entry(entry, parent, margin):
        if entry["type"] == "directory":
            # If the directory is not the top-level one, create HTML elements
            if entry.get("contents"):
                margin = margin + 5
                dir_div = soup.new_tag("div", attrs={"class": "directory", "id":entry['name'], "style":f"margin-left:{margin}px"})
                parent.append(dir_div)
                dir_anchor = soup.new_tag('a', attrs={"href":f"#{entry['name']}", "onclick":'toggleDropdown(this)'})
                dir_anchor.string = "📁 "+ " " + entry["name"]
                dir_div.append(dir_anchor)
                dropdown_div = soup.new_tag('div', attrs={'class':'dropdown-content'})
                dir_div.append(dropdown_div)
                if entry.get("contents"):
                    for child_entry in entry["contents"]:
                        process_entry(child_entry, dropdown_div, margin)
        elif entry["type"] == "file":
            file_span = soup.new_tag('p', attrs={"class": "file", "style":f"margin-left:{margin}px"})
            file_span.string = "📃 " + f'"{entry["name"]}"' + f" - {entry['size']}b - [{entry['time']}]"
            parent.append(file_span)
            #parent.append(soup.new_tag('br'))
    if tree_data[0].get('contents'):
        for entry in tree_data[0]['contents']:
            process_entry(entry, body, 5)

def sfileTreetoHTML(dir_path, html_file_path):
    with open('fileTrees/htmlTemplate.html', 'r') as html_file:
        soup = BeautifulSoup(html_file, 'html.parser')
    generateHTML(dir_path, soup)

    html_content = soup.prettify()
    with open(html_file_path, 'w') as html_file:
        html_file.write(html_content)

sfileTreetoHTML('/Volumes/MKFA/ARCHIVES STORAGE/Born_digital_processing/digital_appraisal_capture/D-0200/original_files', 'output.html')
