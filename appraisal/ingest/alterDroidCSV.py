import psycopg2
from sshtunnel import SSHTunnelForwarder
import os
import csv
import re
import sys




def getRelativePath(file_path, to_get_rid_of):
    relative_path = re.sub(f'^{to_get_rid_of}', '', file_path)   
    return relative_path

#create a dict from database using digital_media_id with file_path: checksum pairs
def getDBpaths(digital_media_id):
    #connect to database using ssh port forwarding workflow
    server = SSHTunnelForwarder(
        ('10.0.1.202', 22),
        ssh_username='bcadmin',
        ssh_pkey='/Users/mkf26/.ssh/id_ed25519',
        ssh_private_key_password='Poltergeist96!',
        remote_bind_address=('localhost', 5432)
    )

    server.start()

    print(server.local_bind_port)  # show assigned local port
    # work with `SECRET SERVICE` through `server.local_bind_port`.

    conn = psycopg2.connect(
        database='digital_appraisal_new',
        user='bcadmin',
        host=server.local_bind_host,
        port=server.local_bind_port,
        password='bhu89IJN')


    # #local connection
    # conn = psycopg2.connect(database="digital_appraisal_new",
    #                         host="localhost",
    #                         user="bcadmin",
    #                         password="bhu89IJN",
    #                         port="5432")

    cursor = conn.cursor() 
    cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) AND appraisal_decision is null;", (digital_media_id,))

    paths = [output[0] for output in cursor.fetchall()]

    return paths


def parseCSV(csv_path, db_paths):
    new_droid_data = []
    print(f"Path from database: {db_paths[0]}")
    to_replace = input(f"What portion of path should be discarded? ")
    with open(csv_path, 'r') as og_droid_report:
        reader = csv.DictReader(og_droid_report)
        new_droid_data.append(reader.fieldnames)
        for row in reader:
            if row['FILE_PATH'] in db_paths:
                row['FILE_PATH'] = getRelativePath(row['FILE_PATH'], to_replace)
                new_droid_data.append(row)
            else:
                continue
    return new_droid_data


def createNewDroidCSV(data, digital_media_id):
    with open(f'/Volumes/MKFA/ARCHIVES STORAGE/Born_digital_processing/digital_appraisal_capture/{digital_media_id}/reports/{digital_media_id}_DROID.csv', 'w') as new_csv:
        writer = csv.writer(new_csv)
        for row in data:
            writer.writerow(row)
    

def main():
    digital_media_id = input("What digital media ID are you working on? ")
    droid_csv = input("What is the path to the ")
    db_paths = getDBpaths(digital_media_id)


    