/*1 ������*/
SELECT DISTINCT name
FROM ����� LEFT JOIN ������ ON �����.second_pilot_id = ������.pilot_id 
WHERE MONTH(flight_dt) = 8 AND YEAR(flight_dt) = YEAR(GETDATE()) AND destination = '�����������' 

/*2 ������*/
SELECT (SELECT name FROM ������ WHERE T.pilot_id = ������.pilot_id) AS name
FROM (SELECT pilot_id
	  FROM ����� LEFT JOIN �������� ON �����.plane_id = ��������.plane_id LEFT JOIN ������ ON �����.first_pilot_id = ������.pilot_id
	  WHERE cargo_flg = 1 AND age > 45
	  UNION ALL 
	  SELECT pilot_id
	  FROM ����� LEFT JOIN �������� ON �����.plane_id = ��������.plane_id LEFT JOIN ������ ON �����.second_pilot_id = ������.pilot_id
	  WHERE cargo_flg = 1 AND age > 45) AS T
GROUP BY pilot_id
HAVING COUNT(pilot_id) > 30

/*3 ������*/
SELECT TOP 10 (SELECT name FROM ������ WHERE ������.pilot_id = �����.first_pilot_id) AS name
FROM �����
WHERE YEAR(flight_dt) = YEAR(GETDATE())
GROUP BY first_pilot_id
ORDER BY SUM(quantity) DESC