---
title: "Real Estate Predictions - Kaggle"
date: 2019-7-12
excerpt: "In this project I take a dive into real estate data to predict housing prices using machine learning techniques such as random forests, XGBoost, as well as parameter tuning, linear regression, and more."
mathjax: "true"
tags: [kaggle, r, machine learning]
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

**Think about dividing this up into several posts and have one single one at the end that summarizes and references each part of this post.**

## Introduction
In this project I take a dive into real estate data with the (House Prices: Advanced Regression Techniques)[https://www.kaggle.com/c/house-prices-advanced-regression-techniques] competition on Kaggle. This competition serves as a first step for beginners to "get their feet wet" with advanced regression and machine learning by predicting real estate prices based on a combination of qualitative and quantitative predictors.

As a machine learning novice, I thought this would be a great project to take on and learn more about linear regression, generalized linear modeling, random forests, parameter tuning, data imputation, and multicollinearity through R packages such as caret, xgboost, mice, randomForest, and others.

## Data Overview

## Data Wrangling

## Modeling

### No Imputation
### LM
### GLM
### GLMNet

### Imputation
### LotFrontage imputed with mice

### Changed all factors into numeric dummy variables

## Random Forest

## Taking out multicollinearity with value above 0.75

## XGBoost
  great, probably reached a local maximum


## Conclusion

## Further Steps
As mentioned before, I think the reason why a more tuned XGBoost model did not yield as good results as the model with default parameters is because of my process of selecting parameters. My process was as follows:
  1. Fit a model with arbitrary parameter ranges around the defaults.
  2. If the fitted model picks a boundary value from the parameter range (e.g. range = (1,7) and model picks 7), move the new parameter range to fit 7 inside (e.g. new range = (6, 10)). This would allow me to see if 7 was the best possible value given the original range, or if it was the best possible value regardless of range.
  3. Repeat this process for every parameter.

Although this may seem like a reasonable approach at first, there are two sources that may introduce error. The first is that I originally picked arbitrary parameter ranges. The issue with doing this is that it's possible to be optimizing the model to a local maximum instead of the absolute maximum. In other words, steps 2 and 3 may actually be improving the model, but because of the initial placement of parameter ranges, it's not optimizing the model as much as it could. See the graphic below for a visual representation of this idea.

*Tableau visualization of the concept above*

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/5.kaggle_real_estate/1.parameter_tuning_fallacy.png" alt="Local Maximum Fallacy"></div><br/>

**revise this**
The second source of error arises because I optimized for one parameter at a time, while thinking I was optimizing them all. To explain this further, I optimized parameter X, given parameter Y and Z stayed the same, while the problem was to optimize them all to get the most optimal model. I then optimized parameter Y, given parameter X and Z stayed the same, and then parameter Z, given X and Y stayed the same. Because the initial parameter values were arbitrarily chosen, we have no confidence, that they will yield the best possible results. This doesn't necessarily produce the optimal solution to the combination of the parameters, but rather a single parameter, given that all others stay the same.

One solution for this is to randomly choose a set amount of parameter combination which, with enough random parameter values, would get rid of the issue of optimizing for a local maximum, as the visualization below shows. We could then use this information to hone in on the parameters that produce the best results, and make more guesses around them. To get rid of the second source of error, we could optimize for all the parameters at the same time. This would be more computationally expensive, but it would guard us against optimizing for one parameter, given that all the others stay the same.

*Tableau visualization of the concept above*

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/5.kaggle_real_estate/2.random_initial_guesses.png" alt="Random Guesses to get rid of Local Maximum Fallacy"></div><br/>

do more parameter tuning with a random grid, and then finetuning from there.
## model ensembling
