/*1 вопрос*/
SELECT DISTINCT name
FROM Рейсы LEFT JOIN Пилоты ON Рейсы.second_pilot_id = Пилоты.pilot_id 
WHERE MONTH(flight_dt) = 8 AND YEAR(flight_dt) = YEAR(GETDATE()) AND destination = 'Шереметьево' 

/*2 вопрос*/
SELECT (SELECT name FROM Пилоты WHERE T.pilot_id = Пилоты.pilot_id) AS name
FROM (SELECT pilot_id
	  FROM Рейсы LEFT JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id LEFT JOIN Пилоты ON Рейсы.first_pilot_id = Пилоты.pilot_id
	  WHERE cargo_flg = 1 AND age > 45
	  UNION ALL 
	  SELECT pilot_id
	  FROM Рейсы LEFT JOIN Самолеты ON Рейсы.plane_id = Самолеты.plane_id LEFT JOIN Пилоты ON Рейсы.second_pilot_id = Пилоты.pilot_id
	  WHERE cargo_flg = 1 AND age > 45) AS T
GROUP BY pilot_id
HAVING COUNT(pilot_id) > 30

/*3 вопрос*/
SELECT TOP 10 (SELECT name FROM Пилоты WHERE Пилоты.pilot_id = Рейсы.first_pilot_id) AS name
FROM Рейсы
WHERE YEAR(flight_dt) = YEAR(GETDATE())
GROUP BY first_pilot_id
ORDER BY SUM(quantity) DESC