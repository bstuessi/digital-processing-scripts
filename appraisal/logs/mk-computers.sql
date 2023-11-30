select fo.name, fo.extension, count(*) as file_count
from files f
left join
formats fo
on fo.id = f.format_id
where f.digital_media_id = 'D-0200'
and f.appraisal_decision = 'scope'
and f.file_user = 'mk'
group by fo.name, fo.extension
order by file_count desc;


with DUPES as (
SELECT
    f1.id AS file_id,
    f1.directory_id,
    f1.file_path,
    f1.file_name,
    f1.md5_hash,
    f1.digital_media_id,
    f1.format_id,
	f1.file_type,
	f1.size,
    f2.id AS duplicate_file_id,
    f2.file_name as duplicate_name,
    f2.file_path as duplicate_file_path,
	f2.size as duplicate_size,
    f2.digital_media_id as duplicate_media_id
FROM
    files f1
JOIN
    files f2
ON
    f1.md5_hash = f2.md5_hash
WHERE
    f1.digital_media_id = 'D-0199'
	and f2.digital_media_id = 'D-0200'
	and f1.file_user = 'mk'
	and f2.file_user = 'mk'
    AND f1.id != f2.id
    and f1.appraisal_decision is NULL
	and f2.appraisal_decision is NULL
 )
 
 select sum(size)
 from
 (select distinct duplicate_file_id, size
 from DUPES);
 
select sum(size)
from files f
left join media m
on f.digital_media_id = m.id
where m.group_id = '1.1'
and file_user = 'mk'
and appraisal_decision is NULL
and 
(file_type != 'iTunes'
 or file_type is NULL);

select sum(size)
from files f
left join media m
on f.digital_media_id = m.id
where m.group_id = '1.1'
and file_user = 'mk'
and file_path like '%iTunes%';

update files f
set file_type = 'iTunes'
from media m
where f.digital_media_id = m.id
and m.group_id = '1.1'
and file_path like '%iTunes%';
 