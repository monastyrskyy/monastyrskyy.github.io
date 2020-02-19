---
title: "College Scorecards Data - Part 3 - Conversion to Relational Database"
date: 2019-6-26
excerpt: "In this project, I organize the College Scorecards Dataset into a relational database hosted on a MySQL Server. The purpose of this conversion is increased readability, easier permission granting, and to get me familiar with SQL."
mathjax: "true"
tags: [academic, sql]
#classes: wide # frontmatter that should make the page wider.
toc: true
toc_sticky: true
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
---
## Introduction

In this project, I organize the College Scorecards Dataset into a relational database hosted on a MySQL Server. The purpose of this conversion is increased readability, easier permission granting, easier data downloading, and getting familiar with SQL.

## Data Overview

The U.S. Department of Education provides the College Scorecards Dataset to prospective students and their families to inform them about the educational outcomes and costs of attending various federally funded colleges and universities. The purpose of the data is to facilitate the process of making decisions about which college or university to attend based on several performance indicators, student success measures, and fees related to the school. The data used to create reports on the <a href="https://collegescorecard.ed.gov/" target="blank">College Scorecard website</a> are a subset of the data universities and colleges report to the Integrated Postsecondary Education Data System (<a href="https://nces.ed.gov/ipeds/" target="blank">IPEDS</a>).

There are 38,068 rows (observations) in the dataset, representing each college during 5 academic years 2012-2016, inclusive (e.g. Benedict College is featured 5 times, once for each year 2012- 16, inclusive). For year 2012, 7793 colleges were recorded; for year 2013, 7804 colleges were recorded; for year 2014, 7703 colleges were recorded; for year 2015, 7593 colleges are recorded; and for year 2016, 7175 colleges were recorded. The dataset also features 142 columns (variables) such as the name of the university, the location, various SAT/ACT score metrics, etc. that get populated with respective values about each college.

**Info Notice:** Note, the original dataset had a unique ID for each college. This meant that there were usually around four entries with identical ID's, one for each year. To fix this, I combined the original ID with the year column, which produced a new ID that is now unique for every entry. This, in addition to removing some redundant columns such as "ope8_id" and "ope6_id", were the only changes I made to the original dataset before uploading it to the mySQL server.
{: .notice--info}

**List of Variables in College Scorecards**

```text
"id"                                                      "ope8_id"                                                
"ope6_id"                                                 "name"                                                   
"city"                                                    "state"                                                  
"school_url"                                              "price_calculator_url"                                   
"under_investigation"                                     "degrees_awarded.predominant"                            
"degrees_awarded.highest"                                 "ownership"                                              
"locale"                                                  "minority_serving.historically_black"                    
"minority_serving.predominantly_black"                    "minority_serving.annh"                                  
"minority_serving.tribal"                                 "minority_serving.aanipi"                                
"minority_serving.hispanic"                               "minority_serving.nant"                                  
"men_only"                                                "women_only"                                             
"religious_affiliation"                                   "sat_scores.25th_percentile.critical_reading"            
"sat_scores.75th_percentile.critical_reading"             "sat_scores.25th_percentile.math"                        
"sat_scores.75th_percentile.math"                         "sat_scores.25th_percentile.writing"                     
"sat_scores.75th_percentile.writing"                      "sat_scores.midpoint.critical_reading"                   
"sat_scores.midpoint.math"                                "sat_scores.midpoint.writing"                            
"act_scores.25th_percentile.cumulative"                   "act_scores.75th_percentile.cumulative"                  
"act_scores.25th_percentile.english"                      "act_scores.75th_percentile.english"                     
"act_scores.25th_percentile.math"                         "act_scores.75th_percentile.math"                        
"act_scores.25th_percentile.writing"                      "act_scores.75th_percentile.writing"                     
"act_scores.midpoint.cumulative"                          "act_scores.midpoint.english"                            
"act_scores.midpoint.math"                                "act_scores.midpoint.writing"                            
"sat_scores.average.overall"                              "sat_scores.average.by_ope_id"                           
"program_percentage.agriculture"                          "program_percentage.resources"                           
"program_percentage.architecture"                         "program_percentage.ethnic_cultural_gender"              
"program_percentage.communication"                        "program_percentage.communications_technology"           
"program_percentage.computer"                             "program_percentage.personal_culinary"                   
"program_percentage.education"                            "program_percentage.engineering"                         
"program_percentage.engineering_technology"               "program_percentage.language"                            
"program_percentage.family_consumer_science"              "program_percentage.legal"                               
"program_percentage.english"                              "program_percentage.humanities"                          
"program_percentage.library"                              "program_percentage.biological"                          
"program_percentage.mathematics"                          "program_percentage.military"                            
"program_percentage.multidiscipline"                      "program_percentage.parks_recreation_fitness"            
"program_percentage.philosophy_religious"                 "program_percentage.theology_religious_vocation"         
"program_percentage.physical_science"                     "program_percentage.science_technology"                  
"program_percentage.psychology"                           "program_percentage.security_law_enforcement"            
"program_percentage.public_administration_social_service" "program_percentage.social_science"                      
"program_percentage.construction"                         "program_percentage.mechanic_repair_technology"          
"program_percentage.precision_production"                 "program_percentage.transportation"                      
"program_percentage.visual_performing"                    "program_percentage.health"                              
"program_percentage.business_marketing"                   "program_percentage.history"                             
"online_only"                                             "size"                                                   
"demographics.race_ethnicity.white"                       "demographics.race_ethnicity.black"                      
"demographics.race_ethnicity.hispanic"                    "demographics.race_ethnicity.asian"                      
"demographics.race_ethnicity.aian"                        "demographics.race_ethnicity.nhpi"                       
"demographics.race_ethnicity.two_or_more"                 "demographics.race_ethnicity.non_resident_alien"         
"demographics.race_ethnicity.unknown"                     "part_time_share"                                        
"operating"                                               "avg_net_price.public"                                   
"avg_net_price.private"                                   "net_price.public.by_income_level.0-30000"               
"net_price.public.by_income_level.30001-48000"            "net_price.public.by_income_level.48001-75000"           
"net_price.public.by_income_level.75001-110000"           "net_price.public.by_income_level.110001-plus"           
"net_price.private.by_income_level.0-30000"               "net_price.private.by_income_level.30001-48000"          
"net_price.private.by_income_level.48001-75000"           "net_price.private.by_income_level.75001-110000"         
"net_price.private.by_income_level.110001-plus"           "pell_grant_rate"                                        
"federal_loan_rate"                                       "share_25_older"                                         
"earn_10_yrs_after_entry.median"                          "median_debt_suppressed.completers.overall"              
"median_debt_suppressed.completers.monthly_payments"      "repayment_suppressed_3_yr.overall"                      
"rate_suppressed.lt_four_year_150percent"                 "rate_suppressed.four_year"                              
"retention_rate_suppressed.four_year.full_time_pooled"    "retention_rate_suppressed.lt_four_year.full_time_pooled"
"retention_rate_suppressed.four_year.part_time_pooled"    "retention_rate_suppressed.lt_four_year.part_time_pooled"
"main_campus"                                             "branches"                                               
"institutional_characteristics.level"                     "zip"                                                    
"grad_students"                                           "tuition.in_state"                                       
"tuition.out_of_state"                                    "tuition_revenue_per_fte"                                
"instructional_expenditure_per_fte"                       "faculty_salary"                                         
"ft_faculty_rate"                                         "admission_rate.overall"                                 
"demographics.median_family_income"                       "default_rate_3_yr"                                      
"demographics.age_entry"                                  "demographics.veteran"                                   
"demographics.first_generation"                           "demographics.men"                                       
"demographics.women"                                      "academic_year"  
```




## Data Onboarding
In this section, I go into the process and code behind creating a relational database using the CollegeScorcards dataset. The goal of this section is to further explain the benefits of a relational database as well as show step by step how I made mine.

First, I imported the full original dataset. SQL requires you to create a table which then is populated by the data.

```text
-- Importing the full dataset into mySQL database
-- Creating a table to contain the data, specifying the name and datatype of the column
CREATE TABLE college_full (
	id VARCHAR(12) PRIMARY KEY,
	name TEXT,
	city TEXT,
	state CHAR(2),
	school_url TEXT,
	price_calculator_url TEXT,
	under_investigation INT,
	degrees_awarded_predominant TEXT,
  .
  .
  .
	default_rate_3_yr	DECIMAL(5,4),
	demographics_age_entry	DECIMAL(4,2),
	demographics_veteran	DECIMAL(5,4),
	demographics_first_generation	DECIMAL(5,4),
	demographics_men	DECIMAL(5,4),
	demographics_women	DECIMAL(5,4),
	academic_year INT
);

-- Populating the table above
LOAD DATA LOCAL INFILE 'C:/.../college_scorecards.csv'
INTO TABLE college_full
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
```

I then created sub-tables, each with a common theme. Luckily, the dataset has several groups of variables that share a common theme. I will use this to my advantage and divide up the data according to theme.

|Variable themes|
---|---|
1.|identifying information|
2.|test scores|
3.|program percentages|
4.|demographics|
5.|net price|

<br><br/>

**First sub-table: test scores**

```text
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
.
.
.
act_scores_midpoint_math,
act_scores_midpoint_writing,
sat_scores_average_overall,
sat_scores_average_by_ope_id
FROM college_full;

-- Making the id column a foreign key
ALTER TABLE test_scores
ADD CONSTRAINT test_fkey FOREIGN KEY (id) REFERENCES college_small (id);
```
**Info Notice:** All references to "college_small", such as the one above, will be explained later in the report.
{: .notice--info}
<br><br/>

**Second sub-table: program percentages**

```text
-- Next table - program percentages
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
.
.
.
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
```

<br><br/>

**Third sub-table: demographics**

```text
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
```

<br><br/>

**Fourth sub-table: net_price**

```text
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
```

<br><br/>

With all the tables created and populated, I will create a main table ("college_small") to which all the sub-tables connect through a foreign key. This table will have all the misc. identifying information for each college. To make this table, I will first copy college_full and then drop all the columns that exist in one of the sub-tables.

```text
-- I copied college_full and named the copy college_small
-- Below I drop all the variables that are available in the sub-tables.

-- Dropping demographics
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
DROP  demographics_median_family_income;
DROP  demographics_veteran,
DROP  demographics_first_generation,
DROP  demographics_men,
DROP  demographics_women;


-- Dropping tests
ALTER TABLE college_small
DROP 	sat_scores_25th_percentile_critical_reading,
DROP 	sat_scores_75th_percentile_critical_reading,
DROP 	sat_scores_25th_percentile_math,
DROP 	sat_scores_75th_percentile_math,
DROP 	sat_scores_25th_percentile_writing,
DROP 	sat_scores_75th_percentile_writing,
.
.
.
DROP 	act_scores_midpoint_english,
DROP 	act_scores_midpoint_math,
DROP 	act_scores_midpoint_writing,
DROP 	sat_scores_average_overall,
DROP 	sat_scores_average_by_ope_id;



-- Dropping program percentages
ALTER TABLE college_small
DROP 	program_percentage_agriculture,
DROP	program_percentage_resources,
DROP	program_percentage_architecture,
DROP	program_percentage_ethnic_cultural_gender,
DROP	program_percentage_communication,
DROP	program_percentage_communications_technology,
.
.
.
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

## Results
After going through with the data onboarding process outlined above, I get a relational database consisting of five tables, each with its own theme, all connected to one another by the ID foreign/primary key. Below is the final ER model of the database produced with the code outlined above. It's much more compact, easy to understand, easy to manage, and organized in a way that allows for easier data access management.

**Final ER Diagram**

![try2]({{ site.url }}{{ site.baseurl }}/images/3.college_scorecards_mysql/1.er_diagram_final.jpg)
{: .full}


## Conclusion
One benefit of storing data like this is that it's easier to manage permissions for pulling data. For example, if an employee only has permission to view test score data, it will be much easier to give him access with a relational database than with a flat csv file. Another benefit to a relational database is it's more well organized. For example, if I'm doing analysis only on tuition data, I don't need access to all the other data tables. A relational database makes this option very easy to manage, without sacrificing your ability to pull other data if needed. All in all, for larger datasets and for working on a team with various levels of data permissions, a relational database proves to be a much better option over a flat .csv file.
