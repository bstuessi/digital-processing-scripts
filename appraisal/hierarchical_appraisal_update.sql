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

WITH RECURSIVE dup_hierarchy AS (
  SELECT id, parent_directory_id, dir_path, dir_name
  FROM directories
  WHERE id = 748 --PARENT ID HERE--

  UNION ALL

  SELECT d.id, d.parent_directory_id, d.dir_path, d.dir_name
  FROM dup_hierarchy h
  JOIN directories d ON d.parent_directory_id = h.id
)

-- Now, run your SELECT statement using the same CTE
SELECT SUM(appraised_directories) as total_appraised_directories,
       SUM(appraised_files) as total_appraised_files
FROM (
  SELECT COUNT(DISTINCT d.id) as appraised_directories, COUNT(f.id) as appraised_files
  FROM dup_hierarchy h
  LEFT JOIN directories d ON h.id = d.id
  LEFT JOIN files f ON f.directory_id = h.id
  GROUP BY h.id
);




update directories d
set appraisal = 'duplicate'
from dup_hierarchy h
where d.id = h.id;

select count(h.id) as appraised_directories, count(f.id) as appraised_files
from files f
left join dup_hierarchy h
on h.id = f.directory_id;