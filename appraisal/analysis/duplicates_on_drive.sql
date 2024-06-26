-- Set the value of the drive_id variable
@set drive_id = 'D_0203'

-- Create a CTE to find duplicate files for the specified drive_id
WITH Duplicates as ( 
	select *
	from files
	where md5_hash in 
		(SELECT md5_hash
	    FROM files
	    WHERE md5_hash IN (
	        SELECT md5_hash
	        FROM files
	        WHERE digital_media_id = :drive_id  -- Use the variable here
	        GROUP BY md5_hash
	        HAVING COUNT(*) > 1)
        and digital_media_id = :drive_id)
	    --AND digital_media_id = :drive_id)  -- Use the variable here
	    )
	    
--select *
--from Duplicates
--where digital_media_id = :drive_id;

-- Use the Duplicates CTE in the rest of your query
SELECT fo."extension", string_agg(fo."name", ', ') as format_names, count(*) as total_count
FROM Duplicates d
inner join 
formats fo
on d.format_id = fo.id
where digital_media_id = :drive_id
group by fo."extension"
order by total_count desc;
    
--select digital_media_id, count(*) as shared_files
--from Duplicates
--group by digital_media_id
--order by digital_media_id asc;
--
--select count(*)
--from files 
--where digital_media_id = 'server';



