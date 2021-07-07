#SELECTING MEAN VALUE
USE errors;

SET @ROWINDEX:= -1;
SELECT 
    ROUND(AVG(M.weight), 4)
FROM
    (SELECT 
        @ROWINDEX:=@ROWINDEX + 1 AS ROWINDEX, mpg.weight AS weight
    FROM
        mpg
    ORDER BY weight) AS M
WHERE
    M.ROWINDEX IN (FLOOR(@ROWINDEX / 2) , CEIL(@ROWINDEX / 2));
    
    
    


    
    
