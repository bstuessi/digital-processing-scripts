import psycopg2
import os
from datetime import datetime

# Connect to the PostgreSQL database
connection = psycopg2.connect(database="digital_appraisal_test",
                            host="localhost",
                            user="mkf26",
                            password="clover",
                            port="5432")

cursor = connection.cursor()

# SQL query to fetch rows containing file paths
select_query = "SELECT id, file_path FROM files"

# SQL query to update the timestamp column
update_query = "UPDATE files SET mtime = %s WHERE id = %s"

try:
    # Execute the SELECT query
    cursor.execute(select_query)

    # Fetch all rows
    rows = cursor.fetchall()

    for row in rows:
        file_id, file_path = row
        file_path = f"/Volumes/{file_path}"
        if os.path.exists(file_path):
            # Get the modification timestamp (mtime) of the file
            mtime = os.path.getmtime(file_path)
            formatted_mtime = datetime.utcfromtimestamp(mtime).strftime('%Y-%m-%d %H:%M:%S')
            # Update the timestamp column with the mtime value
            cursor.execute(update_query, (formatted_mtime, file_id))
            print(f"Updated timestamp for file ID {file_id} with mtime {formatted_mtime}")

    # Commit the changes to the database
    connection.commit()
except Exception as e:
    # Handle any exceptions here
    print(f"Error: {e}")
finally:
    # Close the cursor and database connection
    cursor.close()
    connection.close()
