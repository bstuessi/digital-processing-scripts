
 
select f.id, f.puid, f."name", f."extension", count(*) as file_count
from formats f
left join files fi on f.id = fi.format_id
where appraisal is null
group by f.id, f."name"
order by file_count desc;

--Format count for duplicate files--
with DUPES as (
SELECT
    f1.id AS file_id,
    f1.format_id,
    f1.digital_media_id,
    f1.appraisal
FROM
    files f1
JOIN
    files f2
ON
    f1.md5_hash = f2.md5_hash
WHERE
    f1.digital_media_id = 'D_0227'
    and f2.digital_media_id != 'D_0227'-- Replace 'your_media_id' with the desired media_id
    AND f1.id < f2.id
    and f1.appraisal is NULL
 )
 
 SELECT
    f.id AS format_id,
    f.puid,
    f."name",
    f."extension",
    (
        SELECT COUNT(DISTINCT d.file_id)
        FROM DUPES d
        WHERE d.format_id = f.id
    ) AS file_count
FROM formats f
ORDER BY file_count DESC;
select * from files where format_id = 161 and digital_media_id = 'D_0227';
