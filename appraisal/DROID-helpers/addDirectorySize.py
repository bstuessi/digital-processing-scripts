
import csv
import subprocess
import sys
import os
from datetime import datetime


# function that calls shell function du to calculate the size of a directory

def du(path):

    try:
        result_bytes = subprocess.check_output(['du', '-sk', path])
        result_string = result_bytes.decode('utf-8')
        size_in_kilobytes = int(result_string.split()[0])

        # Convert kilobytes to bytes (1 kilobyte = 1024 bytes)
        size_in_bytes = size_in_kilobytes * 1024

        return size_in_bytes
    except subprocess.CalledProcessError as e:
        print(f"Error: {e}\n Path: {path}")
        return None
    except FileNotFoundError as e:
        print(f"Error: Directory not found: {path}")
        return None
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        return None

def addDirectorySize(input_csv_path):
    with open(input_csv_path, 'r') as in_csvfile, \
        open (f"{input_csv_path.split('.')[0]}_w_dir_sizes.csv", 'w') as out_csvfile:
        reader = csv.DictReader(in_csvfile)
        fieldnames = reader.fieldnames
        writer = csv.DictWriter(out_csvfile, fieldnames=fieldnames)
        writer.writeheader()

        for row in reader:
            if row['TYPE'] == "Folder" and row['SIZE'] == '':
                # if created on linux machine
                # size = du(row['FILE_PATH'].replace('/media/bcadmin', '/Volumes'))
                try:
                    size = du(row['FILE_PATH'])
                except FileNotFoundError as e: 
                    print(f"Error: {e}\n Path: {row['FILE_PATH']}")
                row['SIZE'] = size
            new_row = {key: row[key] for key in fieldnames}
            writer.writerow(new_row)
            
            

if __name__ == '__main__':
    csv_path = str(sys.argv[1])
    addDirectorySize(csv_path)

