-- select count(*)
-- from files 
-- where file_path like '%Applications%'
-- or
-- file_path like '%.app%';

-- select count(*)
-- from files
-- where file_path like '%/Mail/%';

-- select count(*)
-- from files
-- where file_path like '%/Library/%';

-- update files
-- set file_type = 'system'
-- where file_path like '%/Library/%';

-- update files
-- set file_type = 'mail'
-- where file_path like '%/Mail/%';

-- update files
-- set file_type = 'system'
-- where format_id = 2;

-- update files f
-- set file_type = 'data'
-- from formats fo
-- where f.format_id = fo.id
-- and fo.name = 'AppleDouble Resource Fork'
-- and file_type is NULL;

-- update files f
-- set file_type = 'metadata'
-- where format_id = 583;

-- update files f
-- set file_type = 'data'
-- from formats fo
-- where f.format_id = fo.id
-- and file_type IS NULL
-- and puid = 'Unidentified'
-- and extension != 'Unidentified';

-- update files f
-- set file_type = 'data'
-- from formats fo
-- where f.format_id = fo.id
-- and file_type IS NULL
-- and fo.extension = 'plist';

-- update files f
-- set file_type = 'data'
-- from formats fo
-- where f.format_id = fo.id
-- and format_id = 1
-- and 
-- (file_path like '%Data%' 
--  or file_path like '%data%'
--  or file_path like '%bin%')
-- and file_type IS NULL;

-- update files f
-- set appraisal_decision = NULL
-- where appraisal_decision = 'scope';

-- update files f
-- set appraisal_decision = 'scope'
-- where 
-- (file_type = 'application'
-- or file_type = 'data'
-- or file_type = 'metadata'
-- or file_type = 'system');

-- update files
-- set appraisal_decision = 'scope'
-- where file_type = 'system';

-- update files
-- set appraisal_decision = 'scope'
-- where file_type = 'application';

-- update files
-- set appraisal_decision = 'scope'
-- where file_type = 'data';

-- update files
-- set appraisal_decision = 'scope'
-- where file_type = 'metadata';

-- update files
-- set file_type = 'data'
-- where format_id = 1
-- and file_type IS NULL;

-- update files f
-- set file_type = 'application'
-- from
-- formats fo
-- where f.format_id = fo.id
-- and file_type is NULL
-- AND
-- (fo.name = 'Cascading Style Sheet'
-- or fo.name = 'Perl Script'
-- or fo.name = 'Apple iWork Document'
-- or fo.name = 'JavaScript file'
-- or fo.name = 'Python Source Code File'
-- or fo.name = 'Hypertext Markup Language');

-- update files f
-- set file_type = 'data'
-- from
-- formats fo
-- where f.format_id = fo.id
-- and file_type is NULL
-- AND
-- (fo.name = 'Thumbs DB file'
-- or fo.name = 'Log file'
-- or fo.name = 'Binary file');

-- update files f
-- set file_type = 'application'
-- where file_path like '%/Applications/%';

-- update files f
-- set file_type = 'data'
-- from
-- formats fo
-- where f.format_id = fo.id
-- and file_type is NULL
-- AND
-- (fo.name = 'DS_store file (MAC)'
-- or fo.name = 'Data Files'
-- or fo.name = 'Extensible Stylesheet Language');

-- update files f
-- set file_type = 'data'
-- where 
-- (format_id = 2
-- or format_id = 150
-- or format_id = 164);

-- select fo.name, fo.extension, count(*) as file_count
-- from files f
-- left join formats fo
-- on f.format_id = fo.id
-- where file_path like '%.app%'
-- group by fo.name, fo.extension
-- order by file_count desc;

-- select count(*)
-- from files f
-- join formats fo
-- on f.format_id = fo.id
-- where appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'Exchangeable Image File Format'
-- and fo.extension = 'jpg';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'Audio Interchange File Format'
-- and fo.extension = 'aiff';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'Canon RAW'
-- and fo.extension = 'cr2';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'Comma Separated Values'
-- and fo.extension = 'csv';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'Microsoft Word Document'
-- and fo.extension = 'doc';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'Microsoft Word for Windows'
-- and fo.extension = 'docx';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like '%JPEG%'
-- and fo.extension = 'jpeg';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like '%JPEG%'
-- and fo.extension = 'jpg';	

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'Exchangeable Image File Format%'
-- and fo.extension = 'jpg';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'MPEG%'
-- and 
-- (fo.extension = 'm4a'
--  or fo.extension = 'mp3'
--  or fo.extension = 'mp4');
 
-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'Acrobat PDF%'
-- and fo.extension = 'pdf';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name = 'JPEG File Interchange Format'
-- and fo.extension = 'png';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like '%Image File Format%'
-- and 
-- (fo.extension = 'tif'
--  or fo.extension = 'tiff');
 
-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'Waveform Audio%'
-- and fo.extension = 'wav';

-- update files f
-- set appraisal_decision = NULL
-- from formats fo
-- where f.format_id = fo.id
-- and appraisal_decision = 'scope'
-- and file_type != 'iTunes'
-- and fo.name like 'Microsoft Excel%'
-- and 
-- (fo.extension = 'xls'
--  or fo.extension = 'xlsx');
 
 
select count(*)
from files
where digital_media_id = 'D-0204'
and file_type = 'iTunes';

update files
set appraisal_decision = 'scope'
where digital_media_id = 'D-0204'
and appraisal_decision is NULL;

select count(*)
from files
where digital_media_id = 'D-0204'
and file_path like '%.app%';

update files
set appraisal_decision = 'scope',
file_type = 'music'
where digital_media_id = 'D-0204'
and file_path like '%/LimeWire/%';

update files
set appraisal_decision = 'scope',
file_type = 'application'
where digital_media_id = 'D-0204'
and file_path like '%.app%';


update files
set appraisal_decision = 'scope'
where digital_media_id = 'D-0219C'
and file_user is null;

update files
set appraisal_decision = 'scope'
where digital_media_id = 'D-0223'
and file_user = 'scope';

update files 
set appraisal_decision = 'scope'
where digital_media_id = 'D-0250';

update directories
set appraisal_decision = 'scope'
where digital_media_id = 'D-0250';

update files
set file_type = 'photo',
appraisal_decision = 'scope'
where digital_media_id = 'D-0212'
and appraisal_decision is null
and id != 1061179;

update directories
set appraisal_decision = 'scope'
where digital_media_id = 'D-0212'
and appraisal_decision is null
and id != 129394;

update files
set appraisal_decision = 'scope'
where file_user = 'bk';

update directories
set appraisal_decision = 'scope'
where dir_user = 'bk';

update files 
set appraisal_decision = 'scope'
where digital_media_id = 'D-0219C'
and file_user = 'av';

update directories 
set appraisal_decision = 'scope'
where digital_media_id = 'D-0219C'
and dir_user = 'av';


