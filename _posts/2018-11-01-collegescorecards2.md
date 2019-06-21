---
title: "College Scorecard Analysis Part 2"
date: 2018-10-01
excerpt: "In this project, I continue exploring the College Scorecard dataset and examine it for interesting patterns, trends, and insights."
mathjax: "true"
tags: [academic]
classes: wide # frontmatter that should make the page wider.

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

# College Scorecards Analysis and Report Part 2

This report is a continuation of the report titled “College Scorecards Analysis and Report”. In this report I take a deeper dive into the College Scorecards dataset and answer questions about missing data, demographics data, and salary data, among others.

### Missing data

Although there were a lot of missing values in the dataset, there are some variables that had **no missing** values.
  1. id, ope8_id, ope6_id, name, city, state, degrees_awarded.predominant, degrees_awarded.highest, ownership, main_campus, branches, institutional_characteristics.level, zip, and academic_year had no missing values.

Some variables had **all missing** values.
  2. Minority_serving.historically_black, minority_serving.predominantly_black, minority_serving.annh, minority_serving.tribal, minority_serving.aanipi, minority_serving.hispanic, minority_serving.nant, men_only, women_only, operating had all missing values.

*perhaps* the reason these are missing is because all the demographics information is kept in other columns of the data.

Some variables had **mostly missing** values (8,000 to 30,000 missing values).
  3. retention_rate_suppressed.four_year.part_time_pooled, religious_affiliation, act_scores.75th_percentile.writing, act_scores.midpoint.writing, act_scores.25th_percentile.writing, retention_rate_suppressed.lt_four_year.part_time_pooled had mostly missing values.

  These are just a few examples of the many columns that had mostly missing values. From visually observing the columns with many missing values, they tend to sort themselves into several categories: ACT/SAT subsection scores and related columns, cost of attending the school as adjusted by income level, retention information and debt information. Perhaps the reason for all the missing data in the ACT/SAT score category is due to College Board not sharing all the information with universities, only giving them the overall scores rather than breakdowns. Because there are a lot of columns that do
  computation on the test score data, they all have to be missing too.

  The cost of attendance as adjusted by income level may be missing because this is a hard and not objective measure to calculate. Each university may have their own formulas for calculating this value, and many may not even be interested. Also because of the sensitivity of the data, universities may not always share it. Debt information and retention information also has mostly missing values for what I assume is the same reason.

  Misc. “under_investagion”, “school_url”. These are some of the miscellaneous categories that have mostly missing values and aren’t explained by either of the above two reasons. From general experience, I assume that most schools aren’t under investigation and thus probably don’t keep any records about it. School URLs on the other hand, are fairly easy to find online and shouldn’t be hard to include. There are a number of reasons why the values are missing. Perhaps it’s because most schools felt that they didn’t need to include a URL because a simple Google search will suffice. Perhaps when colleges reported their data, they weren’t asked to provide their URL.

Relatively **few missing** values (0 to 8,000 missing values)
  4. demographics.age_entry, default_rate_3_yr, pell_grant_rate, federal_loan_rate, part_time_share, program_percentage.agriculture, program_percentage.resources, program_percentage.architecture

  These missing values sort themselves into categories that most universities would keep records of financial aid information, program percentages, and demographics data. All universities keep records of their financial aid information, so it is expected that there will be relatively few missing values in the columns that are related to financial aid, which is what we see in the data. Universities also keep a close record of the programs that they offer and how many students are enrolled in such programs. We would expect to see no missing values in columns related to university programs, yet we still see some. This is perhaps due to the fact that universities didn’t report anything for programs they don’t offer and they values got marked down as missing, whereas they should have been zeros.

  Almost all university applications prompt the applicants to disclose their demographics information, so we expect to see few missing values in those columns. The potential explanations for missing values in the data is perhaps because a lot of applicants didn’t disclose their demographics data and were marked down as “unknown” and were not reported.

### Student Populations

In order to get an accurate measure of total student populations for each school, I added the “size” and “grad_student” fields together, because the data dictionary defines “size” as the total population of undergrads at each school. The student populations for each year are skewed right and have a median (~450 students) and mean (~2300 students) that are quite low compared to the max value (100,000+ students). Since the data are skewed right, it is important to look at both the mean and the median because the median is more representative of the smaller schools with low enrollment, and the mean is representative of the larger schools. The minimum value for each year is 0, which leads me to believe that it must have been a mistake or the school had zero students in that year. Upon further review, all the colleges that had zero students enrolled are real colleges that usually have very low enrollment (East West College of Natural Medicine, American Conservatory Theater, both with 0 students enrolled). The max value for each year seems to be awfully high as well, but upon further inspection, the schools that tend to be have high enrollment are online schools that don’t have any limitation in terms of capacity like the University of Phoenix – Online Campus (205,286 enrolled).

Overall, the graphs mostly look the same across the years, so it is safe for us to assume that student populations didn’t increase by much, judging both by the mean and the median of each year.


**TABLES GO HERE**

**UNDERGRAD VS GRAD POP** goes Here
To dive a little deeper into the data, we will now explore the relationship between graduate and undergraduate populations at each school. The graph on the left explores the relationship between undergraduate and graduate student populations. It appears that the two measures tend to be positively correlated, or in other words, schools with higher populations of undergraduates tend to have higher populations of graduate students. Overall, there are about 5.5 times more undergraduates than graduate students across all schools and all 5 years 2012-2016. As expected, despite there being more undergraduate students than graduate students on average, there are some schools that are the opposite. Urshan Graduate School of Theology, Charlotte School of Law, Daoist Traditions College of Chinese Medical Arts are some of the schools that have more graduate students than undergraduate students. The trend appears to be that professional and graduate only schools have more graduate students than undergraduate.

### programs

In the dataset, each university reported the percentage of their students that are enrolled each program in the dataset (disregarding NAs). Following this logic, the percentage total for each university should be 1, or 100%, and after checking several random universities, this appears to be true. In order to get the several most and least popular programs, I added up the program_percentage columns across all universities and years. Perhaps this way of calculating the totals is not good for getting an accurate count of students enrolled in each program, but it makes sense to use it just to get the relative size or ranking of the programs by popularity within each university. The top 5 are: Health, Personal Culinary, Business Marketing, Humanities, and Visual and Performing Arts. The 5 least popular ones are: Library (Science), Military (Studies), Science/Technology, Ethnic Cultural Gender (Studies), and Architecture. When I divided the data by year and calculated the most and least popular programs for each year, the same programs were in the top 5 as in the bottom 5, and in the same order.

# Tuitions
**graphs go here, say the line is only for direction of correlation** the assumptions are not met for anything more

To examine the differences in tuition across states, I found the mean tuition of each state, and I graphed it against the average number of colleges per state, on an average year. The plot shows that there is a wide range of mean tuitions, averaging from around $4,000 to $27,627 for in-state tuition per year. There is also a wide range of schools per state, ranging from 1 to 780, on average across the years 2012 to 2016. I chose to take the average of all values relevant to this plot across the years because in previous questions, we established that there is not a big difference in characteristics among the years. The plot above shows that states with slightly higher number of colleges tend to have higher tuitions as well (Adjusted R^2 = 0.07). One possible explanation for this is that a state that supports more schools has more expenses as well such as cost on infrastructure, cost of housing, cost of hiring enough professors and staff, and for this reason, there are higher costs associated with states that have more schools. As with any rule, some exceptions such as Rhode Island (upper left most point on the plot), that only has 26 schools but an average tuition of $27,627. It is possible that the schools in Rhode Island are more expensive because of the circumstances of Rhode Island such as most of the schools being private, less government funding for the education system, etc. The trend for out of state tuition is very similar, with the same positive correlation (Adjusted R^2 = 0.05) for tuition vs. number of colleges, and the same outliers. The range of avg. out of state tuition is slightly wider at $3,610to $30,389. But all in all, the in-state and out-of-state tuition trends are very similar.

### Diversity

The question of diversity is a rather big question to analyze because there are so many ways to define and measure diversity. Many scholars have spent decades researching this topic, and I want to distinguish my work from theirs by saying that my analysis is rather rudimentary and for the sake of the length of report, simple in approach. From experience, when I hear diversity being defined, it is usually defined along racial and ethnic lines, and measured by how much each race makes up the population of each university. I will approach diversity in a similar way – by defining diverse schools as those that are made up of at least 10% each: Black, Asian, and Hispanic.

**Diversity boxplots here**



The above boxplots represent the distributions of the 3 ethnicities across the schools that have at least 10% of each group. The median for the Black population is 17.99%, 14.95% for the Asian population and 24.02% for the Hispanic. The data range from 10.02% across the groups to a biggest max value of 69.81%. The data for each group seems to be fairly spread out, meaning there are schools where each group is a majority of the population and the other two groups still comprise at least 10% each. The middle 50% of the data is the least spread out for the Asian group, with an IQR of only 7.73%, as compared to 15.69% for the Black population, and for 14.99% the Hispanic.

As for the specific universities that comprise this list, there are 150 in total, in 2016. I analyzed the year 2016 because it has proven to be fairly similar to the other years and the average across years on many calculations in the previous questions. For the sake of brevity of this report, here are several examples of such colleges: College of Alameda, American Career College-Los Angeles, Bethesda University, California State University-East Bay, and Sofia University.


### Answering Questions in part 1 (link here)

  1. Is there a relationship between the highest degree awarded and median earnings 10 years after start for each university?

**picture**

I thought asking this question could help a potential student decide what kind of degree he wanted to get in order to secure his future. To help answer this question, I took the average Median Earnings 10 years after Entry across the highest degrees each university offered. The salaries ranged from $24,036 for universities offering Associate’s Degrees as their highest degree to $45,232 for universities offering a Graduate degree as their highest degree. The median for the data is right around $33,516. Of course, it is important to be aware that correlation doesn’t always equal causation, and for this reason, the potential student shouldn’t simply jump at the first opportunity to attend a university offering graduate degrees. There could be confounding variables, like the program itself, the student’s work ethic, and the student’s past academic success, among others. Despite this, the bar graph above should help the potential student, at least start his research into what programs to apply to and give him a data-based foundation of the relationship between earnings and the highest degree offered at a school.

  2. Is there a relationship between the size of the university and faculty salary?

**picture**

In the year 2016, there seems to be a positive correlation between the size of the school and faculty salary. The regression line was added simply to show the positive relationship between the variables, and is not meant to be analyzed further (it may break assumptions). This graph could help students who are looking to become faculty to decide what size of school to apply to based on the salary. The range of the salaries is from $216 (perhaps a stipend) to $27,570, which seems off, but that’s because not every college reported their faculty salaries. The range for the size of the colleges ranges from 0 (small private trade schools) to 100,011. As mentioned above, despite the positive relationship between school size and faculty salary, correlation is not always causation, and select faculty may make more money at a smaller school. This graph is only meant to be a starting point to further research.

The above two questions showed some interesting results and confirmed my existing suspicions. It seems to be fair that students who attend a school with a higher degree than other schools will also earn more money later on. It also seems correct that bigger schools will pay their faculty more because there is more to do, and perhaps more money for the school to spend. As mentioned several times, these graphs that attempt to answer the questions I posed only show correlation, as it is very hard to show causation in an observational study. Correlations are not meaningless however, and they can be great starting points for further exploration, as was my intention.

### Additional Questions

  1. Across all years, what does the gender distribution look like for the universities in the dataset?

**picture**

wanted to explore this question because I was wondering what kind of diversity there was in terms of gender across universities. From this graph, it looks like the percent of females is right around 64% across all school across all years. While this is a simple graph, it accurately portrays percentage as the y-axis ranges from 0 to 1. There also don’t appear to be any changes in the number, nor any spikes or valleys worth exploring.

  2. Is there a difference in Median earnings 10 years after entry for majority female (65%+) and majority male (65%+) schools?

From these two boxplots, comparing the median salaries for colleges that are at least 65% male vs female in size, it looks males have a higher median salary ($38,800 vs $24,800), but the females have a higher maximum value ($186,500 compared to the men’s’ $118,900). The spread looks similar, with the females having a little greater range from $9,100 to $186,500 compared to the men's $9,500 to $118,900. All in all, it would be great to figure out the causes behind these differences and decide a course of action from there.
