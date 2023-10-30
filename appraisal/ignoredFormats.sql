update files
set appraisal = 'ignore'
where format_id in 
(select f1.id
from formats f1
inner join 
ignored_formats f2 
on f1.puid = f2.puid;


select f1.id, f1.puid, f1."name" 
from formats f1
inner join 
ignored_formats f2 
on f1.puid = f2.puid;