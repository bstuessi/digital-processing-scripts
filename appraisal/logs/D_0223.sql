select count(*)
from files 
where 
file_path like '%/Library/%'
and 
file_path not like '%Mail%';

update files 
set appraisal = 'scope'
where 
file_path like '%/Library/%'
and 
file_path not like '%Mail%';

select * 
from directories
where 
digital_media_id = 'D_0223'
and 
dir_name = 'Applications';

update files 
set appraisal='scope'
where 
digital_media_id = 'D_0223'
and 
file_path like '%Applications%'
and file_path not like '%Mail%';

--duplication reports--
with DUPE_DIRS as (
SELECT
   d1.id, 
   d1.dir_path, 
   d1.dir_name,
   d1.mtime,
   d1.size,
   d2.id as duplicate_id,
   d2.dir_path as duplicate_path,
   d2.dir_name as duplicate_name,
   d2.mtime as duplicate_mtime,
   d2.digital_media_id as duplicate_media_id
FROM
    directories d1
JOIN
    directories d2
ON
   d1.size = d2.size
join 
	media m
on 
	m.id = d2.digital_media_id 
WHERE
    d1.digital_media_id = 'D_0223'
    and d2.digital_media_id = 'D_0223'-- Replace 'your_media_id' with the desired media_id
    AND d1.id != d2.id
--	and m.group_id = '1.1'
    and d1.appraisal is null
   
 )
 

--select count(id)
--from DUPE_DIRS;
--where 
--dir_name = duplicate_name
--and
--mtime > duplicate_mtime;

update directories as d
set appraisal = 'duplicate'
from 
(select distinct id
from DUPE_DIRS
where 
dir_name = duplicate_name
and
mtime > duplicate_mtime) as dd
where 
d.id = dd.id;

select count(*)
from files 
where 
appraisal = 'duplicate'
and
digital_media_id = 'D_0223';


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
    f1.digital_media_id = 'D_0216'
    and f2.digital_media_id != 'D_0216'-- Replace 'your_media_id' with the desired media_id
    AND f1.id != f2.id
--	and m.group_id = '1.1'
    and f1.appraisal is null
   
 )
 
--select count(distinct file_id)
--from DUPES;
 
select duplicate_media_id, count(distinct file_id) as duplicate_files
from DUPES _
group by duplicate_media_id;
 
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
