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
	f1.file_user,
	f1.size,
	f2.id AS duplicate_file_id,
	f2.file_name as duplicate_name,
	f2.file_path as duplicate_file_path,
	f2.file_user as duplicate_file_user,
	f2.digital_media_id as duplicate_media_id
FROM
	files f1
JOIN
	files f2
ON
	f1.md5_hash = f2.md5_hash
WHERE
	f1.digital_media_id = f2.digital_media_id
	AND f1.id != f2.id
	--change this line based on media you are marking duplicates for
-- 	and f1.digital_media_id = 'D-0258A'
-- 	and f1.file_user = 'server'
-- 	and f2.file_user = 'server'
	and f1.appraisal_decision is NULL
	and f2.appraisal_decision is NULL
 )


select *
from DUPES
where digital_media_id = 'D-0223'
limit 1000;
and file_path like '%/Library/Favorites/%';

-- select *
-- from files
-- where digital_media_id = 'D-0258A'
-- and file_path like '%/NEW TEXT ARCHIVE/%'
-- AND id not in
-- (select distinct file_id from DUPES);

select d.digital_media_id, 
	m.group_id,
	m.rank,
	d.file_user,
	d.unique_duplicate_count,
	f.total_file_count,
	(d.unique_duplicate_count/f.total_file_count::float)*100 as percentage_duplication
from (
	select digital_media_id, file_user,
	count(distinct file_id) as unique_duplicate_count
	from DUPES
	group by digital_media_id, file_user) as d
join 
	(select digital_media_id,
	count(*) as total_file_count
	from files
	group by digital_media_id) as f
	on d.digital_media_id = f.digital_media_id
join
	media as m
	on m.id = d.digital_media_id;
	
	
select d.digital_media_id, 
	m1.group_id, 
	m1.rank,
	d.file_user,
	d.duplicate_media_id,
	m2.group_id,
	m2.rank,
	d.duplicate_file_user,
	d.unique_duplicate_count,
	f.total_file_count,
	(d.unique_duplicate_count/f.total_file_count::float)*100 as percentage_duplication
from (
	select digital_media_id, file_user, duplicate_media_id, duplicate_file_user,
	count(distinct file_id) as unique_duplicate_count
	from DUPES
	group by digital_media_id, file_user, duplicate_media_id, duplicate_file_user) as d
join 
	(select digital_media_id,
	count(*) as total_file_count
	from files
	group by digital_media_id) as f
	on d.digital_media_id = f.digital_media_id
	
join
	media as m1
	on m1.id = d.digital_media_id
join
	media as m2
	on m2.id = d.duplicate_media_id;

-- select concat(digital_media_id, ' -> ', duplicate_media_id) as duplicate_media_relationship,
-- count(*) as total_duplicate_file_count
-- from DUPES
-- group by duplicate_media_relationship
-- order by total_duplicate_file_count desc;

-- select *
-- from files f
-- where f.id not in
-- (select file_id
-- from DUPES)
-- and file_path like '%RECYCLER%';
 
-- select fo.id, fo.name, fo."extension", count(distinct file_id) as unique_file_count 
-- from DUPES d
-- left join formats fo
-- on d.format_id = fo.id
-- group by fo.id
-- order by unique_file_count desc;

--update files as f
--set appraisal = 'duplicate'
--from DUPES as d
--where f.id = d.file_id;
 
-- select duplicate_media_id, count(distinct duplicate_file_id)
-- from DUPES
-- group by duplicate_media_id;

select d.dir_path, count(*) as file_count
from DUPES f
left join directories d
on f.directory_id = d.id
where f.digital_media_id = 'D-0199'
group by dir_path
order by file_count desc;

select concat(digital_media_id, ' -> ', duplicate_media_id) as duplicate_media_relationship,
count(*) as total_duplicate_file_count, 
count(distinct file_id) as unique_duplicate_files,
digital_media_id,
m1.group_id,
m1.media_type,
m1.rank,
duplicate_media_id,
m2.group_id as duplicate_group_id,
m2.media_type as duplicate_media_type,
m2.rank as duplicate_rank
from DUPES
join media m1
on digital_media_id = m1.id
join media m2
on duplicate_media_id = m2.id
where digital_media_id < duplicate_media_id
group by duplicate_media_relationship, 
digital_media_id,
m1.group_id,
m1.media_type,
m1.rank,
duplicate_media_id,
duplicate_group_id,
duplicate_media_type,
duplicate_rank
order by total_duplicate_file_count desc;

select digital_media_id, count(*) as total_file_count
from files
group by digital_media_id
order by digital_media_id asc;


select dir_path, count(*) as file_count
from files f
left join directories d
on f.directory_id = d.id
where f.format_id = 42
and f.digital_media_id = 'D-0219'
and f.appraisal_decision is null
group by dir_path
order by file_count desc;