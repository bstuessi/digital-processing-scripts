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
--     f1.digital_media_id = 'D-0199'
-- 	and f2.digital_media_id = 'D-0200'
-- 	and f1.file_user = 'mk'
-- 	and f2.file_user = 'mk'
	f1.digital_media_id != f2.digital_media_id
	and f1.digital_media_id = 'D-0249A'
    AND f1.id != f2.id
    and f1.appraisal_decision is NULL
	and f2.appraisal_decision is NULL
 )
 
--  select sum(size)
--  from
--  (select distinct duplicate_file_id, size
--  from DUPES);

-- select (distinct file_id)
-- from DUPES d
-- join media m
-- on d.duplicate_media_id = m.id
-- where m.group_id = '1.1';


-- select count(*)
-- from files
-- where digital_media_id = 'D-0226'
-- and file_path ILIKE '%song%'
-- and id in 
-- (select distinct file_id
-- from DUPES d
-- join media m
-- on d.duplicate_media_id = m.id
-- where m.group_id = '1.1');

select count(*)
from files
where digital_media_id = 'D-0249A'
and appraisal_decision is NULL
and id in 
(select distinct file_id
from DUPES d
join media m
on d.duplicate_media_id = m.id
where m.group_id = '1.1');

select count(*)
from files
where digital_media_id = 'D-0249A'
and appraisal_decision is NULL;
 
select count(*)
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

update files f
set file_type = 'iTunes'
where digital_media_id = 'D-0227'
and appraisal_decision is NULL;

update files f
set file_type = 'iTunes'
where digital_media_id = 'D-0238'
and appraisal_decision is NULL;

update files f
set file_type = 'application'
where digital_media_id = 'D-0227'
and file_path like '%Applications%';

update files f
set file_type = 'application'
where digital_media_id = 'D-0238'
and file_path like '%Applications%';

update files
set appraisal_decision = 'scope'
where file_type = 'iTunes'
and (digital_media_id = 'D-0227'
	or digital_media_id = 'D-0238');
	
select *
from files
where digital_media_id = 'D-0204'
and file_type != 'iTunes'
and appraisal_decision is NULL;

update files
set has_duplicate = TRUE,
	appraisal_decision = 'duplicate'
where digital_media_id = 'D-0249A'
and appraisal_decision is NULL;

select count(*)
from files
where appraisal_decision = 'duplicate'
and digital_media_id = 'D-0249A';

update files
set appraisal_decision = 'scope'
where digital_media_id = 'D-0249B';

update files f
set appraisal_decision = 'scope'
from media m
where f.digital_media_id = m.id
and group_id = '1.1'
and file_type = 'iTunes';




 