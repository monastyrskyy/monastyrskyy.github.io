---
title: "Time Series Case Study - Oil Production"
date: 2019-2-26
excerpt: "I analyze some historical oil data using time series methods such as data transformation, loess modeling, polynomial modeling, ACF and PACF analysis, and others."
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
---

<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>

Hello this is a test post, I don't want it to show up yet because it's not done.

Mine:
$$ \hat{X}_{t} = Y_{t}-\hat{m}_{t}
\\
\ R^2 = 1 - {\sum_{t = 1}^N \Big( Y_{t}-\hat{m}_{t} \Big)^2 \over {\sum_{t = 1}^N \Big( Y_{t}-\overline{Y} \Big)^2}} $$


## Introduction
The goal of this project is to serve as a first glance into the world of time series data analysis. I will analyze US oil production across the years and model the data using a loess model. I will then look at the residuals and decide if a transformation of the data is necessary. Upon performing the transformation, I will compare the two models and pick the one that most closely resembles its data.

## Data Overview
The data has two columns: Date, and Prod. Prod is a monthly measurement of the number of barrels of oil that were produced in the US, in thousands of barrels, and Date is the date when the measurement was taken. Below is a snippet of the data.

```text
         Date  Prod
1    Jan-1920  1097
2    Feb-1920  1145
3    Mar-1920  1167
4    Apr-1920  1165
5    May-1920  1181
6    Jun-1920  1222
7    Jul-1920  1218
8    Aug-1920  1255
9    Sep-1920  1251
10   Oct-1920  1277
11   Nov-1920  1287
12   Dec-1920  1257
13   Jan-1921  1230
14   Feb-1921  1269
15   Mar-1921  1326
16   Apr-1921  1341
...
```

## Analysis
**original data**
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/1.loess_span_0.25_V1.png" alt="Original data with loess span = 0.25"></div><br/>

*residuals*
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/2.residuals_V1.png" alt="Original data with loess span = 0.25"></div><br/>


**transformed data with a log**
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/3.log_loess_span_0.25_V1.png" alt="Original data with loess span = 0.25"></div><br/>

*residuals*
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/4.log_residuals_V1.png" alt="Original data with loess span = 0.25"></div><br/>

## Results
