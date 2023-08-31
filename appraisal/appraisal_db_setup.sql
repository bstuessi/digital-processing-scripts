--DATA TYPES--
CREATE TYPE media_types as ENUM ('computer', 'hard drive', 'hard drive (loose)');
CREATE TYPE transfer_types as ENUM ('disk image', 'logical');

CREATE TABLE SIPs (
    id VARCHAR(6) PRIMARY KEY NOT NULL,
    media_type media_types NOT NULL,
    transfer_method transfer_types NOT NULL,
    rank SMALLINT
);

CREATE TABLE directories (
    id BIGSERIAL PRIMARY KEY,
    dir_path TEXT NOT NULL,
    dir_name TEXT NOT NULL,
    size BIGINT NOT NULL,
    digital_media_id VARCHAR(6) REFERENCES SIPs (id) NOT NULL
);

CREATE TABLE formats (
    id SERIAL PRIMARY KEY,
    puid VARCHAR(6) NOT NULL,
    name VARCHAR(20) NOT NULL,
    mime_type VARCHAR(30) NOT NULL,
    version VARCHAR(10)
);

CREATE TABLE files (
    id BIGSERIAL PRIMARY KEY,
    directory_id BIGINT REFERENCES directories (id) NOT NULL,
    file_path TEXT NOT NULL,
    file_name VARCHAR(40) NOT NULL, 
    size BIGINT NOT NULL,
    md5_hash CHAR(32) NOT NULL,
    format_id INT REFERENCES formats (id) NOT NULL,
    digital_media_id VARCHAR(6) REFERENCES SIPs (id) NOT NULL
);

