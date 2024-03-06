import psycopg2
from sshtunnel import SSHTunnelForwarder
import pandas as pd
import shutil
import re


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


def get_ids():
    cursor = conn.cursor()
    cursor.execute("SELECT digital_media_id FROM files WHERE appraisal_decision IS NOT NULL GROUP BY digital_media_id;")
    d_ids = [item[0] for item in cursor.fetchall()]
    return d_ids

def get_deaccession_data(digital_media_id):
    cursor = conn.cursor()
    #get scope file list
    cursor.execute("""
                    SELECT 
                    fi.id,
                    file_path, 
                    file_name, 
                    size, 
                    mtime, 
                    md5_hash,
                    file_type,
                    appraisal_decision,
                    file_user, 
                    puid,
                    name,
                    mime_type, 
                    extension,
                    version
                    from files fi
                    join formats fo
                    on fi.format_id = fo.id
                    where digital_media_id = (%s)
                    and appraisal_decision is not null;""", (digital_media_id,))
    # Fetch the headers
    headers = [desc[0] for desc in cursor.description]
    deaccession_data = []
    deaccession_data.append(headers)
    for row in cursor.fetchall():
        row = list(row)
        deaccession_data.append(row)
    return(deaccession_data)

def write_csv_report(csv_path, data):
    df = pd.DataFrame(data[1:], columns=data[0])
    df.to_csv(csv_path, index=False)

def main():
    ids = get_ids()
    for id in ids:
        csv_path = f'/Users/mkf26/Documents/DigPres/digital_processing/deaccession_reports/{id}_deaccessions.csv'
        data = get_deaccession_data(id)
        write_csv_report(csv_path, data)

main()