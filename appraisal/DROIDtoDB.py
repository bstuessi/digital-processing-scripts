import csv
import psycopg2

conn = psycopg2.connect(database="digital_appraisal_test",
                        host="localhost",
                        user="mkf26",
                        password="clover",
                        port="5432")

cursor = conn.cursor()

def addSIP(id, media_type, transfer_method, rank):
    # add corresponding SIP information (this could also be done in bulk)
    cursor.execute("INSERT INTO SIPs (id, media_type, transfer_method, rank) VALUES (%s, %s, %s, %s) ON CONFLICT (id) DO UPDATE SET rank=EXCLUDED.rank;", 
                (id, media_type, transfer_method, rank))
    conn.commit()

def addFilesDirs(csv_path, SIP):
    # open csv
    with open(csv_path, 'r') as DROID_csv:
        reader = csv.DictReader(DROID_csv)
        directory_ids = {}
        for row in reader:
            if row['TYPE'] == "Folder" or row['TYPE'] == "Container":
                dir_input = (row['FILE_PATH'], row['NAME'], int(row['SIZE']), SIP)
                cursor.execute("INSERT INTO directories (dir_path, dir_name, size, digital_media_id) VALUES (%s, %s, %s, %s) RETURNING id;", dir_input)
                directory_ids[row['ID']] = cursor.fetchone()[0]
            elif row['TYPE'] == "File":
                #handling for possibility of empty/unidentified formats from DROID
                format = {'puid': row['PUID'], 'name': row['FORMAT_NAME'], 'mime': row['MIME_TYPE']}
                for value in format:
                    if format[value]:
                        continue
                    else:
                        format[value] = 'Unidentified'
                #controlling for empty version field, setting empty values to NULL
                if row['FORMAT_VERSION']:
                    version = f"{row['FORMAT_VERSION']}"
                else:
                    version = None
                if version:
                    cursor.execute(f"SELECT id FROM formats WHERE puid = '{format['puid']}' AND version = '{version}';")
                else:
                    cursor.execute(f"SELECT id FROM formats WHERE puid = '{format['puid']}' AND version IS NULL;")
                format_id = cursor.fetchone()
                if format_id == None:
                    cursor.execute("INSERT INTO formats (puid, name, mime_type, version) VALUES (%s,%s,%s,%s) RETURNING id;", (format['puid'], format['name'], format['mime'], version))
                    format_id = cursor.fetchone()[0]
                else:
                    format_id = format_id[0]
                cursor.execute("INSERT INTO files (directory_id, file_path, file_name, size, md5_hash, format_id, digital_media_id) VALUES (%s, %s, %s, %s, %s, %s, %s) RETURNING *;", (directory_ids[row['PARENT_ID']], row['FILE_PATH'], row['NAME'], row['SIZE'], row['MD5_HASH'], format_id, SIP))
                print(f"INSERT: {cursor.fetchone()}")
            conn.commit()

def main():
    csv_path = '/Volumes/Brock\'s Dri/D_0199_DROID.csv'
    addSIP('D_0199', 'computer', 'disk image', 10)
    addFilesDirs(csv_path, 'D_0199')
    cursor.close()
    conn.close()

main()

