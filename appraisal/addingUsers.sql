select count(*)
from files
where digital_media_id = 'D-0204'
and file_path like '%/Shared/%';

update files
set file_user = 'mk'
where digital_media_id = 'D-0199'
and file_path like '%Documents and Settings/Mike Kelley/%';

update files
set file_user = 'll'
where digital_media_id = 'D-0199'
and file_path like '%Documents and Settings/LISA/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0199'
and file_path like '%Documents and Settings/MC/%';

update files
set file_user = 'all'
where digital_media_id = 'D-0199'
and file_path like '%Documents and Settings/All Users/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0199'
and dir_path like '%Documents and Settings/Mike Kelley/%';

update directories
set dir_user = 'll'
where digital_media_id = 'D-0199'
and dir_path like '%Documents and Settings/LISA/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0199'
and dir_path like '%Documents and Settings/MC/%';

update directories
set dir_user = 'all'
where digital_media_id = 'D-0199'
and dir_path like '%Documents and Settings/All Users/%';

update files
set file_type = 'system',
	appraisal_decision = 'scope'
where digital_media_id = 'D-0199'
and file_path like '%Documents and Settings/Default User/%';

update files
set file_user = 'mk'
where digital_media_id = 'D-0200'
and file_path like '%Documents and Settings/Kelley 5150/%';

update files
set file_user = 'll'
where digital_media_id = 'D-0200'
and file_path like '%Documents and Settings/LISA/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0200'
and file_path like '%Documents and Settings/MC/%';

update files
set file_user = 'all'
where digital_media_id = 'D-0200'
and file_path like '%Documents and Settings/All Users/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0200'
and dir_path like '%Documents and Settings/Kelley 5150/%';

update directories
set dir_user = 'll'
where digital_media_id = 'D-0200'
and dir_path like '%Documents and Settings/LISA/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0200'
and dir_path like '%Documents and Settings/MC/%';

update directories
set dir_user = 'all'
where digital_media_id = 'D-0200'
and dir_path like '%Documents and Settings/All Users/%';

update files
set file_type = 'system',
	appraisal_decision = 'scope'
where digital_media_id = 'D-0200'
and 
(file_path like '%Documents and Settings/Default User/%'
or file_path like '%Documents and Settings/LocalService/%'
or file_path like '%Documents and Settings/NetworkService/%'
or file_path like '%Documents and Settings/Owner/%');

update files
set file_user = 'mk'
where digital_media_id = 'D-0203'
and file_path like '%Documents and Settings/Mike Kelley/%';

update files
set file_user = 'all'
where digital_media_id = 'D-0203'
and file_path like '%Documents and Settings/All Users/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0203'
and file_path like '%Documents and Settings/All Users/Documents/MC/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0203'
and dir_path like '%Documents and Settings/Mike Kelley/%';

update directories
set dir_user = 'all'
where digital_media_id = 'D-0203'
and dir_path like '%Documents and Settings/All Users/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0203'
and dir_path like '%Documents and Settings/All Users/Documents/MC/%';

update files
set file_user = 'mk'
where digital_media_id = 'D-0204'
and file_path like '%/kelleymusic/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0204'
and dir_path like '%/kelleymusic/%';

update files
set file_type = 'system',
	appraisal_decision = 'scope'
where digital_media_id = 'D-0204'
and file_path like '%/Shared/%';

update files
set file_user = 'unk'
where digital_media_id = 'D-0205';

update directories
set dir_user = 'unk'
where digital_media_id = 'D-0205';

update files
set file_user = 'shop'
where digital_media_id = 'D-0210';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0210';

update files
set file_user = 'ah'
where digital_media_id = 'D-0211'
and file_path like '%/Ahrum Lacie/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0211'
and file_path like '%/MC bu files KS/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0211'
and file_path like '%/MC COMPUTER FILES 051811/%';

update files
set file_user = 'jw'
where digital_media_id = 'D-0211'
and file_path like '%/Jennie Backup/%';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0211'
and dir_path like '%/Ahrum Lacie/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0211'
and dir_path like '%/MC bu files KS/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0211'
and dir_path like '%/MC COMPUTER FILES 051811/%';

update directories
set dir_user = 'jw'
where digital_media_id = 'D-0211'
and dir_path like '%/Jennie Backup/%';

update files
set file_user = 'shop'
where digital_media_id = 'D-0214'
and file_path like '%2014-10-17-130314/SHOP LAPTOP/Users/studioe/%';

update files
set file_user = 'shop'
where digital_media_id = 'D-0214'
and file_path like '%2014-10-17-130314/SHOP LAPTOP/Users/shoplaptop/%';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0214'
and dir_path like '%2014-10-17-130314/SHOP LAPTOP/Users/studioe/%';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0214'
and dir_path like '%2014-10-17-130314/SHOP LAPTOP/Users/shoplaptop/%';

update files
set file_user = 'shop'
where digital_media_id = 'D-0216';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0216';

update files
set file_user = 'shop'
where digital_media_id = 'D-0218'
and file_path like '%SHOP FILES/%';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0218'
and dir_path like '%SHOP FILES/%';

update files 
set file_user = 'jw'
where digital_media_id = 'D-0219'
and file_path like '%/Jennie Backup/%';

update files 
set file_user = 'mc'
where digital_media_id = 'D-0219'
and 
(file_path like '%/MC transfer-050712/%'
 or file_path like '%/MC Old iMac Backup/%');

update files
set file_user = 'ah'
where digital_media_id = 'D-0219'
and file_path like '%/AH old Mac G5 HD/%';

update directories 
set dir_user = 'jw'
where digital_media_id = 'D-0219'
and dir_path like '%/Jennie Backup/%';

update directories 
set dir_user = 'mc'
where digital_media_id = 'D-0219'
and 
(dir_path like '%/MC transfer-050712/%'
 or dir_path like '%/MC Old iMac Backup/%');

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0219'
and dir_path like '%/AH old Mac G5 HD/%';

update files
set file_user = 'shop'
where digital_media_id = 'D-0220';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0220';

update files
set file_user = 'shop'
where digital_media_id = 'D-0221';

update directories
set dir_user = 'shop'
where digital_media_id = 'D-0221';

update files
set file_user = 'ah'
where digital_media_id = 'D-0224';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0224';

update files
set file_user = 'mk'
where digital_media_id = 'D-0225'
and file_path like '%/mikekelley/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0225'
and dir_path like '%/mikekelley/%';

update files
set file_user = 'all'
where digital_media_id = 'D-0225'
and file_path like '%/Shared/%';

update directories
set dir_user = 'all'
where digital_media_id = 'D-0225'
and dir_path like '%/Shared/%';

update files
set file_user = 'mk'
where digital_media_id = 'D-0226'
and (file_path like '%iTunes/%'
	 or file_path like '%songs%');

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0226'
and (dir_path like '%/iTunes/%'
	 or dir_path like '%songs%');
	 
update files 
set file_type = 'music'
where digital_media_id = 'D-0226'
and (file_path like '%/iTunes/%'
	 or file_path like '%/songs%');
	 
update files 
set file_type = 'music',
	file_user = 'mk'
where digital_media_id = 'D-0227';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0227';

update files
set file_user = 'mk'
where digital_media_id = 'D-0230'
and file_path like '%/mikekelley/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0230'
and dir_path like '%/mikekelley/%';	 

update files
set file_user = 'ah'
where digital_media_id = 'D-0231';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0231';

update files
set file_user = 'ah'
where digital_media_id = 'D-0232'
and file_path like '%/ahrum desktop /%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0232'
and file_path like '%/mc iMac/%';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0232'
and dir_path like '%/ahrum desktop /%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0232'
and dir_path like '%/mc iMac/%';

update files
set file_user = 'av'
where digital_media_id = 'D-0232'
and file_path like '%/Workstation/%';

update directories
set dir_user = 'av'
where digital_media_id = 'D-0232'
and dir_path like '%/Workstation/%';

update files
set file_user = 'bk'
where digital_media_id = 'D-0234';

update directories
set dir_user = 'bk'
where digital_media_id = 'D-0234';

update files
set file_user = 'ah'
where digital_media_id = 'D-0235';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0235';

update files
set file_user = 'ah'
where digital_media_id = 'D-0237'
and file_path like '%/LaCie on Ahrum/%';

update files
set file_user = 'mc'
where digital_media_id = 'D-0237'
and file_path like '%/MC FILES%';

update files
set file_user = 'bk'
where digital_media_id = 'D-0237'
and file_path like '%/MISC QB Backups/%';

update directories
set dir_user = 'ah'
where digital_media_id = 'D-0237'
and dir_path like '%/LaCie on Ahrum/%';

update directories
set dir_user = 'mc'
where digital_media_id = 'D-0237'
and dir_path like '%/MC FILES%';

update directories
set dir_user = 'bk'
where digital_media_id = 'D-0237'
and dir_path like '%/MISC QB Backups/%';

update files
set file_user = 'mk',
file_type = 'music'
where digital_media_id = 'D-0238';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0238';

update files
set file_user = 'mk'
where digital_media_id = 'D-0244'
and file_path like '%/MC transfer%';

update files
set file_user = 'jw'
where digital_media_id = 'D-0244'
and file_path like '%/Jennie Backup/%';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0244'
and dir_path like '%/MC transfer%';

update directories
set dir_user = 'jw'
where digital_media_id = 'D-0244'
and dir_path like '%/Jennie Backup/%';

update files
set file_user = 'mk'
where digital_media_id = 'D-0249';

update directories
set dir_user = 'mk'
where digital_media_id = 'D-0249';

update files
set file_user = 'shop'
where digital_media_id = 'D-0251'
and file_path like '%Shop %';



