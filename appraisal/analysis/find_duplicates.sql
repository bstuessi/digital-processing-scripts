/* find duplicates */

--FIND DUPLICATE DIRECTORIES ON SIZE
SELECT * 
FROM directories 
WHERE "size" IN 
(SELECT "size" FROM directories
GROUP BY "size"
HAVING COUNT(*) > 1) 
and digital_media_id = 'D_0226'
order by "size" ;

select *
from files
where md5_hash in (
--FIND DUPLICATE FILES ON CHECKSUM
SELECT md5_hash 
FROM files
WHERE md5_hash IN 
(SELECT md5_hash 
FROM files
--ONLY DUPLICATES THAT MATCH FILES ON A SPECIFC DRIVE
GROUP BY md5_hash 
HAVING COUNT(*) > 1)
and digital_media_id = 'D_0226');

--FIND DUPLICATE FILES ON CHECKSUM
select sum(size) as total_size_of_duplicates
FROM files
WHERE md5_hash IN 
(SELECT md5_hash 
FROM files
--ONLY DUPLICATES THAT MATCH FILES ON A SPECIFC DRIVE
GROUP BY md5_hash 
HAVING COUNT(*) > 1)
and digital_media_id = 'D_0203'
and appraisal is null;
order by md5_hash;

select *
from files
where md5_hash not in 
(select md5_hash 
from files f
join media m
on f.digital_media_id = m.id
where m.group_id = '1.1')
and digital_media_id = 'D_0230';

select count(*)
from files
where md5_hash not in
(select md5_hash 
from files
where 
digital_media_id != 'D_0226')
and digital_media_id = 'D_0226'
and format_id = 184;

select * 
from directories
where 'size' in 
(select 'size'
from directories 
where digital_media_id != 'D_0226')
and digital_media_id = 'D_0226';

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
    and f2.digital_media_id = 'D_0227'-- Replace 'your_media_id' with the desired media_id
    AND f1.id != f2.id
    and f1.appraisal is NULL
 )
 
select fo.id, fo.name, fo."extension", count(distinct file_id) as unique_file_count 
from DUPES d
left join formats fo
on d.format_id = fo.id
group by fo.id
order by unique_file_count desc;

--update files as f
--set appraisal = 'duplicate'
--from DUPES as d
--where f.id = d.file_id;
 
select duplicate_media_id, count(duplicate_file_id)
from DUPES
group by duplicate_media_id;

select count(*)
from files 
where digital_media_id = 'D_0227';



