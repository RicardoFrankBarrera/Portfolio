---
title: Data Science 101 - Hypothesis Driven Development
layout: default
filename: data-science-101.md
--- 

# @Accolade: Data Science 101 - Hypothesis Driven Development

(Note: I've modified the [Powerpoint deck](https://github.com/RicardoFrankBarrera/Data-Science-Portfolio/blob/main/Presentations/Data%20Science%20101%20Series%20-%20Hypothesis%20Testing.pptx?raw=true) from the original to avoid any legal issues)

## Problems with the Status Quo

All development (e.g., product, software, etc.) is implicitly driven by hypothesis:

* If I build 'X', I think we'll increase customer engagement
* If I present it this way, I think it will lead to more sales
* If I change compensation structure, I think we'll retain better talent for longer

The issue with the status-quo is that development goals and metrics are often not explicitly stated, understood, and evaluated. Instead, ideas are stated with unwarranted confidence ("This change will definitely improve our business!") and evaluated after the fact when bias is hardest to avoid ("I need to get promoted and put in a lot of work, so I'll fudge the numbers a little to declare success."). As a result, a company is pulled unintentionally in various directions, with an unclear overall direction.

## Initiative Goals and Process

So, I made it one of my first goals at Accolade to evangelize the data science mindset in all organizations throughout the company. It started by identifying and nominating one or two Data Science champions per team, training them personally, and supporting them as they taught others within their organization as well. Decentralized structures like this scale much better and are self-reinforcing. If all went according to plan, every member of every team would have sufficient conceptual understanding to think like a data scientist. Thus, they could proactively identify potential Data Science scenarios and engage with the Data Science team to identify feasibility, value, and priority. This approach to integrating and leveraging Data Science in an organization is much faster than expecting the Data Science team to become domain experts throughout and identify opportunities on their own.

## Context Determines Focus and Priority

In this [presentation](https://github.com/RicardoFrankBarrera/Data-Science-Portfolio/blob/main/Presentations/Data%20Science%20101%20Series%20-%20Hypothesis%20Testing.pptx?raw=true), I focused on Hypothesis Driven Development because it was the highest priority Data Science value-add given business context. In 2016, Accolade was intentionally refactoring all of its infrastructure and organizations to develop its next generation services. This was the ideal time to incorporate Hypothesis Driven Development as new leadership came in, planned their new architecture and organizational structures, and developed their new telemetry. Proper experimentation and testing is very expensive, if not infeasible, if it isn't baked into the architecture and data streams at the beginning (e.g., imagine trying to update a button color for A/B testing and needing the customer to download a different app version rather than simply having the app render a different version for a different population at runtime without any user involvement.)

Beyond the need to evaluate improvements and protect against bad business decisions, Hypothesis Testing is invaluable at uncovering really surprising truths our intuition and experience blind us from seeing. For example, in 2006 Amazon had a few executives who were vehemently against shopping cart recommendations, thinking it would distract the customer at check out and lead to a drop in revenue. That's an understandable concern, however, the problem is there was one executive so convinced of this he blocked even testing the feature. That is not acceptable and is not a Data Science mindset. Despite the pushback, the feature developer continued development and conducted an A/B test; the results were so convincing that the shopping cart recommendation feature became high priority to launch as soon as possible.

## Closing Thoughts

Every business and every organization has numerous examples like the preceding one from Amazon, and the only way to uncover and resolve them is through Hypothesis Driven Development. I encourage you to adopt this in your day-to-day and teach others to do the same.

[Back](./)
