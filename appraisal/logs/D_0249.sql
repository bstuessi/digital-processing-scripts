select *
from files
where 
digital_media_id = 'D_0249'
and 
format_id = 1392;

update files 
set appraisal = 'ignore'
where 
digital_media_id = 'D_0249'
and 
format_id = 1392;

select count(*)
from files 
where 
digital_media_id = 'D_0249'
and 
appraisal is null;

--duplication reports--
with DUPES as (
SELECT
    f1.id AS file_id,
    f1.directory_id,
    f1.file_path,
    f1.file_name,
    f1.md5_hash,
    f1.digital_media_id,
    f1.format_id,
    f2.id AS duplicate_file_id,
    f2.file_name as duplicate_name,
    f2.file_path as duplicate_file_path,
    f2.digital_media_id as duplicate_media_id,
    m.group_id as duplicate_group
FROM
    files f1
JOIN
    files f2
ON
    f1.md5_hash = f2.md5_hash
join 
	media m
on 
	m.id = f2.digital_media_id
WHERE
    f1.digital_media_id = 'D_0249'
    and f2.digital_media_id != 'D_0249'-- Replace 'your_media_id' with the desired media_id
    AND f1.id != f2.id
	and m.group_id = '1.1'
    and f1.appraisal is null
   
 )
 
--select count(distinct file_id)
--from DUPES;
 
--select duplicate_media_id, count(distinct duplicate_file_id) as duplicate_files
--from DUPES 
--group by duplicate_media_id;
 
--select fo.id, fo.name, fo."extension", count(distinct file_id) as unique_file_count 
--from DUPES d
--left join formats fo
--on d.format_id = fo.id
--group by fo.id
--order by unique_file_count desc;

 update files f
 set appraisal = 'duplicate'
 from DUPES d
 where f.id = d.file_id;

select * 
from files
where 
digital_media_id = 'D_0249'
and 
format_id = 531;
