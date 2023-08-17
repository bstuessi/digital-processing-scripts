import csv
import subprocess


# function that calls shell function du to calculate the size of a directory

def du(path):
    return subprocess.check_output(['du','-sb', '--apparent-size', path]).split()[0].decode('utf-8')


def addDirectorySize(input_csv_path):
    with open(input_csv_path, 'r') as in_csvfile, \
        open (f"{input_csv_path}_updated", 'w') as out_csvfile:
        reader = csv.DictReader(in_csvfile)
        writer = csv.DictWriter(out_csvfile, fieldnames=reader.fieldnames)
        writer.writeheader()

        for row in reader:
            if row['TYPE'] == "Folder":
                row['SIZE'] = du(row['FILE_PATH'])
            writer.writerow(row)
            


if __name__ == '__main__':
    csv_path = '/home/bcadmin/Desktop/deduplication_project/droid_test.csv'
    addDirectorySize(csv_path)

