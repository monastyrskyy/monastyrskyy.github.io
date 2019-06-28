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
$$ hat{X}_{t} = Y_{t}-\hat{m}_{t} $$
$$ R^2 = 1 - {\sum_{t = 1}^N \Big( Y_{t}-\hat{m}_{t} \Big)^2 \over {\sum_{t = 1}^N \Big( Y_{t}-\overline{Y} \Big)^2}} $$


Example:
$$
RSS(\beta) = \sum_{j = 1}^N ( \hat{y_j} - y_j)^2
\\
\hat{y_j} = \sum_{i = 1}^M \Big(    B_i * x_{ij} \Big)
\\
\\
\therefore RSS(\beta) = \sum_{j = 1}^N \Big( \sum_{i = 1}^M \Big(    B_i * x_{ij} \Big) - y \Big)^2
$$

## Introduction

## Data Overview
I will only use the first 90% of the data to then test the model on the other 10%.

## Analysis

## Testing the model

## Results
