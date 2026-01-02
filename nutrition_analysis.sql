/*Create database*/
/*create database nutrition*/
use nutrition
/* =========================================================
   McDonald's Nutrition Data Analysis
   Database: nutrition
   Table Name: menu
   ========================================================= */




-- Q1: Total number of menu items
SELECT COUNT(*) AS total_items
FROM menu;

-- Q2: Average calories across all items
SELECT ROUND(AVG(calories), 2) AS avg_calories
FROM menu;

-- Q3: Highest calorie item
SELECT TOP 1 item, calories
FROM menu
ORDER BY calories DESC;

-- Q4: Lowest calorie item
SELECT TOP 1 item, calories
FROM menu
ORDER BY calories ASC;


/* ===============================
   CATEGORY ANALYSIS
   =============================== */

-- Q5: Number of items per category
SELECT category, COUNT(*) AS item_count
FROM menu
GROUP BY category;

-- Q6: Average calories per category
SELECT category, ROUND(AVG(calories), 2) AS avg_calories
FROM menu
GROUP BY category;

-- Q7: Total calories per category
SELECT category, SUM(calories) AS total_calories
FROM menu
GROUP BY category;

-- Q8: Average protein per category
SELECT category, ROUND(AVG(protein), 2) AS avg_protein
FROM menu
GROUP BY category;


/* ===============================
   NUTRITION DISTRIBUTION
   =============================== */

-- Q9: Distribution of menu items by calorie range
SELECT calorie_range, COUNT(*) AS item_count
FROM (
    SELECT
        CASE
            WHEN calories < 200 THEN '<200'
            WHEN calories BETWEEN 200 AND 400 THEN '200-400'
            WHEN calories BETWEEN 401 AND 600 THEN '401-600'
            ELSE '>600'
        END AS calorie_range
    FROM menu
) AS t
GROUP BY calorie_range;

-- Q10: Distribution of items by sugar range
SELECT sugar_range, COUNT(*) AS item_count
FROM (
    SELECT
        CASE
            WHEN sugars = 0 THEN '0'
            WHEN sugars BETWEEN 1 AND 10 THEN '1-10'
            WHEN sugars BETWEEN 11 AND 25 THEN '11-25'
            ELSE '>25'
        END AS sugar_range
    FROM menu
) AS t
GROUP BY sugar_range;


/* ===============================
   HEALTH & RISK ANALYSIS
   =============================== */

-- Q11: Items with very high sodium (>1000 mg)
SELECT item, sodium
FROM menu
WHERE sodium > 1000
ORDER BY sodium DESC;

-- Q12: Average sodium per category
SELECT category, ROUND(AVG(sodium), 2) AS avg_sodium
FROM menu
GROUP BY category;

-- Q13: Items with high fat (>20g)
SELECT item, total_fat
FROM menu
WHERE total_fat > 20
ORDER BY total_fat DESC;


/* ===============================
   MACRO NUTRIENT COMPARISON
   =============================== */

-- Q14: Calories vs Protein
SELECT item, calories, protein
FROM menu;

-- Q15: Fat vs Calories
SELECT item, total_fat, calories
FROM menu;

-- Q16: Sugar vs Carbohydrates
SELECT item, sugars, carbohydrates
FROM menu;


/* ===============================
   HEALTHY vs UNHEALTHY ITEMS
   =============================== */

-- Q17: Low-calorie & high-protein items
SELECT item, calories, protein
FROM menu
WHERE calories < 400 AND protein >= 20;

-- Q18: High-calorie but low-protein items
SELECT item, calories, protein
FROM menu
WHERE calories > 500 AND protein < 10;


/* ===============================
   TOP ITEMS
   =============================== */

-- Q19: Top 10 highest calorie items
SELECT TOP 10 item, calories
FROM menu
ORDER BY calories DESC;

-- Q20: Top 10 highest sugar items
SELECT TOP 10 item, sugars
FROM menu
ORDER BY sugars DESC;

-- Q21: Top 10 protein-rich items
SELECT TOP 10 item, protein
FROM menu
ORDER BY protein DESC;


/* ===============================
   ADVANCED METRICS
   =============================== */

-- Q22: Calorie-to-protein ratio
SELECT item,
       ROUND(calories / NULLIF(protein, 0), 2) AS calorie_protein_ratio
FROM menu
ORDER BY calorie_protein_ratio DESC;

-- Q23: Percentage of calories from fat (approx)
SELECT item,
       ROUND((total_fat * 9.0 / calories) * 100, 2) AS fat_percentage
FROM menu
WHERE calories > 0;


/* ===============================
   DASHBOARD SUMMARY
   =============================== */

-- Q24: Category-wise nutrition summary
SELECT category,
       ROUND(AVG(calories), 2) AS avg_calories,
       ROUND(AVG(protein), 2) AS avg_protein,
       ROUND(AVG(sugars), 2) AS avg_sugars,
       ROUND(AVG(sodium), 2) AS avg_sodium
FROM menu
GROUP BY category;

