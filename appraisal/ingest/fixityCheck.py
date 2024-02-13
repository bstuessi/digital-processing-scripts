import psycopg2
from sshtunnel import SSHTunnelForwarder
import os
import csv
import re




def getRelativePath(file_path):
    relative_path = re.sub('^.*original_files', '', file_path)   
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
    cursor.execute("SELECT file_path, md5_hash FROM files WHERE digital_media_id = (%s) AND appraisal_decision is null;", (digital_media_id,))

    paths = {}

    for row in cursor.fetchall():
        paths[row[0]] = row[1]

    return paths

def addToErrorLog(digital_media_id, error_list):
    # Get the script's directory
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Assuming the logs folder is in the parent directory of your script
    logs_folder = os.path.join(script_dir, 'logs')
    error_log_path = os.path.join(logs_folder, f"{digital_media_id}_fixity_errors.csv")
    with open(error_log_path, 'w') as error_csv:
        writer = csv.writer(error_csv)
        writer.writerow(['error_type', 'server_path', 'server_hash', 'db_path(s)', 'db_hash(es)' 'message'])
        for error in error_list:
            writer.writerow(error)
    print(f"{len(error_list)} fixity errors, details at {error_log_path}")



#open siegfried file and verify cehcksums, returns a list of errors to be logged
def processSiegfried(csv_path, db_dict):
    errors = []
    success_count = 0
    error_count = 0
    with open(csv_path, 'r') as sf_csv:
        reader = csv.DictReader(sf_csv)
        for row in reader:

        #modify filename row to be relative
            server_path = getRelativePath(row['filename'])

            matching_paths = [key for key in db_dict.keys() if server_path in key]
            matching_hashes = [db_dict[path] for path in matching_paths]
            #if there is only one matching path, continue
            if matching_paths:
                if row['md5'] in matching_hashes:
                    print(f"{server_path} verified")
                    success_count+=1

                else:
                    #add to list for error log
                    errors.append(["Fixity", server_path, row['md5'], matching_paths, matching_paths, "Fixity check with database failed"])
                    print(f"Fixity check failed for {server_path}")
            #if no matching paths located
            else:
                errors.append(["Location", server_path, row['md5'], matching_paths, '', "No matching paths identified in database"])
                print(f"No matching paths identified for {server_path}")
                error_count+=1
    print(f"{success_count} files verified")
    return(errors)



def main():
    digital_media_id = input('What digital media ID are you working on?')
    siegfried_path = input('What is the path to the siegfried file?')

    db_paths = getDBpaths(digital_media_id)

    fixity_errors = processSiegfried(siegfried_path, db_paths)

    addToErrorLog(digital_media_id, fixity_errors)


if __name__ == "__main__":
    main()




