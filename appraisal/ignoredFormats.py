import csv
import os

directory_path = '/Users/mkf26/Documents/code/digital-processing-scripts/appraisal/digital_bedrock_ignore_logs'
new_formats = []

with open('/Users/mkf26/Documents/code/digital-processing-scripts/appraisal/combined_ignore_puids.csv', 'w') as puid_csv:
    fieldnames = ['PUID', 'Name', 'Extension']
    writer = csv.DictWriter(puid_csv, fieldnames=fieldnames)
    writer.writeheader()
    # Loop through all files in the directory
    for filename in os.listdir(directory_path):
        file_path = os.path.join(directory_path, filename)
        if os.path.isfile(file_path):
            with open(file_path, 'r') as ig_csv:
                reader = csv.DictReader(ig_csv)
                for row in reader:
                    new_row = {'PUID': row['PUID'], 'Name': row['FORMAT_NAME'], 'Extension': row['EXT']}
                    if row['PUID'] and new_row not in new_formats:
                        writer.writerow(new_row)
                        new_formats.append(new_row)
    
