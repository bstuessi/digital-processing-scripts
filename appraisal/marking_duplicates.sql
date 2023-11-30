--first get files to mark as duplicate from dupes
--set has_duplicate = TRUE for all files
--set appraisal_decision = 'duplicate'

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
    f2.digital_media_id as duplicate_media_id
FROM
    files f1
JOIN
    files f2
ON
    f1.md5_hash = f2.md5_hash
WHERE
    f1.digital_media_id != f2.digital_media_id
    AND f1.id != f2.id
	and f1.digital_media_id = 'D-0251C'
	and f1.file_user = 'shop'
	and f2.file_user = 'shop'
    and f1.appraisal_decision is NULL
	and f2.appraisal_decision is NULL
 )
 
 update files f
 set appraisal_decision = 'duplicate'
 from DUPES as d
 where f.id = d.file_id
 and f.digital_media_id = 'D-0251C';
 
 select fo.name, fo.extension, count(*) as file_count
 from files f
 join formats fo
 on f.format_id = fo.id
 where digital_media_id = 'D-0251C'
 and appraisal_decision is null
 group by fo.name, fo.extension;
 
 

