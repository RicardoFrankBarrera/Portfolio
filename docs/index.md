


## Welcome!

I'm Ricardo Frank Barrera, a Program Manager and Data Scientist and this is my GitHub Page. I have experience managing teams large (20+) and small (me) but I'll be focusing this page on my Data Science projects. Though this page is meant to highlight some of what I've done professionally, I hope it educates others on how impactful, broadly applicable, and approachable Data Science is to most businesses.

In here and in my GitHub repository, you'll find:

* My latest and greatest [resume](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Resume/Ricardo%20Frank%20Barrera%20-%202021%20Resume%20(Beautiful).pdf),
* Write-ups regarding professional projects I've done, specifically describing the context along with a high-level overview (e.g., goals, approach, impact, and lessons),
* Code I've written for various projects, 
* Data science projects I've developed and models I've trained

Thanks for stopping by!

Ricardo


### Professional Projects (Click sections below to expand / collapse)

<details>
  <summary> <b>@Microsoft: Modeling Cosmos Store's Data Durability and Availability </b></summary>
  
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
</details>



<details>
  <summary> <b>@Microsoft: Optimizing Cosmos Store's Storage Compression Policies </b></summary>

After my success with the Markov Model, I became the go-to mathematician on the team and was subsequently tasked with optimizing storage compression policies for [Cosmos](http://vldb.org/pvldb/vol14/p3148-jindal.pdf) (click for the whitepaper). This project was much simpler at face value than my Markov Model. Surprisingly, it turned out to be rather simple in the end, but could've been quite complicated hard circumstances been different. Let me elaborate.

A data-center has resources (e.g., storage, computation, network, etc.) but these resources are not independent when executing tasks. If I'm writing data to a distributed storage system, I'm consuming a bit of every resource along the way: disk space to store files, memory to store data sent over the network, network to transfer data, and compute to orchestrate and execute everything.

So, when your boss puts you in charge of saving storage space by compressing data more intelligently, it's implied that it shouldn't come at a cost to other resources. In this case, I needed to make sure we didn't use too much computation for the extra storage savings. This led us to focus on optimizing the metric: GB-mo per CPU cycle.

It is important to note that different datasets have different compressibility, and I needed to identify a way to estimate compression gains for an Exabyte of data for different policies without compressing an Exabyte of data. This was done by intelligently identifying and sampling key datasets that consumed the majority of the storage space in the data centers.

Some data exploration highlighted that Pareto's 80/20 principle applied to our data, where the vast majority of the storage space was consumed by a small subset of all datasets. This meant that sampling these key datasets and learning their characteristics (e.g., retention policies, compressibility, etc.) would allow me to accurately predict overall compression gains from a small subset of samples.

The rest of the project was rather straightforward: gather compression statistics for key datasets (normalized to GB-mo per CPU cycle), use hypothesis testing to confirm their compressibility is relatively consistent month-to-month, estimate compression gains given different policies, and then slowly roll-out the best policy to make sure unforeseen issues don't arise.

![Compression](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/04%20Optimize%20Data%20Compression%20Policies.jpg?raw=true)

</details>


<details>
  <summary> <b>@Microsoft: Optimize Distributed Workload Execution with Smart Resource Management </b></summary>
  
If you've been reading from top-to-bottom, you'll notice a trend: use Data Science to save money and become more efficient. That trend continues with this project, however, this was not a resounding success. This wouldn't be an honest 

![Resource Management](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/05%20Resource%20Management%20Container%20Sizing.jpg?raw=true)

</details>

<details>
  <summary> <b>@Accolade: Recommendation System for Health Assistants</b></summary>

This project is a good example of what it takes to develop an intelligent service from the ground up. I had the fortunate privilege of defining, driving, and implementing the Data Science team's first production service, a Health Assistant Recommendation System. 

Accolade's core business value-add comes from the engagement and relationship between Clients and Health Assistants. A Health Assistant efficiently and effectively navigates a Client through their healthcare experience, saving time and money while improving outcomes. As such, it is critical that the right Health Assistant be paired with the Client, as different Health Assistants have different expertise (e.g., some are Benefits experts, others are Clinicians, etc.). This Recommendation System's main goals were to improve Client outcomes while improving operating efficiency on Accolade's side. The metrics of choice to measure success for this were low-level operations metrics (e.g., Call Duration, Call Re-routes per Engagement) and high-level business metrics (e.g., Net Promoter Score). 

Bringing this service to life was particularly challenging for many reasons, mainly:

1. Most of Accolade's infrastructure was being re-architected to support future scenarios (i.e., nobody knows what plugs into where anymore),
2. Best-practices and policies for developing and deploying services were undefined in the new architecture,
3. Much of the existing Data Ecosystem was useless, so an intelligent system would need to be bootstrapped without data

How does one bootstrap an intelligent service without data? You operate with rules/heuristics coded in the initial version, and define telemetry to record and train an intelligent model with after-the-fact. So, in this case the initial version was simply a load-balancer that re-assigned Health Assistants to Clients based upon personnel load, and the subsequent data would become the foundation for an intelligent service using some Machine Learning techniques (e.g., Random Forest, Collaborative-Filtering).

In this case, 80% to 90% of the work for the initial model was simply getting the plumbing in place: setting up roles and permissions for services, service logging and alerting, configuring the service to log the correct data with the correct schema for future iterations, and so on. In the end, the initial model was a simple EC2 service that would run once per day to update Health Assistant assignments in a DynamoDB table.

I left Accolade shortly deploying this service so I didn't get to see further iterations on this, but the plan, at the time, was to evaluate the existing model's performance against key metrics (e.g., Call Duration) alongside new models, and switch over to a new intelligent model once a statistically significant improvement was achieved. It is essential to use statistical testing and execute it correctly because small sample sizes or analyzing populations incorrectly can mislead one to think a model is better when it is actually worse. The statistical test is the compass to determine whether were heading in the right direction.

![Accolade Recommendation System](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/06%20Health%20Assistant%20Recommendation%20System.jpg?raw=true)

</details>

<details>
  <summary> <b>@My Startup: Real Estate Investment Recommendation System</b></summary>

Shortly after I left Accolade, I began to improve upon some personal analytics tools I made for my real estate investment hobby. I was curious to see how much of my process I could automate and what the user-experience would be like as I automated more of it.

For those unfamiliar with real estate investing, there are some interesting data problems providing fun challenges. For instance:

* data is **incomplete** 
	* much of the data on a home is not available, such as age of infrastructure like plumbing
* data is **inconsistent**
	* a lot of data is manually entered by different entities so errors are common
* data is **biased**
	* homes being listed for sale / rent are presented with bias
* data is **stale**
	* housing records don't update often
* data is **subjective**
	* some data like neighborhood crime statistics has subjectivity 
* data is **expensive to collect**
	* getting a home inspector, for example, may cost $300 to $500

So, I set out to see if I could infer as much information as possible from what was available online in an automated fashion. There are plenty of sites with records written records (e.g., county records indicating square footage), but the one really valuable untapped resource at the time was the property's photos.  

Analyzing imagery is really, really hard and there was no chance I'd be able to create my own image analyzer from scratch that was worth anything. However, a few events coincided that made this approachable:

1. Tensorflow had recently come out and made deep learning more approachable,
2. Google released [Inception](https://ai.googleblog.com/2016/03/train-your-own-image-classifier-with.html), an AI model to classify images

I believed I could shoehorn Google's Inception model for my purposes (known as Transfer Learning) and retrain it on my own custom-labeled dataset. The retraining worked and I was able to get a reasonably effective (based upon my judgment) neural network to judge the quality of a home based upon photos.

Play with it and see for yourself! (TODO: link URL)

Emboldened by my success with the Neural Network, I decided to work on creating a Real Estate Investment Advisor platform where residential homebuyers could rely upon and learn from to become their own best advocate in an ecosystem notorious for taking advantage of the ignorant and unprepared. I'm passionate about fairness and education, and I'd seen many examples of friends suffering immensely because of poor real estate choices. Ideally, I'd be able to make a decent cashflowing business in the process. 

Building the Minimum Viable Product (MVP) for the platform took quite a bit of work for many reasons:

1. The data ecosystem in real estate is a mess,
2. Building analytics and insights on top of poor quality data is not acceptable,
3. I didn't want to spend a lot of cash paying for data,
4. The user-experience needed to be very simple and approachable so users had no excuse not to try it

This meant I needed to develop a fleet of webscrapers for each data source, merge the records together into a unified entity record, perform extensive data cleaning and imputation, and then build a clean, comprehensive, and sensible data ecosystem. The logic for merging entity records together was thankfully greatly simplified by using Google Maps API, among other resources.

Once I'd created the dataset for the Pacific Northwest, I proceeded with feature engineering to tease apart additional insights and signals from the data; for example, there is a lot of value in spotting differences in records across different platforms for the same entity.

I also began building analytics on top of the curated dataset to gather valuable statistics (e.g., rental distributions per sqft / bedroom / zip code), sale statistics (e.g., days on market heatmaps), and so on. It was better for me to think of all of the features and statistics which could possibly be useful and prune down after the fact because creative data and modeling insights come from having more information presented. Once I'd gotten all of the analytics and insights I wanted for the MVP, I proceeded with automating the Comparative Market Analysis (CMA) report.

Many residential homebuyers rely upon their realtor to generate a CMA report to justify their opinion on a home's Fair Market Value. In an ideal world, this would be consistent and valuable, but the reality is most realtors carelessly select whatever is convenient to justify their end goal (e.g., get the buyer to spend more so they receive a larger commission). Good realtors, however, actually do spend quite a bit of time to do this. An automated CMA would ideally reduce bias, save time, and provide additional statistics and insights not available on other platforms.

Explainability and conciseness is important, so the initial CMA report was intentionally scoped on just the most important features (e.g., size in sq. ft, # of beds, # of baths, etc.), a list of comparables specifying which were used for the estimate and which were excluded, and a price estimate. The comparables selection algorithm used a blend of distance metrics (e.g., L-1 and L-2 norms) and the resulting valuation estimate was an ensemble model using my algorithm's assessment along with other automated evaluations if available. See the visual below for a high-level view of the architecture.

![Real Estate Recommendation System](https://github.com/RicardoFrankBarrera/Professional-Portfolio/blob/main/Project%20one-pagers/07%20Real%20Estate%20Recommendation%20System.jpg?raw=true)

The initial user experience was actually quite nice, as the user simply put in an address into my system and an automated report would generate and be emailed to them; if the data existed in the ecosystem, the report would show up in a few seconds, otherwise I had a separate code path to collect and analyze all necessary data on the fly to try and generate a report which sometimes took 15 to 30 minutes. See below for an example of one of the first reports.

Once I had the MVP developed, I worked on getting answers to key questions, for example:

1. Who were the customers?
2. What are each customer's needs and what scenarios are missing or gaps exist?
3. What revenue models would make sense for each customer / scenario?
4. How should I go about getting early adopters?

In the process of testing out the user experience and getting feedback, I ended up partnering with a client/customer to purchase and renovate a few investment properties. So, additional progress on the MVP was postponed in favor of other work. At the time, some of my next set of features / high-level roadmap looked like:

* Identify and define key metrics to evaluate algorithm and business operation performance,
	* Normally it's important to start with this first before building out, but I didn't think it made sense to define performance and evaluation before I've confirmed technical feasibility with an MVP
* Augment the MVP model to include labor and material cost estimates for repairs and renovations,
* Estimate renovation costs and after-repair value,
* Provide financial models to analyze different investment strategies (30 YR mortgage, versus cash, etc.),
* Create a chatbot (AI Advisor) to engage with clients for some basic scenarios (e.g., estimate their home value, provide leads to service providers, etc.)
* Improve upon the image analyzer to identify property features and architectural styles (e.g., modern, craftsman, etc.),

As you can see, there is a lot to do in the real estate space as it's complex and broad. I may dust off my old code and continue hacking away at this again in my spare time in the not too distant future. Just because Zillow failed with Zillow Offers, doesn't mean it's an impossible area to innovate in.

</details>

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