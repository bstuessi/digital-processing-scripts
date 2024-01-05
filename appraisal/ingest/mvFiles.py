import psycopg2
# from sshtunnel import SSHTunnelForwarder
import shutil
import os
import csv


# #connect to database using ssh port forwarding workflow
# server = SSHTunnelForwarder(
#     ('10.0.1.139', 22),
#     ssh_username='bcadmin',
#     ssh_pkey='/Users/mkf26/.ssh/id_ed25519',
#     ssh_private_key_password='Poltergeist96!',
#     remote_bind_address=('localhost', 5432)
# )

# server.start()

# print(server.local_bind_port)  # show assigned local port
# # work with `SECRET SERVICE` through `server.local_bind_port`.

# conn = psycopg2.connect(
#     database='digital_appraisal_new',
#     user='bcadmin',
#     host=server.local_bind_host,
#     port=server.local_bind_port,
#     password='090696')
# cur = conn.cursor()

#local connection
conn = psycopg2.connect(database="digital_appraisal_new",
                        host="localhost",
                        user="bcadmin",
                        password="bhu89IJN",
                        port="5432")

cursor = conn.cursor()


def formatPath(path, path_to_replace, new_path_start):
    new_path = path.replace(path_to_replace, new_path_start)
    return new_path

#function that gets scope file paths 
def getScopeFilePaths(media_id, path_to_replace, new_path_start):
    cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) AND appraisal_decision = 'scope';", (media_id,))
    scope_paths = [formatPath(row[0], path_to_replace, new_path_start) for row in cursor.fetchall()]
    return scope_paths


def getDuplicateFilePaths(media_id, path_to_replace, new_path_start):
    cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) AND appraisal_decision = 'duplicate';", (media_id,))
    duplicate_paths = [formatPath(row[0], path_to_replace, new_path_start) for row in cursor.fetchall()]
    return duplicate_paths


def moveFile(origin_path, target_dir_path):
    try:
        relative_origin_path = os.path.relpath(origin_path, target_dir_path)
        relative_origin_path = relative_origin_path.replace('../', '')
        destination_file_path = os.path.join(target_dir_path, relative_origin_path)
        os.makedirs(os.path.dirname(destination_file_path), exist_ok=True)
        shutil.move(origin_path, destination_file_path)
        print(f"Moved: {origin_path} to {destination_file_path}")
        return True
    except Exception as e:
        print(f"Error moving {origin_path} to {destination_file_path}: {e}")
        return False



def makeDeaccessionDirs(base_path):
    deaccession_dir = os.path.join(base_path, 'deaccession')
    os.makedirs(deaccession_dir, exist_ok=True)
    scope_dir = os.path.join(deaccession_dir, 'scope')
    dupe_dir = os.path.join(deaccession_dir, 'duplicates')
    os.makedirs(scope_dir, exist_ok=True)
    os.makedirs(dupe_dir, exist_ok=True)
    return {'deaccession': deaccession_dir,
            'scope': scope_dir,
            'dupe': dupe_dir}



def main():
    digital_media_id = input("What digital media ID are you working on? ")
    cursor.execute("SELECT file_path FROM files WHERE digital_media_id = (%s) LIMIT 1;", (digital_media_id, ))
    print(f"Sample file path from database: {cursor.fetchone()}")
    
    path_to_replace = input('What is the root path in the database? ')
    new_path_start = input("What is the root path for the copied files? ")
    
    deaccession_directories = makeDeaccessionDirs(new_path_start)
    deaccession_directory = deaccession_directories['deaccession']
    scope_directory = deaccession_directories['scope']
    dupe_directory = deaccession_directories['dupe']
    
    scope_paths = getScopeFilePaths(digital_media_id, path_to_replace, new_path_start)
    dupe_paths = getDuplicateFilePaths(digital_media_id, path_to_replace, new_path_start)

    files_moved = 0 
    errors = 0
    
    # Get the script's directory
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Assuming the logs folder is in the parent directory of your script
    logs_folder = os.path.join(script_dir, 'logs')
    with open(os.path.join(logs_folder, f'{digital_media_id}-ingest-errors.csv'), 'w') as error_csv:
        writer = csv.writer(error_csv)
        writer.writerow(['error_paths'])
        for path in scope_paths:
            if moveFile(path, scope_directory):
                files_moved += 1
            else: 
                errors += 1

        for path in dupe_paths:
            if moveFile(path, dupe_directory):
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
