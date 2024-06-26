import csv
import psycopg2
import re

conn = psycopg2.connect(database="digital_appraisal_new",
                        host="localhost",
                        user="mkf26",
                        password="clover",
                        port="5432")

cursor = conn.cursor()

def addMedia(id, media_type, group_id, rank):
    try:
        # add corresponding SIP information (this could also be done in bulk)
        cursor.execute("INSERT INTO media (id, media_type, group_id, rank) VALUES (%s, %s, %s, %s) ON CONFLICT (id) DO UPDATE SET rank=EXCLUDED.rank;", 
                    (id, media_type, group_id, rank))
        conn.commit()
        print(f"INSERT successful: {id}")
    except Exception as e:
        conn.rollback()
        print(f"INSERT failed: {e}")

def processCSV(csvpath):
    with open(csvpath, 'r') as csv_file:
        reader = csv.DictReader(csv_file)
        for row in reader:
            addMedia(row['media_id'], row['media_type'], row['group_id'], row['rank'])

def main():
    csv_path = '/Users/mkf26/Documents/code/digital-processing-scripts/csvs/media_import.csv'
    processCSV(csv_path)
    cursor.close()
    conn.close()


main()


