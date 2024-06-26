# Digital Processing Scripts
These scripts were created during 2023-2024 by Digital Archivist, Brock Stuesi to aid in digital processing work. If you have any questions about the scripts, email Brock at stuessi.archives[at]fastmail.com.

## Appraisal
The general workflow for appraisal involved gathering file format preservation data from files on physical media using DROID, inputting that data into an SQL database, analyzing the data using queries, making appraisal decisions, and finally using the appraisal decisions to selectively import files from physical media for description and storage. 

Scripts in this directory represent this workflow as follows:

### /DROID-Helpers
The addDirectorySize.py script extends DROID functionality by adding directory sizes to a DROID csv export. 

### /database
Here you find:
* appraisal_db_setup.sql - the script for setting up the PostgreSQL appraisal database tables
* backupDB.sh - general script to automate PostgreSQL database backup
* DROItoDB.py - python script that inserts data from DROID csv exports into the appraisal database
* appraisal_trigger.sql - setup for a trigger in the database that cascades appraisal column value to all enclosing files in a directory

### /analysis
These SQL scripts reflect my various strategies for identifying duplicates on checksum and identifying file formats. I have removed logs that identify specific file paths. The most important SQL queries that I relied on most heavily are:
* marking_duplicates.sql - here you will find the basic query strategy for locating and marking duplicates
* formats_and_counts.sql - this is the query I used to identify formats for weeding
* duplicates_on_drive.sql & duplicates_accross_media - both contain queries that I used to generate reports to guide deduplication work (this is related to the visual equivalents in /networkGraphs)

### /ingest
These scripts transfer files from physical media using the appraisal decisions from the database. Essential scripts are:
* mvFiles.py - this was the first iteration that followed an rsync of all files from a storage device and moved deaccessioned files into respective folders
* cpFiles.py - the script that I eventually landed on for selectively copying files from a given device using the appraisal decisions from the database. The script generates logs for files that return an error during the copying process. 
* exportDeaccionsReports.py - exports a report on all files that were not copied by media ID
* fixityCheck.py - short script that verifies checksum of copied file against what is in the database


## File Trees
generateHTMLTree.py is a script that takes a file tree and turns it into a navigable HTML page that can accompany records of digital media in an online collection guide. 







