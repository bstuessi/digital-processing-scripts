import sys
import csv
import json
import os
import pandas as pd
from pprint import pprint



def addToJSON(new_dict, filepath='/home/bcadmin/Desktop/AIPs/formatReport.json'):
    with open(filepath, 'r+', encoding='utf-8') as json_file:
        file_data = json.load(json_file)
        file_data.update(new_dict)
        json_file.seek(0)
        json.dump(file_data, json_file, indent=4)
        json_file.truncate()


def parseCSVs(formats_csv_path, main_key):
    format_dict = {main_key: {'formats': []}}
    with open(formats_csv_path, 'r', newline='', encoding='utf-8-sig') as csvfile:
        reader = csv.DictReader(csvfile)
        for row in reader:
            format_row = {}
            format_row['format'] = row['Format']
            format_row['puid'] = row['ID']
            format_row['count'] = row['Count']
            format_dict[main_key]['formats'].append(format_row)
    addToJSON(format_dict)

def parseXlsx(formats_xlsx_path, main_key):
    format_dict = {main_key: {'formats': []}}
    excel_df = pd.read_excel(formats_xlsx_path, sheet_name='Format Subtotal', usecols=['FITS_Format_Name', 'NARA_Risk Level', 'File Count'])
    reader = excel_df.to_dict(orient='records')
    #reader = csv.DictReader(csvfile)
    for row in reader:
        format_row = {}
        format_row['format'] = row['FITS_Format_Name']
        format_row['risk'] = row['NARA_Risk Level']
        format_row['count'] = row['File Count']
        format_dict[main_key]['formats'].append(format_row)
    addToJSON(format_dict)

def addNotes(json_file_path, csv_path):
    with open(json_file_path, 'r+') as json_file:
        file_data = json.load(json_file)
        with open(csv_path, 'r', newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                file_data[row['directory_name']]['note'] = row['notes']
        json_file.seek(0)
        json.dump(file_data, json_file, indent=4)

def addRankings(json_file_path, csv_path):
    with open(json_file_path, 'r+') as json_file:
        file_data = json.load(json_file)
        with open(csv_path, 'r', newline='', encoding='utf-8') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                ranking_dict = {'content_ranking': row['content_ranking'], 'content_note': row['content_note'], 'access_ranking': row['access_ranking'], 'access_note': row['access_note'], 'preservation_ranking': row['preservation_ranking'], 'preservation_note': row['preservation_note'], 'other_note': row['other_note']}
                file_data[row['directory_name']]['rankings'] = ranking_dict
        json_file.seek(0)
        json.dump(file_data, json_file, indent=4)

def sortJSONbyRank(json_file_path):
    with open(json_file_path, 'r+') as json_file:
        file_data = json.load(json_file)
        sorted_data = sorted(file_data.items(), key=lambda x: int(x[1]['rankings']['content_ranking']), reverse=True)
        # Reconstruct the dictionary from the sorted list
        sorted_dict = {k: v for k, v in sorted_data}
        # Reset the file pointer and write the sorted JSON data
        json_file.seek(0)
        json.dump(sorted_dict, json_file, indent=4)
        # Truncate any remaining content in the file
        json_file.truncate()


def main():
    AIP_directory = sys.argv[1]
    for directory in os.listdir(AIP_directory):
        base_path = os.path.join(AIP_directory, directory)
        if os.path.isdir(base_path):
            formats_xls_path = base_path + "/reports/risk_assessment/extracted_files_format-analysis.xlsx"
            parseXlsx(formats_xls_path, directory)
            formats_csv_path = base_path + "/reports/brunnhilde/csv_reports/formats.csv"
            parseCSVs(formats_csv_path, directory)
    addNotes('/home/bcadmin/Desktop/AIPs/formatReport.json', '/home/bcadmin/code/digital-processing-scripts/csvs/aip_content_notes.csv')
    addRankings('/home/bcadmin/Desktop/AIPs/formatReport.json', '/home/bcadmin/code/digital-processing-scripts/csvs/floppy_disk_rankings.csv')
    sortJSONbyRank('/home/bcadmin/Desktop/AIPs/formatReport.json')   


main()