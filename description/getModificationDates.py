import os
import pandas as pd
from datetime import datetime


def process_csv(file_path):
    # Read the CSV file into a DataFrame
    df = pd.read_csv(file_path, delimiter=",")

    # Convert 'Year Last Modified' column to datetime
    df['Year Last Modified'] = pd.to_datetime(df['Year Last Modified'], format='%Y')

    # Initialize variables for max and min dates
    max_date = None
    min_date = None

    # Iterate over the rows to find max and min dates
    for year, count in zip(df['Year Last Modified'], df['Count']):
        if count > 0:  # Exclude outliers with count less than or equal to 100
            if max_date is None or year > max_date:
                max_date = year
            if min_date is None or year < min_date:
                min_date = year

    return min_date, max_date

def get_date_ranges(dir_path):
    year_ranges = {"digital_media_id": [],
                   "year_range": []}
    for dir in os.listdir(dir_path):
        if "D-" in dir:
            digital_media_id = dir
            year_ranges["digital_media_id"].append(digital_media_id)
            years_file_path = os.path.join(dir_path, dir, f"reports/{digital_media_id}_brunn_reports/csv_reports/years.csv")
            min_date, max_date = process_csv(years_file_path)
            min_year = min_date.year if min_date else None
            max_year = max_date.year if max_date else None
            year_ranges['year_range'].append(f'{min_year} - {max_year}')
    return year_ranges

def write_to_csv(csv_path, range_dict):
    df = pd.DataFrame(range_dict)
    df.to_csv(csv_path, index=False)


def main():
    directory = '/Volumes/MKFA/ARCHIVES STORAGE/Born_digital_processing/floppy_disks'
    csv_path = '/Users/mkf26/Documents/DigPres/digital_processing/description_docs/floppy_year_ranges.csv'
    ranges = get_date_ranges(directory)
    write_to_csv(csv_path, ranges)
    

if __name__ == '__main__':
    main()