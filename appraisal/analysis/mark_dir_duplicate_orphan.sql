update directories
set has_duplicates = TRUE
from
	(select distinct directory_id
	 from files
	 where file_user = 'mc'
	 and appraisal_decision = 'duplicate'
	) as dup
where dup.directory_id = directories.id;


update directories
set has_orphans = TRUE
from
	(select distinct directory_id
	from files f
	right join directories d
	on f.directory_id = d.id
	where d.has_duplicates = TRUE
	 and file_user = 'mc'
	and f.appraisal_decision is NULL) as orph
where orph.directory_id = directories.id;

with DUPE_DIRS as (
SELECT
    d1.id,
	d1.dir_name,
	d1.dir_path, 
	d1.mtime,
	d1.has_duplicates,
	d1.has_orphans,
	d1.digital_media_id,
	d2.id as duplicate_id,
	d2.dir_name as duplicate_name,
	d2.digital_media_id as duplicate_media_id
FROM
    directories d1
JOIN
    directories d2
ON
    d1.size = d2.size
WHERE
    d1.digital_media_id != d2.digital_media_id
    AND d1.id != d2.id
	and d1.dir_name = d2.dir_name
	and d1.dir_user = 'shop'
	and d2.dir_user = 'shop'
    and d1.appraisal_decision is NULL
	and d2.appraisal_decision is NULL
 )
 
 
 select *
 from DUPE_DIRS
 where has_orphans = TRUE;
 
 
 select sum(size)
 from files
 where file_user = 'mc'
 and appraisal_decision = 'duplicate';
 and appraisal_decision is null;
 
 
 select count(*)
 from
 (select distinct directory_id
 from files
 where (file_user = 'studio'
	or file_user = 'admin'
	or file_user = 'unk'
	or file_user = 'all')) as d1
join directories d2 on d1.directory_id = d2.id
where d2.has_orphans = TRUE;