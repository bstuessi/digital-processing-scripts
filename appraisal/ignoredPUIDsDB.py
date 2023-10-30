import csv
import psycopg2

conn = psycopg2.connect(database="digital_appraisal_test",
                        host="localhost",
                        user="mkf26",
                        password="clover",
                        port="5432")

cursor = conn.cursor()


def addPUIDs(csv_path):
    with open(csv_path, 'r', newline='') as puid_csv:
        reader = csv.reader(puid_csv)
        #skip header
        next(reader)
        for row in reader:
            cursor.execute('INSERT INTO ignored_formats (puid, name) VALUES (%s, %s);', (row[0], row[1]))
            conn.commit()

def main():
    puid_csv_path = '/Users/mkf26/Documents/code/digital-processing-scripts/appraisal/ignored_file_formats.csv'
    addPUIDs(puid_csv_path)
    cursor.close()
    conn.close()

main()