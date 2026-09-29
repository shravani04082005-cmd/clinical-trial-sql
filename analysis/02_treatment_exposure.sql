--Question: How many participants completed treatment and how many discontinued treatment?
SELECT "exposure_status", COUNT(*) AS "participant_count" FROM "exposure"
WHERE "exposure_status" IN ("COMPLETED", "DISCONTINUED")
GROUP BY "exposure_status";

--Question: How many participants discontinued treatment in each treatment group?
SELECT "treatment_code", COUNT(*) AS "discontinued_participant_count" FROM "exposure"
WHERE "exposure_status" = "DISCONTINUED"
GROUP BY "treatment_code";

--Question: How many participants had a dose modification in each treatment group?
SELECT "treatment_code", COUNT(*) AS "dose_modified_participant_count" FROM "exposure"
WHERE "dose_modification" = "Y"
GROUP BY "treatment_code";

--Question: What are the reasons for treatment discontinuation, and how many participants discontinued for each reason?
SELECT "reason", COUNT(*) AS "participant_count" FROM "disposition"
WHERE "disposition_status" = "DISCONTINUED"
GROUP BY "reason";

--Question: How many participants in each treatment group completed versus discontinued treatment?
SELECT "treatment_code", "disposition_status", COUNT(*) AS "participant_count" FROM "disposition"
JOIN "treatment"
ON "disposition"."participant_id" = "treatment"."participant_id"
GROUP BY "treatment_code", "disposition_status";

--Question: What are the reasons for treatment discontinuation within each treatment group?
SELECT "treatment_code", "reason", COUNT(*) AS "participant_count" FROM "disposition"
JOIN "treatment"
ON "disposition"."participant_id" = "treatment"."participant_id"
WHERE "disposition_status" = "DISCONTINUED"
GROUP BY "treatment_code", "reason";
