# Data Specification

## 1. Participants Dataset

### Purpose

The Participants dataset contains one record per synthetic study participant. It stores baseline demographic and enrollment information.

### Expected number of records

120

### Record structure

One row = one participant.

### Variables

| Variable | Description | Example |
|---|---|---|
| participant_id | Unique identifier assigned to each participant | SUBJ001 |
| site_id | Identifier for the clinical study site | SITE001 |
| screening_date | Date on which the participant entered screening | 2026-01-05 |
| date_of_birth | Participant's date of birth | 1971-04-18 |
| age | Participant's age at study entry | 54 |
| sex | Participant's recorded sex | F |
| race | Participant's recorded race | Asian |
| country | Country where the participant is enrolled | India |

### Controlled values

Sex:
- F
- M

Race:
- Asian
- White
- Black or African American
- Other

### Key rule

- participant_id must be unique. Each participant can appear only once in this dataset.
- site_id must correspond to a valid synthetic study site.

## 2. Treatment Dataset

### Purpose

The Treatment dataset records the treatment assigned to each synthetic study participant.

The treatment structure is part of the synthetic educational dataset and does not represent the actual treatment allocation of NCT02537470.

### Expected number of records

120

### Record structure

One row = one participant's randomized treatment assignment.

### Variables

| Variable | Description | Example |
|---|---|---|
| participant_id | Identifier linking the treatment assignment to the participant | SUBJ001 |
| treatment_code | Short standardized code for the assigned treatment | PLACEBO |
| treatment_name | Human-readable treatment name | Placebo |
| dose_mg | Assigned treatment dose in milligrams | 0 |
| randomization_date | Date on which treatment assignment occurred | 2026-01-08 |

### Treatment groups

| Treatment code | Treatment name | Dose |
|---|---|---:|
| PLACEBO | Placebo | 0 mg |
| REMO_LOW | Remogliflozin Low Dose | 100 mg |
| REMO_HIGH | Remogliflozin High Dose | 200 mg |

### Key rules

- participant_id must correspond to a participant in the Participants dataset.
- Each participant receives exactly one randomized treatment assignment.
- participant_id is unique within this dataset.
- treatment_code must be one of the three defined treatment codes.
- dose_mg must correspond to the assigned treatment code.

## 3. Visits Dataset

### Purpose

The Visits dataset records the planned and actual study visits for each synthetic participant.

### Expected number of records

Approximately 720 records if all 120 participants complete all six planned visits. The final number may be lower because some synthetic participants will discontinue or miss visits.

### Record structure

One row = one participant at one study visit.

### Planned visits

| Visit code | Visit name | Visit number | Planned study day |
|---|---|---:|---:|
| SCREEN | Screening | 1 | -14 |
| BASELINE | Baseline | 2 | 1 |
| WEEK4 | Week 4 | 3 | 29 |
| WEEK8 | Week 8 | 4 | 57 |
| WEEK12 | Week 12 | 5 | 85 |
| FOLLOWUP | Follow-up | 6 | 99 |

### Variables

| Variable | Description | Example |
|---|---|---|
| participant_id | Identifier linking the visit to the participant | SUBJ001 |
| visit_code | Standardized code identifying the visit | WEEK4 |
| visit_name | Human-readable visit name | Week 4 |
| visit_number | Numeric sequence of the visit | 3 |
| planned_day | Planned study day for the visit | 29 |
| visit_date | Actual date on which the visit occurred | 2026-02-06 |
| visit_status | Status of the visit | COMPLETED |

### Controlled values

visit_status:
- COMPLETED
- MISSED
- NOT_DONE

### Key rules

- participant_id must correspond to a participant in the Participants dataset.
- A participant may have multiple visit records.
- visit_code must correspond to one of the defined study visits.
- visit_number must represent the chronological order of the visit.
- A participant may miss or discontinue before completing all planned visits.
- visit_date may be missing when a planned visit was not completed.

## 4. Laboratory Dataset

### Purpose

The Laboratory dataset contains synthetic laboratory measurements collected from study participants at scheduled study visits.

### Record structure

One row = one laboratory test result for one participant at one visit.

A participant can therefore have many laboratory records.

### Laboratory tests

| Lab code | Laboratory test | Unit |
|---|---|---|
| HBA1C | HbA1c | % |
| FPG | Fasting plasma glucose | mg/dL |
| INSULIN | Insulin | µIU/mL |
| CPEPTIDE | C-peptide | ng/mL |
| TC | Total cholesterol | mg/dL |
| LDL | LDL cholesterol | mg/dL |
| HDL | HDL cholesterol | mg/dL |
| TG | Triglycerides | mg/dL |
| ALT | Alanine aminotransferase | U/L |
| AST | Aspartate aminotransferase | U/L |
| CREAT | Creatinine | mg/dL |
| EGFR | Estimated glomerular filtration rate | mL/min/1.73m² |

### Variables

| Variable | Description | Example |
|---|---|---|
| participant_id | Identifier linking the laboratory result to the participant | SUBJ001 |
| visit_code | Study visit at which the laboratory test was collected | WEEK4 |
| lab_code | Standardized laboratory test code | HBA1C |
| lab_name | Human-readable laboratory test name | HbA1c |
| result | Numeric laboratory result | 7.8 |
| unit | Unit of measurement | % |
| reference_low | Lower reference limit | 4.0 |
| reference_high | Upper reference limit | 5.6 |
| result_status | Classification of the laboratory result | ABNORMAL |
| collection_date | Date on which the specimen was collected | 2026-02-06 |

### Controlled values

result_status:
- NORMAL
- ABNORMAL
- MISSING

### Key rules

- participant_id must correspond to a participant in the Participants dataset.
- visit_code must correspond to a visit for that participant.
- lab_code must correspond to one of the defined laboratory tests.
- result must be stored as a numeric value when a measurement is available.
- unit must be stored separately from result.
- A missing laboratory result must be represented using SQL NULL rather than an empty string.
- Some synthetic records will intentionally contain missing or implausible values for later data-quality exercises.

### Example records

| participant_id | visit_code | lab_code | result | unit |
|---|---|---|---:|---|
| SUBJ001 | BASELINE | HBA1C | 8.2 | % |
| SUBJ001 | WEEK4 | HBA1C | 7.8 | % |
| SUBJ001 | WEEK8 | HBA1C | 7.5 | % |
| SUBJ001 | WEEK12 | HBA1C | 7.3 | % |
| SUBJ001 | BASELINE | FPG | 168 | mg/dL |

## 5. Vital Signs Dataset

### Purpose

The Vital Signs dataset contains synthetic measurements of participant vital signs collected during study visits.

### Record structure

One row = one vital-sign measurement for one participant at one visit.

A participant can therefore have multiple vital-sign records at each visit.

### Vital-sign measurements

| Vital code | Vital sign | Unit |
|---|---|---|
| SYSBP | Systolic Blood Pressure | mmHg |
| DIABP | Diastolic Blood Pressure | mmHg |
| PULSE | Pulse Rate | bpm |
| TEMP | Temperature | °C |
| WEIGHT | Body Weight | kg |

### Variables

| Variable | Description | Example |
|---|---|---|
| participant_id | Identifier linking the measurement to the participant | SUBJ001 |
| visit_code | Study visit at which the measurement was taken | BASELINE |
| vital_code | Standardized vital-sign code | SYSBP |
| vital_name | Human-readable vital-sign name | Systolic Blood Pressure |
| result | Numeric measurement | 132 |
| unit | Unit of measurement | mmHg |
| measurement_date | Date on which the measurement was taken | 2026-01-08 |

### Key rules

- participant_id must correspond to a participant in the Participants dataset.
- visit_code must correspond to a study visit for that participant.
- vital_code must correspond to one of the defined vital signs.
- result must be stored as a numeric value when a measurement is available.
- unit must be stored separately from result.
- Missing measurements will be represented using SQL NULL.
- Some synthetic records may contain missing or implausible values for later data-quality exercises.

### Example records

| participant_id | visit_code | vital_code | result | unit |
|---|---|---|---:|---|
| SUBJ001 | BASELINE | SYSBP | 132 | mmHg |
| SUBJ001 | BASELINE | DIABP | 82 | mmHg |
| SUBJ001 | BASELINE | PULSE | 74 | bpm |
| SUBJ001 | WEEK12 | WEIGHT | 70.5 | kg |

## 6. Adverse Events Dataset

### Purpose

The Adverse Events dataset contains synthetic adverse events experienced by study participants during the clinical trial.

An adverse event may occur between scheduled study visits and may therefore have start and end dates that do not correspond directly to a visit date.

### Record structure

One row = one adverse event experienced by one participant.

A participant may have zero, one, or multiple adverse events.

### Variables

| Variable | Description | Example |
|---|---|---|
| ae_id | Unique identifier for the adverse event | AE0001 |
| participant_id | Identifier linking the event to the participant | SUBJ014 |
| event_term | Description of the adverse event | Headache |
| start_date | Date on which the adverse event began | 2026-02-03 |
| end_date | Date on which the adverse event ended | 2026-02-05 |
| severity | Intensity of the adverse event | MILD |
| serious | Indicates whether the event meets serious adverse event criteria | N |
| related_to_treatment | Investigator assessment of relationship to study treatment | N |
| outcome | Outcome of the adverse event | RECOVERED |

### Potential synthetic adverse events

- Headache
- Nausea
- Dizziness
- Fatigue
- Diarrhea
- Urinary tract infection
- Genital fungal infection

### Controlled values

severity:
- MILD
- MODERATE
- SEVERE

serious:
- Y
- N

related_to_treatment:
- Y
- N
- UNKNOWN

outcome:
- RECOVERED
- RECOVERING
- NOT_RECOVERED
- FATAL
- UNKNOWN

### Key rules

- ae_id must be unique for every adverse event.
- participant_id must correspond to a participant in the Participants dataset.
- A participant may have zero, one, or multiple adverse events.
- start_date must not be later than end_date when an end date is available.
- end_date may be NULL when an event is ongoing.
- severity, serious, related_to_treatment, and outcome must use the defined controlled values.
- Some synthetic records may contain deliberate data-quality issues for later validation exercises.

## 7. Exposure Dataset

### Purpose

The Exposure dataset records the treatment actually administered to each synthetic study participant.

Treatment assignment and actual exposure are kept as separate concepts because a participant may be assigned to a treatment but discontinue, interrupt, or otherwise modify treatment during the study.

### Record structure

One row = one treatment exposure period for one participant.

### Variables

| Variable | Description | Example |
|---|---|---|
| exposure_id | Unique identifier for the exposure record | EX0001 |
| participant_id | Identifier linking the exposure to the participant | SUBJ001 |
| treatment_code | Code for the treatment actually administered | REMO_LOW |
| dose_mg | Dose administered in milligrams | 100 |
| start_date | Date on which exposure began | 2026-01-08 |
| end_date | Date on which exposure ended | 2026-04-03 |
| exposure_status | Status of the exposure period | COMPLETED |
| dose_modification | Indicates whether the dose was modified | N |

### Controlled values

exposure_status:
- COMPLETED
- DISCONTINUED
- INTERRUPTED

dose_modification:
- Y
- N

### Key rules

- exposure_id must be unique.
- participant_id must correspond to a participant in the Participants dataset.
- treatment_code must correspond to a defined treatment.
- dose_mg must correspond to the treatment administered.
- start_date must not be later than end_date when an end date is available.
- end_date may be NULL when exposure is ongoing.
- Some participants may discontinue or interrupt treatment.
- Some synthetic records may contain deliberate data-quality issues for later validation exercises.

## 8. Disposition Dataset

### Purpose

The Disposition dataset records the participation status and study completion or discontinuation information for each synthetic participant.

Disposition describes what happened to the participant's participation in the study and is distinct from individual adverse events.

### Record structure

One row = one participant's disposition record.

### Variables

| Variable | Description | Example |
|---|---|---|
| disposition_id | Unique identifier for the disposition record | DS0001 |
| participant_id | Identifier linking the disposition to the participant | SUBJ001 |
| disposition_date | Date on which the disposition occurred | 2026-04-03 |
| disposition_status | Final participation status | COMPLETED |
| reason | Reason for completion or discontinuation | COMPLETED STUDY |

### Controlled values

disposition_status:
- COMPLETED
- DISCONTINUED

Possible discontinuation reasons:
- ADVERSE EVENT
- WITHDRAWAL OF CONSENT
- LOST TO FOLLOW-UP
- LACK OF EFFICACY
- PROTOCOL DEVIATION
- OTHER

### Key rules

- disposition_id must be unique.
- participant_id must correspond to a participant in the Participants dataset.
- Each participant should have a final disposition record.
- A participant with disposition_status = COMPLETED should have reason = COMPLETED STUDY.
- A participant with disposition_status = DISCONTINUED should have a valid discontinuation reason.
- disposition_date must not be earlier than the participant's screening date.