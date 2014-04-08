#
#Run the following query on each provider of your ADA installation, excluding common
#

ALTER TABLE  `iscrizioni` ADD  `codice` VARCHAR( 15 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL ,
ADD  `data_iscrizione` INT( 11 ) NOT NULL DEFAULT  '0';