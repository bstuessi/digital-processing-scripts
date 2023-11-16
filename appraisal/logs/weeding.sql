select count(*)
from files 
where file_path like '%Applications%'
or
file_path like '%.app%';

select count(*)
from files
where file_path like '%/Mail/%';

select count(*)
from files
where file_path like '%/Library/%';

update files
set file_type = 'system'
where file_path like '%/Library/%';

update files
set file_type = 'mail'
where file_path like '%/Mail/%';

update files
set file_type = 'system'
where format_id = 2;

update files f
set file_type = 'data'
from formats fo
where f.format_id = fo.id
and fo.name = 'AppleDouble Resource Fork'
and file_type is NULL;

update files f
set file_type = 'metadata'
where format_id = 583;

update files f
set file_type = 'data'
from formats fo
where f.format_id = fo.id
and file_type IS NULL
and puid = 'Unidentified'
and extension != 'Unidentified';

update files f
set file_type = 'data'
from formats fo
where f.format_id = fo.id
and file_type IS NULL
and fo.extension = 'plist';

update files f
set file_type = 'data'
from formats fo
where f.format_id = fo.id
and format_id = 1
and 
(file_path like '%Data%' 
 or file_path like '%data%'
 or file_path like '%bin%')
and file_type IS NULL;

update files f
set appraisal_decision = NULL
where appraisal_decision = 'scope';

update files f
set appraisal_decision = 'scope'
where 
(file_type = 'application'
or file_type = 'data'
or file_type = 'metadata'
or file_type = 'system');

update files
set appraisal_decision = 'scope'
where file_type = 'system';

update files
set appraisal_decision = 'scope'
where file_type = 'application';

update files
set appraisal_decision = 'scope'
where file_type = 'data';

update files
set appraisal_decision = 'scope'
where file_type = 'metadata';

update files
set file_type = 'data'
where format_id = 1
and file_type IS NULL;

update files f
set file_type = 'application'
from
formats fo
where f.format_id = fo.id
and file_type is NULL
AND
(fo.name = 'Cascading Style Sheet'
or fo.name = 'Perl Script'
or fo.name = 'Apple iWork Document'
or fo.name = 'JavaScript file'
or fo.name = 'Python Source Code File'
or fo.name = 'Hypertext Markup Language');

update files f
set file_type = 'data'
from
formats fo
where f.format_id = fo.id
and file_type is NULL
AND
(fo.name = 'Thumbs DB file'
or fo.name = 'Log file'
or fo.name = 'Binary file');

update files f
set file_type = 'application'
where file_path like '%/Applications/%';

update files f
set file_type = 'data'
from
formats fo
where f.format_id = fo.id
and file_type is NULL
AND
(fo.name = 'DS_store file (MAC)'
or fo.name = 'Data Files'
or fo.name = 'Extensible Stylesheet Language');

update files f
set file_type = 'data'
where 
(format_id = 2
or format_id = 150
or format_id = 164);

select fo.name, fo.extension, count(*) as file_count
from files f
left join formats fo
on f.format_id = fo.id
where file_path like '%.app%'
group by fo.name, fo.extension
order by file_count desc;
	