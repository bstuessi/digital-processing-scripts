import csv
import re
import os

def main():
    root_directory = '/Volumes/MKFA/ARCHIVES STORAGE/Born_digital_processing/digital_appraisal_capture/'

    for root, dirs, files in os.walk(root_directory):
        for dir in dirs:
            digital_media_id = dir
            if re.match('D-[\dA-E]{4,5}', dir):
                siegfried_csv_path = os.path.join(root, dir, f'reports/{digital_media_id}_brunn_reports/siegfried.csv')
                new_report_path = os.path.join('/Users/mkf26/Desktop/reports_for_mary', f'{digital_media_id}_file_report.csv')
                with open(siegfried_csv_path, 'r') as siegfried_csv:
                    reader = csv.DictReader(siegfried_csv)
                    fieldnames = reader.fieldnames
                    with open(new_report_path, 'w') as new_report_csv:
                        fieldnames.insert(1, 'relative_path')
                        writer = csv.DictWriter(new_report_csv, fieldnames=fieldnames)
                        for row in reader:
                            row['relative_path'] = re.sub('^.*original_files', '', row['filename'])
                            writer.writerow(row)
                    print(f'new report created: {new_report_path}')

main()
