--
-- The contents of this file are subject to the license and copyright
-- detailed in the LICENSE and NOTICE files at the root of the source
-- tree and available online at
--
-- http://www.dspace.org/license/
--

-----------------------------------------------------------------------------------
-- Create tables for DBMS Import framework
-----------------------------------------------------------------------------------

CREATE TABLE imp_record (
    imp_id INTEGER PRIMARY KEY,
    imp_record_id VARCHAR(256) NOT NULL,
    imp_eperson_uuid UUID NOT NULL REFERENCES eperson(uuid),
    imp_collection_uuid UUID NOT NULL REFERENCES collection(uuid),
    status VARCHAR(1),
    operation VARCHAR(64),
    integra BOOLEAN,
    last_modified TIMESTAMP,
    handle VARCHAR(64),
    imp_sourceref VARCHAR(256)
);

CREATE TABLE imp_workflow_nstate(
	imp_wnstate_op_id INTEGER PRIMARY KEY,
	imp_wnstate_desc VARCHAR(64),
	imp_wnstate_op VARCHAR(64) NOT NULL,
	imp_wnstate_op_par VARCHAR(64),
	imp_wnstate_order INTEGER NOT NULL,
	imp_wnstate_eperson_uuid UUID
);

CREATE TABLE imp_record_wstate(
	imp_id INTEGER NOT NULL REFERENCES imp_record(imp_id),
	imp_wnstate_op_id INTEGER NOT NULL REFERENCES imp_workflow_nstate(imp_wnstate_op_id),
	PRIMARY KEY (imp_id, imp_wnstate_op_id)
);

CREATE TABLE imp_metadatavalue (
    imp_metadatavalue_id INTEGER PRIMARY KEY,
    imp_id INTEGER NOT NULL REFERENCES imp_record(imp_id),
    imp_schema VARCHAR2(128) NOT NULL,
    imp_element VARCHAR2(128) NOT NULL,
    imp_qualifier VARCHAR2(128),
    imp_value CLOB NOT NULL,
    imp_authority VARCHAR2(256),
    imp_confidence INTEGER,
    imp_share INTEGER,
    metadata_order INTEGER NOT NULL,
    text_lang VARCHAR2(32)
);

CREATE INDEX imp_mv_idx_impid ON imp_metadatavalue(imp_id);

CREATE TABLE imp_bitstream (
    imp_bitstream_id INTEGER PRIMARY KEY,
    imp_id INTEGER NOT NULL REFERENCES imp_record(imp_id),
    filepath VARCHAR2(512) NOT NULL,
    description VARCHAR2(512),
    bundle VARCHAR2(512),
    bitstream_order INTEGER,
    primary_bitstream BOOLEAN,
    assetstore INTEGER DEFAULT '-1'::integer,
    name VARCHAR2(512),
    imp_blob VARBINARY(200000),
    embargo_policy INTEGER DEFAULT '-1'::integer,
    embargo_start_date VARCHAR2(100),
    md5value VARCHAR2(32)
);

CREATE INDEX imp_bit_idx_impid ON imp_bitstream(imp_id);

CREATE TABLE imp_bitstream_metadatavalue (
    imp_bitstream_metadatavalue_id INTEGER PRIMARY KEY,
    imp_bitstream_id INTEGER NOT NULL REFERENCES imp_bitstream(imp_bitstream_id),
    imp_schema VARCHAR2(128) NOT NULL,
    imp_element VARCHAR2(128) NOT NULL,
    imp_qualifier VARCHAR2(128),
    imp_value CLOB NOT NULL,
    imp_authority VARCHAR2(256),
    imp_confidence INTEGER,
    imp_share INTEGER,
    metadata_order INTEGER NOT NULL,
    text_lang VARCHAR2(32)
);

CREATE INDEX imp_bitstream_mv_idx_impid ON imp_bitstream_metadatavalue(imp_bitstream_id);

CREATE TABLE imp_record_to_item (
    imp_record_id VARCHAR(256) PRIMARY KEY,
    imp_item_id UUID NOT NULL,
    imp_sourceref VARCHAR(256)
);
