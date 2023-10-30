import csv
import psycopg2
import re

conn = psycopg2.connect(database="digital_appraisal",
                        host="localhost",
                        user="mkf26",
                        password="clover",
                        port="5432")

cursor = conn.cursor()

def addMedia(id, media_type, group_id, rank):
    # add corresponding SIP information (this could also be done in bulk)
    cursor.execute("INSERT INTO media (id, media_type, group_id, rank) VALUES (%s, %s, %s, %s) ON CONFLICT (id) DO UPDATE SET rank=EXCLUDED.rank;", 
                (id, media_type, group_id, rank))
    conn.commit()

def addFilesDirs(csv_path, media_id):
    # open csv
    with open(csv_path, 'r') as DROID_csv:
        reader = csv.DictReader(DROID_csv)
        #transfer the csv data into a list that can be sorted
        droid_data = list(reader)
        #sort the list on ID so that all parent IDs are already in the database when connecting files and directories
        sorted_droid_data = sorted(droid_data, key=lambda x: int(x['ID']))
        #create blank directory dictionary for 
        directory_ids = {'': None}
        for row in sorted_droid_data:
            #format the file path value to be non-machine specific (this will be helpful later when programmatically copying files)
            if 'bcadmin' in row['FILE_PATH']:
                path = row['FILE_PATH'].split('/', 3)[-1]
            elif 'Volumes' in row['FILE_PATH']:
                path = row['FILE_PATH'].split('/', 2)[-1]
            else:
                path = row['FILE_PATH']
            #if the row is a directory or a container file (archive file)
            if row['TYPE'] == "Folder" or row['TYPE'] == "Container":
                #set size to a variable and check if empty, if empty set to None which will be converted to NULL upon insert
                size = row['SIZE']
                if size == '':
                    size = None
                else:
                    #dealing with scientific notation numbers by converting to a float and then a string
                    size = int(float(size))
                #format values for insert statement
                dir_input = (directory_ids[row['PARENT_ID']], path, row['NAME'], size, row['LAST_MODIFIED'] if row['LAST_MODIFIED'] else None, media_id)
                #insert into directories and retunr the ID
                cursor.execute("INSERT INTO directories (parent_directory_id, dir_path, dir_name, size, mtime, digital_media_id) VALUES (%s, %s, %s, %s, %s, %s) RETURNING id;", dir_input)
                #add directory ID to directory_ids dict - this will then be matched using the parent ID field from the droid report later in the script
                directory_ids[row['ID']] = cursor.fetchone()[0]
            #prepare and insert into files
            elif row['TYPE'] == "File":
                #handling for possibility of empty formats from DROID - changing value to unidentified
                format = {'puid': row['PUID'], 'name': row['FORMAT_NAME'], 'extension': re.sub('[^A-Za-z0-9]+', '', row['EXT'][:254]) if len(row['EXT']) > 255 else re.sub('[^A-Za-z0-9]+', '', row['EXT']),'mime': row['MIME_TYPE']}
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
                #check to see if the format already exists in format table, deal with NULL version separately    
                if version:
                    cursor.execute(f"SELECT id FROM formats WHERE puid = '{format['puid']}' AND version = '{version}' AND extension = '{format['extension']}';")
                else:
                    cursor.execute(f"SELECT id FROM formats WHERE puid = '{format['puid']}' AND extension = '{format['extension']}' AND version IS NULL;")
                #grad format ID from cursoe
                format_id = cursor.fetchone()
                #if no mathcing format id, create new format
                if format_id == None:
                    cursor.execute("INSERT INTO formats (puid, name, mime_type, extension, version) VALUES (%s,%s,%s,%s, %s) RETURNING id;", (format['puid'], format['name'], format['mime'], format['extension'], version))
                    format_id = cursor.fetchone()[0]
                #otherwise, set format id value equal to the value form the above cursor fetch 
                else:
                    format_id = format_id[0]
                #bring it all together and insert into the files table
                cursor.execute("INSERT INTO files (directory_id, file_path, file_name, size, mtime, md5_hash, format_id, digital_media_id) VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING *;", (directory_ids[row['PARENT_ID']], path, row['NAME'], row['SIZE'], row['LAST_MODIFIED'], row['MD5_HASH'], format_id, media_id))
                print(f"INSERT: {cursor.fetchone()}")
            conn.commit()

def main():
    csv_path = '/Users/mkf26/Desktop/hd_appraisal/D_0223/D_0223_droid_w_dir_sizes.csv'
    addMedia('D_0223', 'internal hard drive', '2.1', 24)
    addFilesDirs(csv_path, 'D_0223')
    cursor.close()
    conn.close()

main()

