update files
set appraisal = 'scope'
where file_path like '%Backups.backupdb%';

update files
set appraisal = 'scope'
where file_path like '%iTunes%';

update directories
set appraisal = 'scope'
where dir_path like '%Backups.backupdb%';

update directories
set appraisal = 'scope'
where dir_path like '%iTunes%';