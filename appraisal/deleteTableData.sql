delete from files;
delete from formats;
delete from directories;
alter sequence files_id_seq restart with 1;
alter sequence directories_id_seq restart with 1;
alter sequence formats_id_seq restart with 1;