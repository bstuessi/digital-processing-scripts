select fo. id, fo.puid, fo."name"
from formats fo
left join 
files fi
on fi.format_id = fo.id
where fi.appraisal is null
group by fo.id, fo.puid, fo."name";


select count(*)
from files
where appraisal is null;

update files
set appraisal = 'duplicate'
where id in 
(--FIND DUPLICATE FILES ON CHECKSUM
SELECT  id 
FROM files 
WHERE md5_hash IN 
(SELECT md5_hash 
FROM files 
--ONLY DUPLICATES THAT MATCH FILES ON A SPECIFC DRIVE
GROUP BY md5_hash 
HAVING COUNT(*) > 1) 
and appraisal is null)
and file_path like '%RECYCLER%';

select count(*) from files where appraisal = 'duplicate' and file_path like '%All Users%';

select *
from files
where md5_hash in 
(--FIND DUPLICATE FILES ON CHECKSUM
SELECT  md5_hash  
FROM files 
WHERE md5_hash IN 
(SELECT md5_hash 
FROM files 
--ONLY DUPLICATES THAT MATCH FILES ON A SPECIFC DRIVE
GROUP BY md5_hash 
HAVING COUNT(*) > 1) 
and digital_media_id = 'D_0199');
and digital_media_id = 'D_0203';
and appraisal is null;


UPDATE files AS fi
SET appraisal = 'ignore'
FROM formats AS fo
WHERE fi.format_id = fo.id
AND fo.extension = 'db';

select * from files;

update files 
set appraisal = null 
where 
digital_media_id = 'D_0199'
and 
appraisal = 'duplicate'
and
file_path like '%All Users%';

update files 
set appraisal = 'duplicate'
where md5_hash in 
(--FIND DUPLICATE FILES ON CHECKSUM
SELECT  md5_hash  
FROM files 
WHERE md5_hash IN 
(SELECT md5_hash 
FROM files 
--ONLY DUPLICATES THAT MATCH FILES ON A SPECIFC DRIVE
GROUP BY md5_hash 
HAVING COUNT(*) > 1) 
and file_path like '%Mike Kelley%')
and file_path like '%All Users%'
and digital_media_id = 'D_0199';
and appraisal is null;

select * from formats;


