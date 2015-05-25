--
-- The contents of this file are subject to the license and copyright
-- detailed in the LICENSE and NOTICE files at the root of the source
-- tree and available online at
--
-- http://www.dspace.org/license/
--

ALTER TABLE subscription ADD COLUMN community_id integer;
ALTER TABLE subscription ADD CONSTRAINT subscription_community_id FOREIGN KEY (community_id) REFERENCES community (community_id) ON UPDATE NO ACTION ON DELETE NO ACTION;