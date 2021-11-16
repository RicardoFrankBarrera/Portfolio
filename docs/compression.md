---
title: Optimizing Storage Compression Policies
layout: default
filename: compression.md
--- 

#### @Microsoft: Optimizing Cosmos Store's Storage Compression Policies

After my success with the Markov Model, I became the go-to mathematician on the team and was subsequently tasked with optimizing storage compression policies for [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). This project was much simpler at face value than my Markov Model. Surprisingly, it turned out to be rather simple in the end, but could've been quite complicated hard circumstances been different. Let me elaborate.

A data-center has resources (e.g., storage, computation, network, etc.) but these resources are not independent when executing tasks. If I'm writing data to a distributed storage system, I'm consuming a bit of every resource along the way: disk space to store files, memory to store data sent over the network, network to transfer data, and compute to orchestrate and execute everything.

So, when your boss puts you in charge of saving storage space by compressing data more intelligently, it's implied that it shouldn't come at a cost to other resources. In this case, I needed to make sure we didn't use too much computation for the extra storage savings. This led us to focus on optimizing the metric: GB-mo per CPU cycle.

It is important to note that different datasets have different compressibility, and I needed to identify a way to estimate compression gains for an Exabyte of data for different policies without compressing an Exabyte of data. This was done by intelligently identifying and sampling key datasets that consumed the majority of the storage space in the data centers.

Some data exploration highlighted that Pareto's 80/20 principle applied to our data, where the vast majority of the storage space was consumed by a small subset of all datasets. This meant that sampling these key datasets and learning their characteristics (e.g., retention policies, compressibility, etc.) would allow me to accurately predict overall compression gains from a small subset of samples.

The rest of the project was rather straightforward: gather compression statistics for key datasets (normalized to GB-mo per CPU cycle), use hypothesis testing to confirm their compressibility is relatively consistent month-to-month, estimate compression gains given different policies, and then slowly roll-out the best policy to make sure unforeseen issues don't arise.

![Compression](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/04%20Optimize%20Data%20Compression%20Policies.jpg?raw=true)

[Back](./)
