---
title: "Podcast Transcription Pipeline and App" 
date: 2024-9-20
excerpt: "A data pipeline for automatically transcribing podcast episdes in German, analysing the data, and designing in a front end App."
mathjax: "true"
tags: [Azure, pipeline, ETL, API, whisper AI, AI, airflow, Funciton App]
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
      comments: true
      share: true
      related: true
---

<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>


{% include video id="J5x5vhn6UUs" provider="youtube" %}
>At 5:50, I say that all files are refreshed. In reality only the ones that have been flagged to be refreshed are refreshed.  
>At 14:15, I say that the model goes through about an hour's worth of content in a few minutes. I am using a model optimized for speed available here: [insanely-fast-whisper](https://github.com/Vaibhavs10/insanely-fast-whisper). The base model is much slower.
