SELECT w.id, wp.age, w.coins_needed, w.power
FROM wands w
INNER JOIN wands_property wp
    on w.code = wp.code
WHERE wp.is_evil = 0 and 
    w.coins_needed = (select min(coins_needed)
                             from wands as w1
                            inner join wands_property as wp1
                            on w1.code=wp1.code  
                            where w1.power = w.power and wp1.age = wp.age
                            )
ORDER BY w.POWER DESC, wp.AGE DESC;