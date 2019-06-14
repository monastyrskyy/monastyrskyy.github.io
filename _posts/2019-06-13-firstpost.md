---
title: "Proof of Concept: First Post"
date: 2019-06-13
excerpt: "Test post 1st post"
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

# H1 Heading

## H2 Heading

Basic text, *italics*, **bold**, [youtube link](https://youtube.com)

List:
* First
- Second
- Third

1. One
2. Two
3. Three

R code block
```r
x = c(1,2,3)
print(x)
```

Here's some math:

$$z=x+y$$

You can also put it inline $$z=x+y$$

Image:
<img src="{{ site.url }}{{ site.baseurl }}/images/header.jpg" alt="header">
