import csv
import subprocess


# function that calls shell function du to calculate the size of a directory

def du(path):
    try:
        size = subprocess.check_output(['sudo', 'du','-sb', '--apparent-size', path]).split()[0].decode('utf-8')
        return size
    except subprocess.CalledProcessError:
        print(f"Issue retrieving directory size for {path}")  
    


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
    csv_path = '/home/bcadmin/Desktop/D_0214.csv'
    addDirectorySize(csv_path)

