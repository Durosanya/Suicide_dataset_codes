-- Suicide Rate based on Age group and generation--

SELECT AgeGroup, generation,
	   sum(SuicideCount) AS number_of_suicide
FROM suicide_rates
WHERE generation != 'Unknown'
GROUP BY AgeGroup,Generation
ORDER BY number_of_suicide
;

-- Suicide rate based on Continents

SELECT RegionName, sum(SuicideCount) AS total_suicide
FROM suicide_rates
WHERE generation != 'Unknown'
GROUP BY RegionName
ORDER BY total_suicide
;


--Suicide trend over time per continent--

--AFRICA--

SELECT  Year,	
		SUM(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR BETWEEN '2000' AND '2020'
    AND RegionName like '%Africa%'
GROUP BY  Year,
		RegionName
ORDER BY number_of_suicide, Year
;		

--ASIA--

SELECT  Year,
		RegionName,
		SUM(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR BETWEEN '2000' AND '2020'
    AND RegionName LIKE '%Asia%'
GROUP BY  Year,
		RegionName
ORDER BY Year, number_of_suicide
;

--EUROPE--

SELECT  Year,
		RegionName,
		sum(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR BETWEEN '2000' AND '2020'
    AND RegionName LIKE '%Europe%'
GROUP BY  Year,
		RegionName
ORDER BY Year, number_of_suicide
;

--OCEANIA--

SELECT  Year,
		RegionName,
		sum(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR between '2000' AND '2020'
    AND RegionName LIKE '%Oceania%'
GROUP BY  Year,
		RegionName
ORDER BY Year, number_of_suicide
;

-- Central and South America--

SELECT  Year,
		RegionName,
		SUM(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR between '2000' AND '2020'
    AND RegionName LIKE '%Central and South America%'
GROUP BY  Year,
		RegionName
ORDER BY Year, number_of_suicide
;

--North America and the Caribbean--

SELECT  Year,
		RegionName,
		SUM(SuicideCount) AS number_of_suicide
		
FROM suicide_rates
WHERE generation != 'Unknown'
    AND YEAR between '2000' AND '2020'
    AND RegionName = 'North America and the Caribbean'
GROUP BY  Year,
		RegionName
ORDER BY Year, number_of_suicide
;

-- top 10 countries in suicide

SELECT TOP 10 CountryName,
	   SUM(SuicideCount) as number_of_suicide
FROM suicide_rates
    WHERE generation != 'Unknown'
    AND YEAR BETWEEN '2000' AND '2020'
GROUP BY CountryName
ORDER BY number_of_suicide DESC

;


--correlation between suicide and inflation
SELECT Year, InflationRate, SUM(SuicideCount) AS TotalSuicides
FROM suicide_rates
GROUP BY InflationRate,
		  Year;

-- correlation between % change in suicide rate and % change in inflation rate 
SELECT 
    Year,
    SuicideCount,
    InflationRate,
    LAG(SuicideCount) OVER (ORDER BY Year) AS prev_suicide_rate,
    LAG(InflationRate) OVER (ORDER BY Year) AS prev_inflation_rate,
    
    -- Percentage change in suicide rate
    CASE 
        WHEN LAG(SuicideCount) OVER (ORDER BY Year) IS NOT NULL THEN 
            ((SuicideCount - LAG(SuicideCount) OVER (ORDER BY Year)) / LAG(SuicideCount) OVER (ORDER BY Year)) * 100
        ELSE NULL
    END AS suicide_rate_pct_change,

    -- Percentage change in inflation rate
    CASE 
        WHEN LAG(InflationRate) OVER (ORDER BY Year) IS NOT NULL THEN 
            ((InflationRate - LAG(InflationRate) OVER (ORDER BY Year)) / LAG(InflationRate) OVER (ORDER BY Year)) * 100
        ELSE NULL
    END AS inflation_rate_pct_change

FROM 
    suicide
WHERE --generation != 'Unknown'
YEAR BETWEEN '2000' AND '2020'
AND CountryName like '%Britian%'

ORDER BY 
    Year;

