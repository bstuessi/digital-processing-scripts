WITH RECURSIVE dup_hierarchy AS (
  SELECT id, parent_directory_id, dir_path, dir_name
  FROM directories
  WHERE id = 25995 --PARENT ID HERE--

  UNION ALL

  SELECT d.id, d.parent_directory_id, d.dir_path, d.dir_name
  FROM dup_hierarchy h
  JOIN directories d ON d.parent_directory_id = h.id
)

-- First, update the directories
UPDATE directories AS d
SET appraisal = 'scope' --APPRAISAL TERM HERE--
FROM dup_hierarchy h
WHERE d.id = h.id;


update files as f
set appraisal = 'ignore'
from formats as fo 
where 
f.format_id = fo.id
and fo.name = 'AppleDouble Resource Fork'
and f.digital_media_id = 'D_0227';

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
    f2.digital_media_id as duplicate_media_id
FROM
    files f1
JOIN
    files f2
ON
    f1.md5_hash = f2.md5_hash
WHERE
    f1.digital_media_id = 'D_0227'
    and f2.digital_media_id != 'D_0227'-- Replace 'your_media_id' with the desired media_id
    AND f1.id != f2.id
    and f1.appraisal is null
   
 )
-- 
--select count(distinct file_id)
--from DUPES;
select duplicate_media_id, count(distinct duplicate_file_id) as duplicate_files
from DUPES 
group by duplicate_media_id;
 
select fo.id, fo.name, fo."extension", count(distinct file_id) as unique_file_count 
from DUPES d
left join formats fo
on d.format_id = fo.id
group by fo.id
order by unique_file_count desc;