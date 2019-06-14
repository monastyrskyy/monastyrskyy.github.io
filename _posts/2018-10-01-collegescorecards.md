---
title: "College Scorecard Analysis"
date: 2018-10-01
excerpt: "In this project, I dive into the College Scorecard dataset and examine it for interesting patterns, trends, and insights."
mathjax: "true"
tags: [academic]
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

# College Scorecards Analysis and Report


### Introduction

The U.S. Department of Education provides the College Scorecards Dataset to prospective students and their families to inform them about the educational outcomes and costs of attending various federally funded colleges and universities. The purpose of the data is to facilitate the process of making decisions about which college or university to attend based on several performance indicators, student success measures, and fees related to the school. The data used to create reports on the College Scorecard website (collegescorecard.ed.gov) are a subset of the data universities and colleges report to the Integrated Postsecondary Education Data System (IPEDS).

There are 38,068 rows (observations) in the dataset, representing each college during 5 academic years 2012-2016, inclusive (e.g. Benedict College is featured 5 times, once for each year 2012- 16, inclusive). For year 2012, 7793 colleges were recorded; for year 2013, 7804 colleges were recorded; for year 2014, 7703 colleges were recorded; for year 2015, 7593 colleges are recorded; and for year 2016, 7175 colleges were recorded. The dataset also features 142 columns (variables) such as the name of the university, the location, various SAT/ACT score metrics, etc. that get populated with respective values about each college.

In the dataset, disregarding academic year, the 5 states with the most colleges are California with 3881 colleges, Texas with 2381 colleges, New York with 2317 colleges, Florida with 2176 colleges, and Pennsylvania with 2022 colleges. Similarly, disregarding academic year, the 5 states/territories with the fewest colleges are American Samoa with 5 colleges, Federated States of Micronesia with 5 colleges, Marshall Islands with 5 colleges, Northern Mariana Islands with 5 colleges, and Palau with 5 colleges. When I did this calculation by taking the average amount of colleges per year across the dataset, I got the same results. I also got the same results when I only looked at the most recent year.

I hypothesize that the top 5 states match the top 5 states by population, and similarly the bottom 5 states/territories match the bottom 5 states/territories by population. My hypothesis largely matches reality, with 4 out of 5 most populous states also being in the top 5 by college count ([Pennsylvania is the exception](https://www.census.gov/newsroom/press-releases/2015/cb15-215.html)). The least populated regions in the US are territories, so my hypothesis is supported as well.

### Average Net Price vs Median Earnings 10 Years After Entry

I calculated both of these ranges by finding the minimum and maximum values of each of column separately, and removing all “NA” values. I graphed the values by removing all rows that had “NA” values in either Average Net Price or Median Earnings 10 Years After Entry or both. It’s important to note that the calculated ranges may be broader than what is shown on the graph because the graph excludes more rows than the ranges do.

For public schools in the 2014 academic year (see below), there appears to be a pattern between the average net price of the school and the median earnings 10 years after entry. There appears to be a slight upward trend in the plot, or in other words, a positive correlation. Although we cannot be sure that higher prices *caused* students in those colleges to have higher earnings, we can say that future students should be aware of the relationship because there may be a causal effect. The data is mostly clustered together, with a few outliers, meaning that most students tend to have salaries similar to those of their peers. The range of the average net price is from $-2,434 to $28,201 (the negative values could be errors, or a result of financial aid). The range of median earnings 10 years after entry is $10,800 to $95,600.

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/1.college_scorecards/1.public_price_vs_earnings.png" alt="2014 Public Price vs Earnings"></div><br/>

For private for-Profit schools in the 2014 academic year (see below), there also appears to be a pattern between the average net price of the school and the median earnings 10 years after entry. The range of the average net price is from $-581 to $74,673 (the negative values could be errors, or a result of
financial aid). While the lower bound for the average net price of private for-profit schools was slightly higher than that of public schools, the upper bound was over 2 times higher than that of public schools. The
range of median earnings 10 years after entry is $10,800 to $84,400. This range has the same lower bound as the range for public schools, but the upper bound is $11,200 less than that of public schools. The trend also appears to be upward, slightly more so than the pattern for public schools. Although we cannot be sure that higher prices caused students in those colleges to have higher earnings, we can say that future students should be aware of the relationship because there may be a causal effect. Just like for public schools, the data is mostly clustered together, with a few outliers, meaning that most students tend to have salaries similar to those of their peers.

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/1.college_scorecards/2.private_price_vs_earnings.png" alt="2014 Private Price vs Earnings"></div>
