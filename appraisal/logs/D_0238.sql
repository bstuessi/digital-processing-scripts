select * 
from directories
where 
digital_media_id = 'D_0238'
and 
dir_name = 'Applications';

WITH RECURSIVE dir_hierarchy AS (
  SELECT id, parent_directory_id, dir_path, dir_name
  FROM directories
  WHERE id = 206032 --PARENT ID HERE--

  UNION ALL

  SELECT d.id, d.parent_directory_id, d.dir_path, d.dir_name
  FROM dir_hierarchy h
  JOIN directories d ON d.parent_directory_id = h.id
)

select count(*)
from dir_hierarchy;

select count(*)
from directories
where 
digital_media_id = 'D_0238'
and 
dir_path like '%Applications%';

select count(*)
from files 
where
digital_media_id = 'D_0238'
and 
file_path like '%Applications%';

update files 
set appraisal='scope'
where 
digital_media_id = 'D_0238'
and 
file_path like '%Applications%';

-- First, update the directories
UPDATE directories AS d
SET appraisal = 'scope' --APPRAISAL TERM HERE--
FROM dup_hierarchy h
WHERE d.id = h.id;


update files 
set appraisal = 'ignore'
where 
digital_media_id = 'D_0238'
and 
format_id = 281
and
file_path like '%PubSub%';


select count(*)
from files 
where 
digital_media_id = 'D_0238'
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
    f1.digital_media_id = 'D_0238'
    and f2.digital_media_id != 'D_0238'-- Replace 'your_media_id' with the desired media_id
    AND f1.id != f2.id
	and m.group_id = '1.1'
    and f1.appraisal is null
   
 )
 
--select count(distinct file_id)
--from DUPES;
 
--select duplicate_media_id, count(distinct duplicate_file_id) as duplicate_files
--from DUPES _
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
