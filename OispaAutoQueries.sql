SELECT Asiakas.Etunimi AS Nimi, Varaus.KuljettuMatka AS "Kuljettu matka"
FROM Asiakas INNER JOIN Varaus ON Asiakas.AsiakasID = Varaus.AsiakasID
WHERE Varaus.KuljettuMatka > 0;

SELECT * FROM Asiakas
WHERE Postinumero LIKE '33100' OR Postinumero LIKE '33000';

SELECT Rekisterinumero, Leveysaste, Pituusaste FROM Auto
WHERE Varaustila LIKE 'Vapaa' AND Akku > 50;

SELECT COUNT(AutoID) AS 'Autojen lukumäärä' FROM Auto;

SELECT Akku, KuljettuMatka FROM Auto
LEFT OUTER JOIN Varaus ON Auto.VarausID = Varaus.VarausID
GROUP BY Akku
ORDER BY Akku DESC, KuljettuMatka DESC;

SELECT ROUND(AVG(Akku), 0) AS "Tällä hetkellä autojen akuilla päästävät kilometrit keskiarvona" FROM Auto;

SELECT COUNT(AsiakasID) AS "Tampereella asuvien lkm"
FROM Asiakas
WHERE Postinumero LIKE '3%';

SELECT AsiakasID, ROUND(SUM(KuljettuMatka), 0)  AS "Kuljettu matka"
FROM Varaus
GROUP BY AsiakasID
HAVING SUM(KuljettuMatka) > 0
ORDER BY "Kuljettu matka" DESC;

SELECT * FROM Varaus
WHERE Varausloppu IS NOT NULL;

SELECT Auto.Rekisterinumero, Varaus.VarausAlku, Asiakas.Etunimi, Asiakas.Sukunimi
FROM (Auto LEFT OUTER JOIN Varaus ON Auto.VarausID = Varaus.VarausID)
LEFT OUTER JOIN Asiakas ON Varaus.AsiakasID = Asiakas.AsiakasID
WHERE VarausAlku IS NOT NULL;


-- Katsotaan vielä lopuksi, kuinka paljon Kyllikillä on kertynyt maksettavaa.

SELECT Etunimi, Sukunimi,
CEILING(TIME_TO_SEC(TIMEDIFF(VarausLoppu, VarausAlku))/3600) as "Alkavat tunnit",
TIMEDIFF(VarausLoppu, VarausAlku) as "Ajettu aika",
KuljettuMatka,
ROUND((CEILING(TIME_TO_SEC(TIMEDIFF(VarausLoppu, VarausAlku))/3600)*3+KuljettuMatka*0.3),2) AS "Maksettavaa"
FROM Varaus
INNER JOIN Asiakas ON Varaus.AsiakasID = Asiakas.AsiakasID
WHERE Etunimi LIKE 'Kyllikki' AND Sukunimi LIKE 'Gimenez';