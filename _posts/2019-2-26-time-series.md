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

$$
\hat{X}_{t} = Y_{t}-\hat{m}_{t}
$$

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

The scope of my analysis is to fit a model to the data that visually looks like a good fit. I will use the LOESS method (local polynomial regression). LOESS works by fitting a linear model across a subset of the data around a particular x and then predicting a y value at that x. This is referred to as the $span$ (defined below). It then does the same for all points of the data, with the exception of both endpoints.

$$span = {2q+1}/{n}$$

Although there are many ways of picking a span value such as Cross Validation, for the purposes of this report, I will pick the value of 0.25 after visually analyzing the fit of the model with various spans. Below is a line graph of the original data, with a loess model with a span of 0.25 fit in red. The model looks like a good fit as it stays close to the underlying data, while at the same time doesn't get very jagged. For estimation of values close to the outside the range of the data, this model seems like a good fit.


<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/1.loess_span_0.25_V1.png" alt="Original data with loess span = 0.25"></div><br/>

To get a better idea of whether this model was a good fit, I will analyze the residuals graph (equation shown below) to see if the errors appear to have constant variance and are centered around zero.

$$
 R^2 = 1 - {\sum_{t = 1}^N \Big( Y_{t}-\hat{m}_{t} \Big)^2 \over {\sum_{t = 1}^N \Big( Y_{t}-\overline{Y} \Big)^2}}
$$

From the plot below it looks like the residuals are centered around zero, but there also appears to be a "fanning out" effect for the variance. This leads me to believe that the variance may not be exactly constant, but given the limitations of the scope of this project, this may be the closest estimate.

*Residuals*
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/2.residuals_V1.png" alt="Original data with loess span = 0.25"></div><br/>


One way to test if it's possible to get a better fit for the model is by transforming the underlying data and getting a loess curve to the transformed data. As with picking the value for the span, there are many ways to pick a transformation. In this section I will transform the original data by taking its natural log. In the graph below it looks like the model is a closer fit to the log of the original data, which is a promising result for the transformation. But to be sure, I will also analyze the residuals as well as the R^2 value.


<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/3.log_loess_span_0.25_V1.png" alt="Original data with loess span = 0.25"></div><br/>

*residuals*
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/4.time_series_oil/4.log_residuals_V1.png" alt="Original data with loess span = 0.25"></div><br/>

## Results
