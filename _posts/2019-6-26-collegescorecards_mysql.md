---
title: "College Scorecards Data - Conversion to Relational MySQL Server"
date: 2019-6-26
excerpt: "In this project, I organize the College Scorecards Dataset into a relational database hosted on a MySQL Server. The purpose of this conversion is increased readability, easier permission granting, and to get me familiar with SQL."
mathjax: "true"
tags: [academic]
#classes: wide # frontmatter that should make the page wider.
toc: true
toc_label: "Table of Contents"

defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      read_time: true
      comments: true
      share: true
      related: true

gallery:
  - url: /assets/images/3.college_scorecards_mysql/1.er_diagram_final.jpg
    image_path: /assets/images/3.college_scorecards_mysql/1.er_diagram_final.jpg
    alt: "placeholder image 1"
    title: "Image 1 title caption"
---


**ER Diagram Final**
Small image?
<figure>
  <div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/3.college_scorecards_mysql/1.er_diagram_final.jpg" alt="ER Diagram"></div>
</figure>

Full image?
![try2]({{ site.url }}{{ site.baseurl }}/images/3.college_scorecards_mysql/1.er_diagram_final.jpg)
{: .full}

gallery?

{% include gallery caption="This is a sample gallery with **Markdown support**." %}
**Below is all the code that I used to make the database.**

```text
SHOW DATABASES;

USE college_scorecards;

CREATE TABLE
	parrots ( name text,
	age varchar(12) );

CREATE TABLE college_sample (
	id VARCHAR(12) PRIMARY KEY,
	ope8_id VARCHAR(12),
	ope6_id VARCHAR(6),
	name TEXT,
	city TEXT,
	state CHAR(2),
	school_url TEXT,
	price_calculator_url TEXT,
	under_investigation INT,
	degrees_awarded_predominant TEXT,
	degrees_awarded_highest TEXT,
	demographics_men DECIMAL
);


SELECT * FROM college_sample;

-- This throws an error, but is the way to reach the data
LOAD DATA LOCAL INFILE 'C:/Users/The announcer/Documents/work_files/data_science_portfolio/my_sql/college_scorecards.csv'
INTO TABLE college_sample
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


-- The first sample was successful, so now let's import the whole dataset
CREATE TABLE college_full (
	id VARCHAR(12) PRIMARY KEY,
	name TEXT,
	city TEXT,
	state CHAR(2),
	school_url TEXT,
	price_calculator_url TEXT,
	under_investigation INT,
	degrees_awarded_predominant TEXT,
	degrees_awarded_highest TEXT,
	ownership TEXT,
	locale TEXT,
	religious_affiliation TEXT,
	sat_scores_25th_percentile_critical_reading SMALLINT,
	sat_scores_75th_percentile_critical_reading SMALLINT,
	sat_scores_25th_percentile_math SMALLINT,
	sat_scores_75th_percentile_math SMALLINT,
	sat_scores_25th_percentile_writing SMALLINT,
	sat_scores_75th_percentile_writing	SMALLINT,
	sat_scores_midpoint_critical_reading	SMALLINT,
	sat_scores_midpoint_math	SMALLINT,
	sat_scores_midpoint_writing	SMALLINT,
	act_scores_25th_percentile_cumulative	TINYINT,
	act_scores_75th_percentile_cumulative	TINYINT,
	act_scores_25th_percentile_english	TINYINT,
	act_scores_75th_percentile_english	TINYINT,
	act_scores_25th_percentile_math	TINYINT,
	act_scores_75th_percentile_math	TINYINT,
	act_scores_25th_percentile_writing	TINYINT,
	act_scores_75th_percentile_writing	TINYINT,
	act_scores_midpoint_cumulative	TINYINT,
	act_scores_midpoint_english	TINYINT,
	act_scores_midpoint_math	TINYINT,
	act_scores_midpoint_writing	TINYINT,
	sat_scores_average_overall	SMALLINT,
	sat_scores_average_by_ope_id	SMALLINT,
	program_percentage_agriculture	DECIMAL(5,4),
	program_percentage_resources	DECIMAL(5,4),
	program_percentage_architecture	DECIMAL(5,4),
	program_percentage_ethnic_cultural_gender	DECIMAL(5,4),
	program_percentage_communication	DECIMAL(5,4),
	program_percentage_communications_technology	DECIMAL(5,4),
	program_percentage_computer	DECIMAL(5,4),
	program_percentage_personal_culinary	DECIMAL(5,4),
	program_percentage_education	DECIMAL(5,4),
	program_percentage_engineering	DECIMAL(5,4),
	program_percentage_engineering_technology	DECIMAL(5,4),
	program_percentage_language	DECIMAL(5,4),
	program_percentage_family_consumer_science	DECIMAL(5,4),
	program_percentage_legal	DECIMAL(5,4),
	program_percentage_english	DECIMAL(5,4),
	program_percentage_humanities	DECIMAL(5,4),
	program_percentage_library	DECIMAL(5,4),
	program_percentage_biological	DECIMAL(5,4),
	program_percentage_mathematics	DECIMAL(5,4),
	program_percentage_military	DECIMAL(5,4),
	program_percentage_multidiscipline	DECIMAL(5,4),
	program_percentage_parks_recreation_fitness	DECIMAL(5,4),
	program_percentage_philosophy_religious	DECIMAL(5,4),
	program_percentage_theology_religious_vocation	DECIMAL(5,4),
	program_percentage_physical_science	DECIMAL(5,4),
	program_percentage_science_technology	DECIMAL(5,4),
	program_percentage_psychology	DECIMAL(5,4),
	program_percentage_security_law_enforcement	DECIMAL(5,4),
	program_percentage_public_administration_social_service	DECIMAL(5,4),
	program_percentage_social_science	DECIMAL(5,4),
	program_percentage_construction	DECIMAL(5,4),
	program_percentage_mechanic_repair_technology	DECIMAL(5,4),
	program_percentage_precision_production	DECIMAL(5,4),
	program_percentage_transportation	DECIMAL(5,4),
	program_percentage_visual_performing	DECIMAL(5,4),
	program_percentage_health	DECIMAL(5,4),
	program_percentage_business_marketing	DECIMAL(5,4),
	program_percentage_history	DECIMAL(5,4),
	online_only	VARCHAR(5),
	college_size	INT,
	demographics_race_ethnicity_white	DECIMAL(5,4),
	demographics_race_ethnicity_black	DECIMAL(5,4),
	demographics_race_ethnicity_hispanic	DECIMAL(5,4),
	demographics_race_ethnicity_asian	DECIMAL(5,4),
	demographics_race_ethnicity_aian	DECIMAL(5,4),
	demographics_race_ethnicity_nhpi	DECIMAL(5,4),
	demographics_race_ethnicity_two_or_more	DECIMAL(5,4),
	demographics_race_ethnicity_non_resident_alien	DECIMAL(5,4),
	demographics_race_ethnicity_unknown DECIMAL(5,4),
	part_time_share	DECIMAL(5,4),
	avg_net_price_public INT,
	avg_net_price_private INT,
	net_price_public_by_income_level_0_to_30000	INT,
	net_price_public_by_income_level_30001_to_48000	INT,
	net_price_public_by_income_level_48001_to_75000	INT,
	net_price_public_by_income_level_75001_to_110000	INT,
	net_price_public_by_income_level_110001_to_plus	INT,
	net_price_private_by_income_level_0_to_30000	INT,
	net_price_private_by_income_level_30001_to_48000	INT,
	net_price_private_by_income_level_48001_to_75000	INT,
	net_price_private_by_income_level_75001_to_110000	INT,
	net_price_private_by_income_level_110001_to_plus	INT,
	pell_grant_rate	DECIMAL(5,4),
	federal_loan_rate	DECIMAL(5,4),
	share_25_older	DECIMAL(5,4),
	earn_10_yrs_after_entry_median	INT,
	median_debt_suppressed_completers_overall	DECIMAL(6,1),
	median_debt_suppressed_completers_monthly_payments	DECIMAL(10,5),
	repayment_suppressed_3_yr_overall	DECIMAL(6,5),
	rate_suppressed_lt_four_year_150percent	DECIMAL(5,4),
	rate_suppressed_four_year	DECIMAL(5,4),
	retention_rate_suppressed_four_year_full_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_lt_four_year_full_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_four_year_part_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_lt_four_year_part_time_pooled	DECIMAL(5,4),
	main_campus	VARCHAR(5),
	branches	INT,
	institutional_characteristics_level	TEXT,
	zip	TEXT,
	grad_students	INT,
	tuition_in_state	INT,
	tuition_out_of_state	INT,
	tuition_revenue_per_fte	INT,
	instructional_expenditure_per_fte	INT,
	faculty_salary	INT,
	ft_faculty_rate	DECIMAL(5,4),
	admission_rate_overall	DECIMAL(5,4),
	demographics_median_family_income	DECIMAL(7,1),
	default_rate_3_yr	DECIMAL(5,4),
	demographics_age_entry	DECIMAL(4,2),
	demographics_veteran	DECIMAL(5,4),
	demographics_first_generation	DECIMAL(5,4),
	demographics_men	DECIMAL(5,4),
	demographics_women	DECIMAL(5,4),
	academic_year INT
);


-- Creating the first sub-table - test scores
CREATE TABLE test_scores (
	id VARCHAR(12),
	sat_scores_25th_percentile_critical_reading SMALLINT,
	sat_scores_75th_percentile_critical_reading SMALLINT,
	sat_scores_25th_percentile_math SMALLINT,
	sat_scores_75th_percentile_math SMALLINT,
	sat_scores_25th_percentile_writing SMALLINT,
	sat_scores_75th_percentile_writing	SMALLINT,
	sat_scores_midpoint_critical_reading	SMALLINT,
	sat_scores_midpoint_math	SMALLINT,
	sat_scores_midpoint_writing	SMALLINT,
	act_scores_25th_percentile_cumulative	TINYINT,
	act_scores_75th_percentile_cumulative	TINYINT,
	act_scores_25th_percentile_english	TINYINT,
	act_scores_75th_percentile_english	TINYINT,
	act_scores_25th_percentile_math	TINYINT,
	act_scores_75th_percentile_math	TINYINT,
	act_scores_25th_percentile_writing	TINYINT,
	act_scores_75th_percentile_writing	TINYINT,
	act_scores_midpoint_cumulative	TINYINT,
	act_scores_midpoint_english	TINYINT,
	act_scores_midpoint_math	TINYINT,
	act_scores_midpoint_writing	TINYINT,
	sat_scores_average_overall	SMALLINT,
	sat_scores_average_by_ope_id	SMALLINT
);

INSERT INTO test_scores
SELECT id,
sat_scores_25th_percentile_critical_reading,
sat_scores_75th_percentile_critical_reading,
sat_scores_25th_percentile_math,
sat_scores_75th_percentile_math,
sat_scores_25th_percentile_writing,
sat_scores_75th_percentile_writing,
sat_scores_midpoint_critical_reading,
sat_scores_midpoint_math,
sat_scores_midpoint_writing,
act_scores_25th_percentile_cumulative,
act_scores_75th_percentile_cumulative,
act_scores_25th_percentile_english,
act_scores_75th_percentile_english,
act_scores_25th_percentile_math,
act_scores_75th_percentile_math,
act_scores_25th_percentile_writing,
act_scores_75th_percentile_writing,
act_scores_midpoint_cumulative,
act_scores_midpoint_english,
act_scores_midpoint_math,
act_scores_midpoint_writing,
sat_scores_average_overall,
sat_scores_average_by_ope_id
FROM college_full;

-- Making the id column a foreign key

ALTER TABLE test_scores
ADD CONSTRAINT test_fkey FOREIGN KEY (id) REFERENCES college_small (id);


-- Next table - major percentages
CREATE TABLE major_percentages (
	id VARCHAR(12),
	program_percentage_agriculture	DECIMAL(5,4),
	program_percentage_resources	DECIMAL(5,4),
	program_percentage_architecture	DECIMAL(5,4),
	program_percentage_ethnic_cultural_gender	DECIMAL(5,4),
	program_percentage_communication	DECIMAL(5,4),
	program_percentage_communications_technology	DECIMAL(5,4),
	program_percentage_computer	DECIMAL(5,4),
	program_percentage_personal_culinary	DECIMAL(5,4),
	program_percentage_education	DECIMAL(5,4),
	program_percentage_engineering	DECIMAL(5,4),
	program_percentage_engineering_technology	DECIMAL(5,4),
	program_percentage_language	DECIMAL(5,4),
	program_percentage_family_consumer_science	DECIMAL(5,4),
	program_percentage_legal	DECIMAL(5,4),
	program_percentage_english	DECIMAL(5,4),
	program_percentage_humanities	DECIMAL(5,4),
	program_percentage_library	DECIMAL(5,4),
	program_percentage_biological	DECIMAL(5,4),
	program_percentage_mathematics	DECIMAL(5,4),
	program_percentage_military	DECIMAL(5,4),
	program_percentage_multidiscipline	DECIMAL(5,4),
	program_percentage_parks_recreation_fitness	DECIMAL(5,4),
	program_percentage_philosophy_religious	DECIMAL(5,4),
	program_percentage_theology_religious_vocation	DECIMAL(5,4),
	program_percentage_physical_science	DECIMAL(5,4),
	program_percentage_science_technology	DECIMAL(5,4),
	program_percentage_psychology	DECIMAL(5,4),
	program_percentage_security_law_enforcement	DECIMAL(5,4),
	program_percentage_public_administration_social_service	DECIMAL(5,4),
	program_percentage_social_science	DECIMAL(5,4),
	program_percentage_construction	DECIMAL(5,4),
	program_percentage_mechanic_repair_technology	DECIMAL(5,4),
	program_percentage_precision_production	DECIMAL(5,4),
	program_percentage_transportation	DECIMAL(5,4),
	program_percentage_visual_performing	DECIMAL(5,4),
	program_percentage_health	DECIMAL(5,4),
	program_percentage_business_marketing	DECIMAL(5,4),
	program_percentage_history	DECIMAL(5,4)
);

-- populating the majors table
INSERT INTO major_percentages
SELECT id,
program_percentage_agriculture,
program_percentage_resources	,
program_percentage_architecture	,
program_percentage_ethnic_cultural_gender	,
program_percentage_communication	,
program_percentage_communications_technology	,
program_percentage_computer	,
program_percentage_personal_culinary	,
program_percentage_education	,
program_percentage_engineering	,
program_percentage_engineering_technology	,
program_percentage_language	,
program_percentage_family_consumer_science	,
program_percentage_legal	,
program_percentage_english	,
program_percentage_humanities	,
program_percentage_library	,
program_percentage_biological	,
program_percentage_mathematics	,
program_percentage_military	,
program_percentage_multidiscipline	,
program_percentage_parks_recreation_fitness	,
program_percentage_philosophy_religious	,
program_percentage_theology_religious_vocation	,
program_percentage_physical_science	,
program_percentage_science_technology	,
program_percentage_psychology	,
program_percentage_security_law_enforcement	,
program_percentage_public_administration_social_service	,
program_percentage_social_science	,
program_percentage_construction	,
program_percentage_mechanic_repair_technology	,
program_percentage_precision_production	,
program_percentage_transportation	,
program_percentage_visual_performing	,
program_percentage_health	,
program_percentage_business_marketing	,
program_percentage_history
FROM college_full;

-- Making id the foreign key
ALTER TABLE major_percentages
ADD CONSTRAINT major_fkey FOREIGN KEY (id) REFERENCES college_small (id);

-- Race demographics table
CREATE TABLE demographics (
	id VARCHAR(12),
	demographics_race_ethnicity_white	DECIMAL(5,4),
	demographics_race_ethnicity_black	DECIMAL(5,4),
	demographics_race_ethnicity_hispanic	DECIMAL(5,4),
	demographics_race_ethnicity_asian	DECIMAL(5,4),
	demographics_race_ethnicity_aian	DECIMAL(5,4),
	demographics_race_ethnicity_nhpi	DECIMAL(5,4),
	demographics_race_ethnicity_two_or_more	DECIMAL(5,4),
	demographics_race_ethnicity_non_resident_alien	DECIMAL(5,4),
	demographics_race_ethnicity_unknown DECIMAL(5,4),
	demographics_median_family_income	NUMERIC,
	demographics_age_entry	DECIMAL(4,2),
	demographics_veteran	DECIMAL(5,4),
	demographics_first_generation	DECIMAL(5,4),
	demographics_men	DECIMAL(5,4),
	demographics_women	DECIMAL(5,4)
);

INSERT INTO demographics
SELECT	id ,
	demographics_race_ethnicity_white	,
	demographics_race_ethnicity_black	,
	demographics_race_ethnicity_hispanic	,
	demographics_race_ethnicity_asian	,
	demographics_race_ethnicity_aian	,
	demographics_race_ethnicity_nhpi	,
	demographics_race_ethnicity_two_or_more	,
	demographics_race_ethnicity_non_resident_alien	,
	demographics_race_ethnicity_unknown,
	demographics_median_family_income	,
	demographics_age_entry	,
	demographics_veteran	,
	demographics_first_generation	,
	demographics_men	,
	demographics_women
FROM college_full;

-- Making id the foreign key
ALTER TABLE demographics
ADD CONSTRAINT demographics_fkey FOREIGN KEY (id) REFERENCES college_small (id);

-- Making price table

CREATE TABLE net_price (
	id VARCHAR(12),
	avg_net_price_public INT,
	avg_net_price_private INT,
	net_price_public_by_income_level_0_to_30000	INT,
	net_price_public_by_income_level_30001_to_48000	INT,
	net_price_public_by_income_level_48001_to_75000	INT,
	net_price_public_by_income_level_75001_to_110000	INT,
	net_price_public_by_income_level_110001_to_plus	INT,
	net_price_private_by_income_level_0_to_30000	INT,
	net_price_private_by_income_level_30001_to_48000	INT,
	net_price_private_by_income_level_48001_to_75000	INT,
	net_price_private_by_income_level_75001_to_110000	INT,
	net_price_private_by_income_level_110001_to_plus	INT
);

INSERT INTO net_price
SELECT id,
	avg_net_price_public,
	avg_net_price_private,
	net_price_public_by_income_level_0_to_30000,
	net_price_public_by_income_level_30001_to_48000,
	net_price_public_by_income_level_48001_to_75000,
	net_price_public_by_income_level_75001_to_110000,
	net_price_public_by_income_level_110001_to_plus,
	net_price_private_by_income_level_0_to_30000,
	net_price_private_by_income_level_30001_to_48000,
	net_price_private_by_income_level_48001_to_75000,
	net_price_private_by_income_level_75001_to_110000,
	net_price_private_by_income_level_110001_to_plus
FROM college_full;

-- Making id the foreign key
ALTER TABLE net_price
ADD CONSTRAINT price_fkey FOREIGN KEY (id) REFERENCES college_small (id);

-- Making shorter college table
CREATE TABLE college_small (
	id VARCHAR(12) PRIMARY KEY,
	name TEXT,
	city TEXT,
	state CHAR(2),
	school_url TEXT,
	price_calculator_url TEXT,
	under_investigation INT,
	degrees_awarded_predominant TEXT,
	degrees_awarded_highest TEXT,
	ownership TEXT,
	locale TEXT,
	religious_affiliation TEXT,
	sat_scores_25th_percentile_critical_reading SMALLINT,
	sat_scores_75th_percentile_critical_reading SMALLINT,
	sat_scores_25th_percentile_math SMALLINT,
	sat_scores_75th_percentile_math SMALLINT,
	sat_scores_25th_percentile_writing SMALLINT,
	sat_scores_75th_percentile_writing	SMALLINT,
	sat_scores_midpoint_critical_reading	SMALLINT,
	sat_scores_midpoint_math	SMALLINT,
	sat_scores_midpoint_writing	SMALLINT,
	act_scores_25th_percentile_cumulative	TINYINT,
	act_scores_75th_percentile_cumulative	TINYINT,
	act_scores_25th_percentile_english	TINYINT,
	act_scores_75th_percentile_english	TINYINT,
	act_scores_25th_percentile_math	TINYINT,
	act_scores_75th_percentile_math	TINYINT,
	act_scores_25th_percentile_writing	TINYINT,
	act_scores_75th_percentile_writing	TINYINT,
	act_scores_midpoint_cumulative	TINYINT,
	act_scores_midpoint_english	TINYINT,
	act_scores_midpoint_math	TINYINT,
	act_scores_midpoint_writing	TINYINT,
	sat_scores_average_overall	SMALLINT,
	sat_scores_average_by_ope_id	SMALLINT,
	program_percentage_agriculture	DECIMAL(5,4),
	program_percentage_resources	DECIMAL(5,4),
	program_percentage_architecture	DECIMAL(5,4),
	program_percentage_ethnic_cultural_gender	DECIMAL(5,4),
	program_percentage_communication	DECIMAL(5,4),
	program_percentage_communications_technology	DECIMAL(5,4),
	program_percentage_computer	DECIMAL(5,4),
	program_percentage_personal_culinary	DECIMAL(5,4),
	program_percentage_education	DECIMAL(5,4),
	program_percentage_engineering	DECIMAL(5,4),
	program_percentage_engineering_technology	DECIMAL(5,4),
	program_percentage_language	DECIMAL(5,4),
	program_percentage_family_consumer_science	DECIMAL(5,4),
	program_percentage_legal	DECIMAL(5,4),
	program_percentage_english	DECIMAL(5,4),
	program_percentage_humanities	DECIMAL(5,4),
	program_percentage_library	DECIMAL(5,4),
	program_percentage_biological	DECIMAL(5,4),
	program_percentage_mathematics	DECIMAL(5,4),
	program_percentage_military	DECIMAL(5,4),
	program_percentage_multidiscipline	DECIMAL(5,4),
	program_percentage_parks_recreation_fitness	DECIMAL(5,4),
	program_percentage_philosophy_religious	DECIMAL(5,4),
	program_percentage_theology_religious_vocation	DECIMAL(5,4),
	program_percentage_physical_science	DECIMAL(5,4),
	program_percentage_science_technology	DECIMAL(5,4),
	program_percentage_psychology	DECIMAL(5,4),
	program_percentage_security_law_enforcement	DECIMAL(5,4),
	program_percentage_public_administration_social_service	DECIMAL(5,4),
	program_percentage_social_science	DECIMAL(5,4),
	program_percentage_construction	DECIMAL(5,4),
	program_percentage_mechanic_repair_technology	DECIMAL(5,4),
	program_percentage_precision_production	DECIMAL(5,4),
	program_percentage_transportation	DECIMAL(5,4),
	program_percentage_visual_performing	DECIMAL(5,4),
	program_percentage_health	DECIMAL(5,4),
	program_percentage_business_marketing	DECIMAL(5,4),
	program_percentage_history	DECIMAL(5,4),
	online_only	VARCHAR(5),
	college_size	INT,
	demographics_race_ethnicity_white	DECIMAL(5,4),
	demographics_race_ethnicity_black	DECIMAL(5,4),
	demographics_race_ethnicity_hispanic	DECIMAL(5,4),
	demographics_race_ethnicity_asian	DECIMAL(5,4),
	demographics_race_ethnicity_aian	DECIMAL(5,4),
	demographics_race_ethnicity_nhpi	DECIMAL(5,4),
	demographics_race_ethnicity_two_or_more	DECIMAL(5,4),
	demographics_race_ethnicity_non_resident_alien	DECIMAL(5,4),
	demographics_race_ethnicity_unknown DECIMAL(5,4),
	part_time_share	DECIMAL(5,4),
	avg_net_price_public INT,
	avg_net_price_private INT,
	net_price_public_by_income_level_0_to_30000	INT,
	net_price_public_by_income_level_30001_to_48000	INT,
	net_price_public_by_income_level_48001_to_75000	INT,
	net_price_public_by_income_level_75001_to_110000	INT,
	net_price_public_by_income_level_110001_to_plus	INT,
	net_price_private_by_income_level_0_to_30000	INT,
	net_price_private_by_income_level_30001_to_48000	INT,
	net_price_private_by_income_level_48001_to_75000	INT,
	net_price_private_by_income_level_75001_to_110000	INT,
	net_price_private_by_income_level_110001_to_plus	INT,
	pell_grant_rate	DECIMAL(5,4),
	federal_loan_rate	DECIMAL(5,4),
	share_25_older	DECIMAL(5,4),
	earn_10_yrs_after_entry_median	INT,
	median_debt_suppressed_completers_overall	DECIMAL(6,1),
	median_debt_suppressed_completers_monthly_payments	DECIMAL(10,5),
	repayment_suppressed_3_yr_overall	DECIMAL(6,5),
	rate_suppressed_lt_four_year_150percent	DECIMAL(5,4),
	rate_suppressed_four_year	DECIMAL(5,4),
	retention_rate_suppressed_four_year_full_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_lt_four_year_full_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_four_year_part_time_pooled	DECIMAL(5,4),
	retention_rate_suppressed_lt_four_year_part_time_pooled	DECIMAL(5,4),
	main_campus	VARCHAR(5),
	branches	INT,
	institutional_characteristics_level	TEXT,
	zip	TEXT,
	grad_students	INT,
	tuition_in_state	INT,
	tuition_out_of_state	INT,
	tuition_revenue_per_fte	INT,
	instructional_expenditure_per_fte	INT,
	faculty_salary	INT,
	ft_faculty_rate	DECIMAL(5,4),
	admission_rate_overall	DECIMAL(5,4),
	demographics_median_family_income	DECIMAL(7,1),
	default_rate_3_yr	DECIMAL(5,4),
	demographics_age_entry	DECIMAL(4,2),
	demographics_veteran	DECIMAL(5,4),
	demographics_first_generation	DECIMAL(5,4),
	demographics_men	DECIMAL(5,4),
	demographics_women	DECIMAL(5,4),
	academic_year INT
);


-- Trying to copy the college_full table into another table and delete all columns that are in the specific tables.
-- Dropping demographics
ALTER TABLE college_small
DROP demographics_veteran, DROP demographics_first_generation, DROP demographics_men, DROP demographics_women;

ALTER TABLE college_small
DROP demographics_median_family_income;

ALTER TABLE college_small
DROP 	demographics_race_ethnicity_white,
DROP 	demographics_race_ethnicity_black,
DROP 	demographics_race_ethnicity_hispanic,
DROP 	demographics_race_ethnicity_asian,
DROP 	demographics_race_ethnicity_aian,
DROP 	demographics_race_ethnicity_nhpi,
DROP 	demographics_race_ethnicity_two_or_more,
DROP 	demographics_race_ethnicity_non_resident_alien,
DROP 	demographics_race_ethnicity_unknown;


-- Dropping tests

ALTER TABLE college_small
DROP 	sat_scores_25th_percentile_critical_reading,
DROP 	sat_scores_75th_percentile_critical_reading,
DROP 	sat_scores_25th_percentile_math,
DROP 	sat_scores_75th_percentile_math,
DROP 	sat_scores_25th_percentile_writing,
DROP 	sat_scores_75th_percentile_writing,
DROP 	sat_scores_midpoint_critical_reading,
DROP 	sat_scores_midpoint_math,
DROP 	sat_scores_midpoint_writing,
DROP 	act_scores_25th_percentile_cumulative,
DROP 	act_scores_75th_percentile_cumulative,
DROP 	act_scores_25th_percentile_english,
DROP 	act_scores_75th_percentile_english,
DROP	act_scores_25th_percentile_math,
DROP 	act_scores_75th_percentile_math,
DROP 	act_scores_25th_percentile_writing,
DROP 	act_scores_75th_percentile_writing,
DROP 	act_scores_midpoint_cumulative,
DROP 	act_scores_midpoint_english,
DROP 	act_scores_midpoint_math,
DROP 	act_scores_midpoint_writing,
DROP 	sat_scores_average_overall,
DROP 	sat_scores_average_by_ope_id;



-- Dropping program percecntages
ALTER TABLE college_small
DROP 	program_percentage_agriculture,
DROP	program_percentage_resources,
DROP	program_percentage_architecture,
DROP	program_percentage_ethnic_cultural_gender,
DROP	program_percentage_communication,
DROP	program_percentage_communications_technology,
DROP	program_percentage_computer,
DROP	program_percentage_personal_culinary,
DROP	program_percentage_education,
DROP	program_percentage_engineering,
DROP	program_percentage_engineering_technology,
DROP	program_percentage_language,
DROP	program_percentage_family_consumer_science,
DROP	program_percentage_legal,
DROP	program_percentage_english,
DROP	program_percentage_humanities,
DROP	program_percentage_library,
DROP	program_percentage_biological,
DROP	program_percentage_mathematics,
DROP	program_percentage_military,
DROP	program_percentage_multidiscipline,
DROP	program_percentage_parks_recreation_fitness,
DROP	program_percentage_philosophy_religious,
DROP	program_percentage_theology_religious_vocation,
DROP	program_percentage_physical_science,
DROP	program_percentage_science_technology,
DROP	program_percentage_psychology,
DROP	program_percentage_security_law_enforcement,
DROP	program_percentage_public_administration_social_service,
DROP	program_percentage_social_science,
DROP	program_percentage_construction,
DROP	program_percentage_mechanic_repair_technology,
DROP	program_percentage_precision_production,
DROP	program_percentage_transportation,
DROP	program_percentage_visual_performing,
DROP	program_percentage_health,
DROP	program_percentage_business_marketing,
DROP	program_percentage_history;


-- Dropping net prices
ALTER TABLE college_small
DROP 	avg_net_price_public,
DROP 	avg_net_price_private,
DROP 	net_price_public_by_income_level_0_to_30000,
DROP 	net_price_public_by_income_level_30001_to_48000,
DROP 	net_price_public_by_income_level_48001_to_75000,
DROP 	net_price_public_by_income_level_75001_to_110000,
DROP 	net_price_public_by_income_level_110001_to_plus,
DROP 	net_price_private_by_income_level_0_to_30000,
DROP 	net_price_private_by_income_level_30001_to_48000,
DROP 	net_price_private_by_income_level_48001_to_75000,
DROP 	net_price_private_by_income_level_75001_to_110000,
DROP 	net_price_private_by_income_level_110001_to_plus;


```
