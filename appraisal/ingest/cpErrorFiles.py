
import shutil
import os
import csv



def formatPath(path, path_to_replace, new_path_start):
    new_path = path.replace(path_to_replace, new_path_start)
    return new_path


def parseCSV(path):
    with open(path, 'r', encoding='utf-8') as error_csv:
        reader = csv.reader(error_csv)
        headers = next(reader)
        file_paths = [row[0] for row in reader]
    return file_paths

        

def copyFile(source_path, source_root, destination_root):
    try:
        destination_path = os.path.join(destination_root, os.path.relpath(source_path, source_root))
        destination_path = ''.join(c for c in destination_path if c not in '"*:<>?\\|')
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
    source_new_root = input("What is the root path for the files to copy? ")
    destination_path = input("What is the root path for the destination directory? ")

    error_csv_path = input("What is the path to error csv you are working on? ")

    files_to_copy = parseCSV(error_csv_path)

    files_moved = 0 
    errors = 0

    # Get the script's directory
    script_dir = os.path.dirname(os.path.abspath(__file__))

    # Assuming the logs folder is in the parent directory of your script
    logs_folder = os.path.join(script_dir, 'logs')
    with open(os.path.join(logs_folder, f'{digital_media_id}_errors-ingest-errors.csv'), 'w') as error_csv:
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


if __name__ == "__main__":
    main()
