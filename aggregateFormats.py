import sys
import csv
import json
import os
from pprint import pprint



def addToJSON(new_dict, filepath='/home/bcadmin/Desktop/AIPs/formatReport.json'):
    with open(filepath, 'r+') as json_file:
        file_data = json.load(json_file)
        file_data.update(new_dict)
        json_file.seek(0)
        json.dump(file_data, json_file, indent=4)


def parseCSV(csv_path, main_key):
    with open(csv_path, 'r', newline='', encoding='utf-8-sig') as csvfile:
        reader = csv.DictReader(csvfile)
        format_dict = {main_key: {'formats': []}}
        for row in reader:
            format_row = {}
            format_row['format'] = row['Format']
            format_row['puid'] = row['ID']
            format_row['count'] = row['Count']
            format_dict[main_key]['formats'].append(format_row)
        addToJSON(format_dict)


def main():
    base_path = sys.argv[1]
    basename = os.path.basename(base_path)
    csv_path = base_path + "/reports/brunnhilde/csv_reports/formats.csv"
    parseCSV(csv_path, basename)

main()
