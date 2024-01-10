import psycopg2
from sshtunnel import SSHTunnelForwarder
import shutil
import os
import csv


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


def formatPath(path, path_to_replace, new_path_start):
    new_path = path.replace(path_to_replace, new_path_start)
    return new_path

def getKeepFilePaths(media_id, path_to_replace, new_path_start):
    keep_paths = []
    try:
        cursor = conn.cursor()
        cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) AND appraisal_decision is null;", (media_id,))
        # Only add non-blank paths to the list
        for row in cursor.fetchall():
            file_path = row[0]
            if file_path and file_path.strip():  # Check if the path is not blank
                keep_paths.append(formatPath(file_path, path_to_replace, new_path_start))
    except Exception as e:
        print(f"Error retrieving file paths: {e}")
    finally:
        cursor.close()
    
    return keep_paths

def copyFile(source_path, source_root, destination_root):
    try:
        destination_path = os.path.join(destination_root, os.path.relpath(source_path, source_root))

        #make directories at destination
        os.makedirs(os.path.dirname(destination_path), exist_ok=True)

        shutil.copy2(source_path, destination_path)

        print(f"Copied {source_path} to {destination_path}")
        return True
    except Exception as e:
        print(f"Error copying {source_path} to {destination_path}: {e}")
        return False



def main():
    digital_media_id = input("What digital media ID are you working on? ")
    cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) LIMIT 1;", (digital_media_id, ))
    print(f"Sample file path from database: {cursor.fetchone()}")
    
    source_old_root = input('What is the root path in the database? ')
    source_new_root = input("What is the root path for the files to copy? ")
    destination_path = input("What is the root path for the destination directory? ")

    files_to_copy = getKeepFilePaths(digital_media_id, source_old_root, source_new_root)

    files_moved = 0 
    errors = 0

    # Get the script's directory
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Assuming the logs folder is in the parent directory of your script
    logs_folder = os.path.join(script_dir, 'logs')
    with open(os.path.join(logs_folder, f'{digital_media_id}-ingest-errors.csv'), 'w') as error_csv:
        writer = csv.writer(error_csv)
        writer.writerow(['error_paths'])
        for path in files_to_copy:
            if copyFile(path, source_new_root, destination_path):
                files_moved += 1

            else: 
                writer.writerow([path])
                errors += 1

    print(f"{files_moved} files moved")
    print(f"{errors} errors")

    cursor.close()
    conn.close()

if __name__ == "__main__":
    main()
