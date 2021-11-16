

## Welcome!

I'm Ricardo Frank Barrera, a Program Manager and Data Scientist and this is my GitHub Page. I have experience managing teams large (20+) and small (me) but I'll be focusing this page on my Data Science projects. Though this page highlights what I've done professionally, I hope it educates others on how impactful, broadly applicable, and approachable Data Science is to most businesses.

In here and in my GitHub repository, you'll find:

* My latest and greatest resume,
* Write-ups regarding professional projects I've done, specifically describing the context along with a high-level overview (e.g., goals, approach, impact, and lessons),
* Code I've written for various projects, 
* Data science projects I've developed and models I've trained

Thanks for stopping by!

Ricardo

### Resume

![Resume](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Resume/Ricardo%20Frank%20Barrera%20-%202021%20Resume%20(Beautiful).jpg?raw=true)

### Professional Projects

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

#### @Microsoft: Optimizing Cosmos Store's Storage Compression Policies

After my success with the Markov Model, I became the go-to mathematician on the team and was subsequently tasked with optimizing storage compression policies for [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). This project was much simpler at face value than my Markov Model. Surprisingly, it turned out to be rather simple in the end, but could've been quite complicated hard circumstances been different. Let me elaborate.

A data-center has resources (e.g., storage, computation, network, etc.) but these resources are not independent when executing tasks. If I'm writing data to a distributed storage system, I'm consuming a bit of every resource along the way: disk space to store files, memory to store data sent over the network, network to transfer data, and compute to orchestrate and execute everything.

So, when your boss puts you in charge of saving storage space by compressing data more intelligently, it's implied that it shouldn't come at a cost to other resources. In this case, I needed to make sure we didn't use too much computation for the extra storage savings. This led us to focus on optimizing the metric: GB-mo per CPU cycle.

It is important to note that different datasets have different compressibility, and I needed to identify a way to estimate compression gains for an Exabyte of data for different policies without compressing an Exabyte of data. This was done by intelligently identifying and sampling key datasets that consumed the majority of the storage space in the data centers.

Some data exploration highlighted that Pareto's 80/20 principle applied to our data, where the vast majority of the storage space was consumed by a small subset of all datasets. This meant that sampling these key datasets and learning their characteristics (e.g., retention policies, compressibility, etc.) would allow me to accurately predict overall compression gains from a small subset of samples.

The rest of the project was rather straightforward: gather compression statistics for key datasets (normalized to GB-mo per CPU cycle), use hypothesis testing to confirm their compressibility is relatively consistent month-to-month, estimate compression gains given different policies, and then slowly roll-out the best policy to make sure unforeseen issues don't arise.

![Compression](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/04%20Optimize%20Data%20Compression%20Policies.jpg?raw=true)

#### @Microsoft: Optimize Distributed Workload Execution with Smart Resource Management
If you've been reading from top-to-bottom, you'll notice a trend: use Data Science to save money and become more efficient. That trend continues with this project, however, this was not a resounding success. This wouldn't be an honest 

![Resource Management](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/05%20Resource%20Management%20Container%20Sizing.jpg?raw=true)

#### @Accolade: Recommendation System for Health Assistants
This project is a good example of what it takes to develop an intelligent service from the ground up. I had the fortunate privilege of defining, driving, and in some cases implementing the Data Science team's first production service, a Health Assistant Recommendation System. 

Accolade's core business value-add comes from the engagement and relationship between Clients and Health Assistants. A Health Assistant efficiently and effectively navigates a Client through their healthcare experience, saving time and money while improving outcomes. As such, it is critical that the right Health Assistant be paired with the Client, as different Health Assistants have different expertise



![Accolade Recommendation System](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/06%20Health%20Assistant%20Recommendation%20System.jpg?raw=true)

#### @My Startup: Real Estate Investment Recommendation System

Play with my deep-learning neural net and see what it thinks of a home you present it with.

This project was inspired by some basic tooling I created for myself as a real-estate investor to automate my search and analysis process. Real-estate investment has a lot of subjectivity and nuance, and data is sparse, limited, inconsistent

![Real Estate Recommendation System](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/07%20Real%20Estate%20Recommendation%20System.jpg?raw=true)


### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [Basic writing and formatting syntax](https://docs.github.com/en/github/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/RicardoFrankBarrera/Professional-Portfolio/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.