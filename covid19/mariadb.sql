CREATE DATABASE `covid` /*!40100 DEFAULT CHARACTER SET utf8 */;

DROP USER IF EXISTS covid;
CREATE USER 'covid@% IDENTIFIED' BY 'covid';


CREATE TABLE `dati` (
  `data` varchar(20) NOT NULL,
  `ricoverati_con_sintomi` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `terapia_intensiva` int(11) DEFAULT NULL,
  `totale_ospedalizzati` int(11) DEFAULT NULL,
  `isolamento_domiciliare` int(11) DEFAULT NULL,
  `totale_positivi` int(11) DEFAULT NULL,
  `variazione_totale_positivi` int(11) DEFAULT NULL,
  `nuovi_positivi` int(11) DEFAULT NULL,
  `dimessi_guariti` int(11) DEFAULT NULL,
  `deceduti` int(11) DEFAULT NULL,
  `casi_da_sospetto_diagnostico` int(11) DEFAULT NULL,
  `casi_da_screening` int(11) DEFAULT NULL,
  `totale_casi` int(11) DEFAULT NULL,
  `tamponi` int(11) DEFAULT NULL,
  `casi_testati` int(11) DEFAULT NULL,
  `note` varchar(45) DEFAULT NULL,
  `ingressi_terapia_intensiva` int(11) DEFAULT NULL,
  `note_test` varchar(45) DEFAULT NULL,
  `note_casi` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=311 DEFAULT CHARSET=utf8;


CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `covid`@`%` 
    SQL SECURITY DEFINER
VIEW `daticovid` AS
    SELECT 
        STR_TO_DATE(`t1`.`data`, '%Y-%m-%dT%H:%i:%s') AS `time`,
        `t1`.`ricoverati_con_sintomi` AS `ricoverati_con_sintomi`,
        `t1`.`terapia_intensiva` AS `terapia_intensiva`,
        `t1`.`totale_ospedalizzati` AS `totale_ospedalizzati`,
        `t1`.`isolamento_domiciliare` AS `isolamento_domiciliare`,
        `t1`.`totale_positivi` AS `totale_positivi`,
        `t1`.`variazione_totale_positivi` AS `variazione_totale_positivi`,
        `t1`.`nuovi_positivi` AS `nuovi_positivi`,
        `t1`.`dimessi_guariti` AS `dimessi_guariti`,
        `t1`.`dimessi_guariti` - `t2`.`dimessi_guariti` AS `dimessi_guariti_delta`,
        `t1`.`deceduti` AS `deceduti`,
        `t1`.`deceduti` - `t2`.`deceduti` AS `deceduti_delta`,
        `t1`.`totale_casi` AS `totale_casi`,
        `t1`.`tamponi` AS `tamponi`,
        `t1`.`tamponi` - `t2`.`tamponi` AS `tamponi_delta`
    FROM
        (`dati` `t1`
        LEFT JOIN `dati` `t2` ON (`t1`.`id` = `t2`.`id` + 1))
    ORDER BY `t1`.`id`

