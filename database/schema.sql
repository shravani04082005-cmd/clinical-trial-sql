CREATE TABLE "participants" (
    "participant_id" TEXT PRIMARY KEY,
    "site_id" TEXT NOT NULL,
    "screening_date" TEXT NOT NULL,
    "date_of_birth" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "sex" TEXT NOT NULL,
    "race" TEXT NOT NULL,
    "country" TEXT NOT NULL
);

CREATE TABLE "treatment" (
    "participant_id" TEXT PRIMARY KEY,
    "treatment_code" TEXT NOT NULL,
    "treatment_name" TEXT NOT NULL,
    "dose_mg" INTEGER NOT NULL,
    "randomization_date" TEXT NOT NULL,
    FOREIGN KEY("participant_id") REFERENCES "participants"("participant_id")
);

CREATE TABLE "visits" (
    "participant_id" TEXT NOT NULL,
    "visit_code" TEXT NOT NULL,
    "visit_name" TEXT NOT NULL,
    "visit_number" INTEGER NOT NULL,
    "planned_day" INTEGER NOT NULL,
    "visit_date" TEXT NOT NULL,
    "visit_status" TEXT NOT NULL,
    PRIMARY KEY ("participant_id", "visit_code"),
    FOREIGN KEY ("participant_id") REFERENCES "participants"("participant_id")
);

CREATE TABLE "laboratory" (
    "participant_id" TEXT NOT NULL,
    "visit_code" TEXT NOT NULL,
    "lab_code" TEXT NOT NULL,
    "lab_name" TEXT NOT NULL,
    "result" REAL,
    "unit" TEXT NOT NULL,
    "reference_low" REAL,
    "reference_high" REAL,
    "result_status" TEXT NOT NULL,
    "collection_date" TEXT NOT NULL,
    PRIMARY KEY ("participant_id", "visit_code", "lab_code"),
    FOREIGN KEY ("participant_id", "visit_code") REFERENCES "visits"("participant_id", "visit_code")
);

CREATE TABLE "vital_signs" (
    "participant_id" TEXT NOT NULL,
    "visit_code" TEXT NOT NULL,
    "vital_code" TEXT NOT NULL,
    "vital_name" TEXT NOT NULL,
    "result" REAL,
    "unit" TEXT NOT NULL,
    "measurement_date" TEXT NOT NULL,
    PRIMARY KEY("participant_id", "visit_code", "vital_code")
    FOREIGN KEY("participant_id", "visit_code") REFERENCES "visits"("participant_id", "visit_code")
);

CREATE TABLE "adverse_events" (
    "ae_id" TEXT PRIMARY KEY,
    "participant_id" TEXT NOT NULL,
    "event_term" TEXT NOT NULL,
    "start_date" TEXT NOT NULL,
    "end_date" TEXT,
    "severity" TEXT NOT NULL,
    "serious" TEXT NOT NULL,
    "related_to_treatment" TEXT NOT NULL,
    "outcome" TEXT NOT NULL,
    FOREIGN KEY ("participant_id") REFERENCES "participants"("participant_id")
);

CREATE TABLE "exposure" (
    "exposure_id" TEXT PRIMARY KEY,
    "participant_id" TEXT NOT NULL,
    "treatment_code" TEXT NOT NULL,
    "dose_mg" INTEGER NOT NULL,
    "start_date" TEXT NOT NULL,
    "end_date" TEXT NOT NULL,
    "exposure_status" TEXT NOT NULL,
    "dose_modification" TEXT NOT NULL,
    FOREIGN KEY ("participant_id") REFERENCES "participants"("participant_id"),
    FOREIGN KEY ("participant_id") REFERENCES "treatment"("participant_id")
);

CREATE TABLE "disposition" (
    "disposition_id" TEXT PRIMARY KEY,
    "participant_id" TEXT NOT NULL UNIQUE, 
    "disposition_date" TEXT NOT NULL,
    "disposition_status" TEXT NOT NULL,
    "reason" TEXT,
    FOREIGN KEY ("participant_id") REFERENCES "participants"("participant_id")
);