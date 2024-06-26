INSERT INTO media(id, media_type, group_id, rank)
VALUES ('D-0219A', 'external hard drive', '3.2', 13),
('D-0219B', 'external hard drive', '3.2', 15),
('D-0219C', 'external hard drive', '3.2', 13);

update files
set digital_media_id = 'D-0219A'
where digital_media_id = 'D-0219'
and file_path like '%/workstation/%';

update files
set digital_media_id = 'D-0219B'
where digital_media_id = 'D-0219'
and file_path like 'Images Mac Backup/%';

update files
set digital_media_id = 'D-0219C'
where digital_media_id = 'D-0219'
and file_path like 'MC Old iMac Backup/%';

update directories
set digital_media_id = 'D-0219A'
where digital_media_id = 'D-0219'
and dir_path like '%/workstation/%';

update directories
set digital_media_id = 'D-0219B'
where digital_media_id = 'D-0219'
and dir_path like 'Images Mac Backup/%';

update directories
set digital_media_id = 'D-0219C'
where digital_media_id = 'D-0219'
and dir_path like 'MC Old iMac Backup/%';

INSERT INTO media(id, media_type, group_id, rank)
VALUES ('D-0232A', 'external hard drive', '2.2', 15),
('D-0232B', 'external hard drive', '3.2', 13),
('D-0232C', 'external hard drive', '3.2', 11),
('D-0232D', 'external hard drive', '3.2', 13);

update files
set digital_media_id = 'D-0232A'
where digital_media_id = 'D-0232'
and file_path like '%/ahrum desktop /%';

update files
set digital_media_id = 'D-0232B'
where digital_media_id = 'D-0232'
and file_path like '%/mc iMac/%';

update files
set digital_media_id = 'D-0232C'
where digital_media_id = 'D-0232'
and file_path like '%/QB Back/%';

update files
set digital_media_id = 'D-0232D'
where digital_media_id = 'D-0232'
and file_path like '%/Workstation/%';

update directories
set digital_media_id = 'D-0232A'
where digital_media_id = 'D-0232'
and dir_path like '%/ahrum desktop /%';

update directories
set digital_media_id = 'D-0232B'
where digital_media_id = 'D-0232'
and dir_path like '%/mc iMac/%';

update directories
set digital_media_id = 'D-0232C'
where digital_media_id = 'D-0232'
and dir_path like '%/QB Back/%';

update directories
set digital_media_id = 'D-0232D'
where digital_media_id = 'D-0232'
and dir_path like '%/Workstation/%';

INSERT INTO media(id, media_type, group_id, rank)
VALUES ('D-0249A', 'external hard drive', '1.2', 18),
('D-0249B', 'external hard drive', '1.2', 18);

update files
set digital_media_id = 'D-0249A'
where digital_media_id = 'D-0249'
and file_path like '%5150 Backup/%';

update files
set digital_media_id = 'D-0249B'
where digital_media_id = 'D-0249'
and file_path like '%Kelley Mac Mini/%';

update directories
set digital_media_id = 'D-0249A'
where digital_media_id = 'D-0249'
and dir_path like '%5150 Backup/%';

update directories
set digital_media_id = 'D-0249B'
where digital_media_id = 'D-0249'
and dir_path like '%Kelley Mac Mini/%';

INSERT INTO media(id, media_type, group_id, rank)
VALUES ('D-0251A', 'external hard drive', '3.2', 13),
('D-0251B', 'external hard drive', '2.2', 15),
('D-0251C', 'external hard drive', '2.2', 15),
('D-0251D', 'external hard drive', '2.2', 15),
('D-0251E', 'external hard drive', '2.2', 15);

update files
set digital_media_id = 'D-0251A'
where digital_media_id = 'D-0251'
and file_path like '%Power Tower/%';

update files
set digital_media_id = 'D-0251B'
where digital_media_id = 'D-0251'
and file_path like '%SuperVideo/%';

update files
set digital_media_id = 'D-0251C'
where digital_media_id = 'D-0251'
and file_path like '%Shop Power Mac G5/%';

update files
set digital_media_id = 'D-0251D'
where digital_media_id = 'D-0251'
and file_path like '%Shop iMac G5/%';

update files
set digital_media_id = 'D-0251E'
where digital_media_id = 'D-0251'
and file_path like '%Kitchen Video/%';

update directories
set digital_media_id = 'D-0251A'
where digital_media_id = 'D-0251'
and dir_path like '%Power Tower/%';

update directories
set digital_media_id = 'D-0251B'
where digital_media_id = 'D-0251'
and dir_path like '%SuperVideo/%';

update directories
set digital_media_id = 'D-0251C'
where digital_media_id = 'D-0251'
and dir_path like '%Shop Power Mac G5/%';

update directories
set digital_media_id = 'D-0251D'
where digital_media_id = 'D-0251'
and dir_path like '%Shop iMac G5/%';

update directories
set digital_media_id = 'D-0251E'
where digital_media_id = 'D-0251'
and dir_path like '%Kitchen Video/%';

select id from
(select m.id, count(*) as file_count
from media as m
left join files as f
on m.id = f.digital_media_id
group by m.id
 order by m.id)
where file_count != 1;

INSERT INTO media(id, media_type, group_id, rank)
VALUES ('D-0258A', 'external hard drive', '3.2', 17),
('D-0258B', 'external hard drive', '2.2', 19),
('D-0258C', 'external hard drive', '3.2', 13),
('D-0258D', 'external hard drive', '2.2', 15);

update files
set digital_media_id = 'D-0258A'
where digital_media_id = 'server';

update directories
set digital_media_id = 'D-0258A'
where digital_media_id = 'server';

update files
set digital_media_id = 'D-0258B'
where digital_media_id = 'server'
and file_path like '%/Ahrum Drive 2/%';

update files
set digital_media_id = 'D-0258C'
where digital_media_id = 'server'
and file_path like '%/Email Backups migrated by Luckae/%';

update files
set digital_media_id = 'D-0258D'
where digital_media_id = 'server'
and dir_path like '%/Shop - New Storage/%';

update directories
set digital_media_id = 'D-0258B'
where digital_media_id = 'server'
and dir_path like '%/Ahrum Drive 2/%';

update directories
set digital_media_id = 'D-0258C'
where digital_media_id = 'server'
and dir_path like '%/Email Backups migrated by Luckae/%';

update directories
set digital_media_id = 'D-0258D'
where digital_media_id = 'server'
and dir_path like '%/Shop - New Storage/%';
