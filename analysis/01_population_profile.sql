--Question: How many participants were assigned to each treatment group?
SELECT "treatment_code", COUNT(*) AS "participant_count"
FROM "treatment"
GROUP BY "treatment_code";

--Question: What is the distribution of participants by sex within the study population?
SELECT "sex", COUNT(*) AS "participant_count"
FROM "participants"
GROUP BY "sex";

--Question: What is the distribution of participants by sex within each treatment group?
SELECT  "sex", "treatment_code", COUNT(*) AS "participant_count" FROM "treatment"
JOIN "participants" 
ON "participants"."participant_id" = "treatment"."participant_id"
GROUP BY "treatment_code", "sex";

--Question: What are the min., max., and average ages of participants in each treatment group?
SELECT "treatment_code", MIN("age") AS "minimum_age", MAX("age") AS "maximum_age", AVG("age") AS "average_age" FROM "participants"
JOIN "treatment"
ON "participants"."participant_id" = "treatment"."participant_id"
GROUP BY "treatment_code";

--Question: How many participants aged 60 or older are in each treatment group?
SELECT "treatment_code", COUNT("*") AS "participant_count_aged_60_or_more" FROM "participants"
JOIN "treatment" 
ON "participants"."participant_id" = "treatment"."participant_id"
WHERE "age" >= 60
GROUP BY "treatment_code";

--Question: How many participants were enrolled from each country?
SELECT "country", COUNT(*) AS "participant_count" FROM "participants"
GROUP BY "country";
