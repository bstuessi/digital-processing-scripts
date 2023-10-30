/* find duplicates */

SELECT count(*) FROM files WHERE md5_hash IN (SELECT md5_hash FROM files GROUP BY md5_hash HAVING COUNT(*) > 1);
