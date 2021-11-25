---
title: Fake News Detection
layout: default
filename: fake-news.md
--- 

# @UC Berkeley: Identifying Fake News By Writing Characteristics

Fake news became a hot topic during the 2016 U.S. presidential election, and continues to be an ever more acute issue as machine learning and social networks continue to evolve and become more ubiquitous. In 2017, my classmate and I were curious to see if there were indicators within an article's writing itself which could indicate whether the content was true or not; if there were indicators, could we reliably and accurately create a Fake News Identification System just on the writing itself? The hypothesis is grounded in the assumption that people have consistent writing styles and a publisher's quality and veracity is somewhat consistent over time (e.g., Tabloids like "National Enquirer" consistently publish sensationalist articles removed from reality).

I like talking about this project because it highlights how important methodology is to exploring and solving a Data Science problem. There are many approaches for this problem, but most of them are infeasible and so charting a good path requires care and is worth the time spent.

First, we take stock of reality:

1. Judging article veracity normally takes a lot of research and doesn't scale, therefore it is unreasonable for us to create our own dataset given limited time and funds
2. Therefore, we need to find labeled datasets and validate quality before modeling (i.e., we don't want "garbage in, garbage out")
3. Lastly, many smart teams and people have likely tried to tackle this and failed, so we need to find out where the state of the art is at and why

We began by looking around (e.g., journals like the ACM) for examples of others who've attempted this problem or similar problems. At the same time, we set out to find labeled datasets indicating article veracity. While searching, it became clear that our biggest problem was getting quality data. We found a few different datasets (e.g., [Kaggle Fake News](https://www.kaggle.com/c/fake-news/data)) but they all appeared heavily biased. For example, the Kaggle dataset's labels appeared inaccurate/unreliable and were algorithmically generated, so any model built upon that dataset would simply inherit its bias.

Luckily, I found some [researchers](http://aclweb.org/anthology/P/P16/P16-1178.pdf) who were tackling a related problem, automatically scoring article writing quality for editorial quality control, and created an expensive and involved dataset of 500+ articles judged by experts (e.g., computational linguists, journalists, etc.) and scored on numerous dimensions (e.g, conciseness). We reached out and they were kind enough to share their data and insights with us. (Note: Data Science is a team game!) Because of this discovery, we decided to proceed with a slightly different approach than previously planned.

Instead of getting data for fake news and working extensively to train a fake news identifier, we decided to first evaluate article editorial scoring model and look for correlations between the writing dimensions scores and article veracity. This would be much more cost-effective and approachable, as we would be testing the validity of the model's underpinning assumptions': how an article is written communicates sufficient information to judge veracity. If there was little to no correlation, then proceeding to model a fake news identifier purely off of writing style may not be feasible or worthwhile.


The modeling effort was done as follows:





kindly shared their data


In this case, we need to first ask ourselves:

* How do we determine truth and veracity?
* How do we collect data and label, if unlabeled, for articles?
* What existing work has been done in this domain and what can we used for our purposes?
* 


[Back](./)
