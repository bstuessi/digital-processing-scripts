import csv
import subprocess


# function that calls shell function du to calculate the size of a directory

def du(path):
    # Run the du command and capture its output as bytes
    result_bytes = subprocess.check_output(['du', '-sAk', path])

    # Convert the bytes to a string and split to get the size
    result_string = result_bytes.decode('utf-8')
    size_in_kilobytes = int(result_string.split()[0])

    # Convert kilobytes to bytes (1 kilobyte = 1024 bytes)
    size_in_bytes = size_in_kilobytes * 1024

    return size_in_bytes


def addDirectorySize(input_csv_path):
    with open(input_csv_path, 'r') as in_csvfile, \
        open (f"{input_csv_path.split('.')[0]}_updated.csv", 'w') as out_csvfile:
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

