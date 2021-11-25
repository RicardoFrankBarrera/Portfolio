---
title: Optimizing Storage Compression Policies
layout: default
filename: compression.md
--- 

# @Microsoft: Optimizing Cosmos Store's Storage Compression Policies

## Business Context

After my success with the [Markov Model](./markov-model.html), I became the go-to mathematician on the team and was subsequently tasked with optimizing storage compression policies for [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). This project was much simpler at face value than my Markov Model. Surprisingly, it turned out to be rather simple in the end, but could've been quite complicated had circumstances been different. Let me elaborate.

## Identifying Constraints and Defining Analytic Framework

A data-center has resources (e.g., storage, computation, network, etc.) but these resources are not independent when executing tasks. If I'm writing data to a distributed storage system, I'm consuming a bit of every resource along the way: disk space to store files, memory to store data sent over the network, network to transfer data, and compute to orchestrate and execute everything. Thus, I needed to make sure we didn't use too much computation for the extra storage savings because different compression algorithms consume different amounts of CPU to compress the same piece of data. 

Also, there are tradeoffs to be made for optimization and manageability given the system design. In our case, compression policies were managed in configuration files controlled by engineers, so it wasn't wise to try to squeeze out extra savings at the risk of making the configuration process overly complicated. To keep things simple, we decided to have just two compression levels at any time: one default compression used immediately upon write, and other used for long-term storage after some time has passed (e.g., 6 months) when we knew short-lived data was likely deleted and the CPU cost to recompress wouldn't go to waste.

Evaluating the compression gains for different policies requires some care because different datasets have different compressibility, and I needed to estimate compression gains for an Exabyte of data for different policies without compressing an Exabyte of data. This was done by intelligently identifying and sampling key datasets that consumed the majority of the storage space in the data centers.

## Data Exploration and Analysis

Some data exploration highlighted that Pareto's 80/20 principle applied to our data, where the vast majority of the storage space was consumed by a small subset of all datasets. This meant that sampling these key datasets and learning their characteristics (e.g., retention policies, compressibility, etc.) would allow me to accurately predict overall compression gains from a small subset of samples.

The rest of the project was rather straightforward: 

1. gather compression statistics for key datasets (% compression, CPU time per GB compressed), 
2. use hypothesis testing to confirm each dataset's compression statistics are relatively consistent month-to-month, 
3. estimate compression gains given different policies across all key datasets,
4. identify the most cost-efficient compression algorithm,
5. slowly roll-out the best policy per data center to make sure unforeseen issues don't arise

![Compression](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/04%20Optimize%20Data%20Compression%20Policies.jpg?raw=true)

## Closing Thoughts

The effort and time involved in the project was small given the amount of cost-savings to the business. The key takeaway is optimizing small parts of a system operating at scale is worthwhile.

[Back](./)