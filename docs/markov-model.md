---
title: Markov Model
layout: template
filename: markov-model.md
--- 

#### @Microsoft: Modeling Cosmos Store's Data Durability and Availability 

This project was a LOT of fun and was my first project after joining the Big Data team at Microsoft as a Program Manager. I am pretty sure my manager intended it to be a throwaway project to help me learn, but we got some pretty good results from it.

For background, Microsoft's Big Data system is named [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). As of 2011, Cosmos was storing approximately an Exabyte of data and had an operating expense budget of about $100,000,000 running several data centers to power many of Microsoft's services (e.g., Bing). Therefore, minor improvements to storage efficiency without impacting customer experience made a large impact on Microsoft's business.

My task was to recreate the same study done at [Google](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/36737.pdf) (click for the whitepaper) for our system. In short, Google aggregated a lot of system log data, analyzed it, and pushed it through a Markov Model to predict data durability (how often data would be lost) and availability (how often data was accessible).

The Markov Model's assumptions don't fit reality because a Markov Model assumes event independence, but we know that hardware fails are correlated; a machine that has failed before is more likely to fail again. I believe there is a relevant quote for every occasion including this one, courtesy of George Box: "All models are wrong, but some are useful." This model turned out to be very useful.

Creating this model proved to be challenging for various reasons:

* Identifying what data was needed, where it was located, and how to access it was difficult because there were hundreds of services running in a data center logging various events owned by several different teams (I got lots of exercise running between offices chatting with domain experts and service owners)
* Interpreting the data correctly was an issue because event logs sometimes had ambiguous meaning for certain events, were incomplete / lossy, or were duplicated
* Modifying the Markov Model for our system was non-trivial because our replication policies and configurations including geo-replicated data, meaning my Markov Model was more of a 2-D matrix than a 1-D array
* Scalably processing the data (10+ Terabytes per year), computing all necessary statistics, and validating model accuracy was challenging because data-loss was an infrequent event; in fact, most data loss was software related or due to human error as opposed to hardware failure, outside of the model's scope

The benefits of effectively modeling the system for this narrow goal were surprisingly broad. This fairly simple model allowed us to make key business decisions and optimizations intelligently. For example, we used the model to:

1. Optimize storage replication policies based upon customer needs to reduce cost of service by 10-15%,
2. Reduce customer service outages due to capacity management issues,
3. Advise on network topologies and bandwidth requirements for data centers,
4. Evaluate the pros/cons of other replication schemes (e.g., Erasure Encoding)

![Markov](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/01%20Storage%20Markov%20Model.jpg?raw=true)


