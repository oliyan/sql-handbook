CREATE OR REPLACE PROCEDURE ravi.GETKURAL(
    IN NUMBER CHAR(4),
    OUT PAAL VARCHAR(25),
    OUT IYAL VARCHAR(50),
    OUT ATHIGARAM VARCHAR(50),
    OUT TRANSLATION VARCHAR(500), 
    OUT EXPLANATION VARCHAR(500)
)
  
LANGUAGE SQL
RESULT SETS 0


BEGIN
    SELECT sect_eng, chapgrp_eng, chap_eng, eng, eng_exp
    INTO PAAL, IYAL, ATHIGARAM, TRANSLATION, EXPLANATION
    FROM JSON_TABLE (
      SYSTOOLS.HTTPGETCLOB(
      'https://api-thirukkural.vercel.app/api?num=' CONCAT
      SYSTOOLS.URLENCODE(TRIM(NUMBER),''), NULL),
    '$'
    COLUMNS(
    sect_eng CHAR(25) path '$.sect_eng',
    chapgrp_eng CHAR(50) path '$.chapgrp_eng',
    chap_eng CHAR(50) path '$.chap_eng',
    eng CHAR(500) path '$.eng',
    eng_exp CHAR(500) path '$.eng_exp')

    error on error)
    as x;
END
