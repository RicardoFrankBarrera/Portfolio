## Welcome!

I'm a Program Manager and Data Scientist and I've created this page for a few reasons:

1. Highlight what I've done professionally,
2. Educate others on how effective and impactful Data Science is,
3. Solidify my knowledge

I believe I only truly understand something once I'm able to teach it to someone else, so writing this out helps ensure I know what I'm talking about.


In here and in my GitHub repository, you'll find:

* My latest and greatest resume,
* One-pagers describing the high-level overview (goals, approach, impact, and lessons) of some work I've done in my previous roles,
* Code I've written for various projects, and
* Data science projects I've developed and models I've trained

Thanks for stopping by,

Ricardo

### Resume

![Resume](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Resume/Ricardo%20Frank%20Barrera%20-%202021%20Resume%20(Beautiful).jpg?raw=true)

### One-pagers

#### @Microsoft: Modeling Cosmos Store's Data Durability and Availability

This project was a LOT of fun and was my first project after joining the Big Data team at Microsoft as a Program Manager. I am pretty sure my manager tossed this my way intended as a throwaway project to help me learn, but we got some pretty good results from it.

For context, Microsoft's Big Data system is named [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). As of 2011, Cosmos was storing approximately an Exabyte of data and had an operating expense budget of about $100,000,000 running several data centers to power many of Microsoft's services (e.g., Bing). Therefore, minor improvements to storage efficiency without impacting customer experience made a large impact on Microsoft's business.

My task was to recreate the same study done at [Google](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/36737.pdf) (click for the whitepaper) for our system. In short, Google aggregated a lot of system log data, analyzed it, and pushed it through a Markov Model to predict data durability (how often data would be lost) and availability (how often data was accessible).

The Markov Model's assumptions don't fit reality because a Markov Model assumes event independence, but we know that hardware fails are correlated; a machine that has failed before is more likely to fail again. However, George Box was right when he said "all models are wrong, but some are useful," because this model turned out to be very useful.

Creating this model proved to be challenging for various reasons:

* Identifying what data was needed, where it was located, and how to access it was difficult because there were hundreds of services running in a data center logging various events owned by several different teams (I got lots of exercise running between offices chatting with domain experts and service owners)
* Interpreting the data correctly was an issue because event logs sometimes had ambiguous meaning for certain events, were incomplete / lossy, or duplicated for events
* Modifying the Markov Model for our system was non-trivial because our replication policies and configurations including geo-replicated data, meaning my Markov Model was more of a 2-D matrix than a 1-D array
* Scalably processing the data, computing all necessary statistics, and validating model accuracy was challenging because data-loss was an infrequent event and most data loss was software related or due to human error as opposed to hardware failure, which was outside of the model's scope

The benefits of effectively modeling the system for a narrow scope was surprisingly broad. This fairly simple model allowed us to make key business decisions and optimizations intelligently, for example we used the model to:

1. Optimize storage replication policies based upon customer needs to reduce cost of service,
2. Reduce customer service outages due to capacity management issues,
3. Advise on network topologies and bandwidth requirements for data centers,
4. Evaluate the pros/cons of other replication schemes (e.g., Erasure Encoding)

![Markov](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/01%20Storage%20Markov%20Model.jpg?raw=true)

#### @Microsoft: Optimizing Cosmos Store's Storage Compression Policies

After my success with the Markov Model, I began the go-to mathematician and was subsequently tasked with optimizating storage compression policies for Cosmos.

![Compression](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/04%20Optimize%20Data%20Compression%20Policies.jpg?raw=true)

#### @Microsoft: Optimize Distributed Workload Execution with Smart Resource Management

![Resource Management](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/05%20Resource%20Management%20Container%20Sizing.jpg?raw=true)

#### @Accolade: Recommendation System for Health Assistants

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