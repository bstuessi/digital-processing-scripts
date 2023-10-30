--DATA TYPES--
CREATE TYPE media_types as ENUM ('computer', 'external hard drive', 'internal hard drive');
CREATE TYPE appraisal_criteria as ENUM ('keep', 'scope', 'ignore', 'duplicate');
CREATE TYPE record_type as ENUM ('application', 'music', 'photo', 'system', 'mail', 'document');
CREATE TYPE duplicate_method as ENUM ('checksum', 'dir_size');

CREATE TABLE media (
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    media_type media_types NOT NULL,
    group_id VARCHAR(3) NOT NULL,
    rank SMALLINT
);

CREATE TABLE directories (
    id BIGSERIAL PRIMARY KEY,
    parent_directory_id INT,
    dir_path TEXT NOT NULL,
    dir_name TEXT NOT NULL,
    size BIGINT,
    mtime TIMESTAMP,
    appraisal_decision appraisal_criteria DEFAULT NULL, 
    has_duplicates BOOLEAN DEFAULT FALSE,
    has_orphans BOOLEAN DEFAULT TRUE,
    digital_media_id VARCHAR(6) REFERENCES media (id) NOT NULL
);

CREATE TABLE formats (
    id SERIAL PRIMARY KEY,
    puid VARCHAR(15) NOT NULL,
    name TEXT NOT NULL,
    mime_type TEXT NOT NULL,
    extension VARCHAR(30), 
    version VARCHAR(20)
);


CREATE TABLE files (
    id BIGSERIAL PRIMARY KEY,
    directory_id BIGINT REFERENCES directories (id),
    file_path TEXT NOT NULL,
    file_name TEXT NOT NULL, 
    size BIGINT NOT NULL,
    mtime TIMESTAMP,
    md5_hash CHAR(32) NOT NULL,
    file_type record_type DEFAULT NULL,
    appraisal_decision appraisal_criteria DEFAULT NULL,
    has_duplicate BOOLEAN DEFAULT FALSE,
    format_id INT REFERENCES formats (id) NOT NULL,
    digital_media_id VARCHAR(6) REFERENCES media (id) NOT NULL
);

CREATE TABLE duplicate_files (
    id SERIAL PRIMARY KEY,
    primary_file_id BIGINT REFERENCES files (id),
    primary_file_media_id VARCHAR(6) REFERENCES media (id) NOT NULL,
    duplicate_file_id BIGINT REFERENCES files (id),
    duplicate_file_media_id VARCHAR(6) REFERENCES media (id) NOT NULL,
    identification_method duplicate_method
);

CREATE TABLE duplicate_directories (
    id SERIAL PRIMARY KEY,
    primary_dir_id BIGINT REFERENCES directories (id),
    primary_dir_media_id VARCHAR(6) REFERENCES media (id) NOT NULL,
    duplicate_dir_id BIGINT REFERENCES directories (id),
    duplicate_dir_media_id VARCHAR(6) REFERENCES media (id) NOT NULL
);