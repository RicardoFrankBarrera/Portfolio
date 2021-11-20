---
title: Yoga Instructor Class Attendance
layout: default
filename: yoga.md
--- 

# @Consulting: Yoga Instructor Compensation Strategy

This was a fun and quick project (and got me some free yoga classes). A friend of mine owns a fairly successful yoga studio in Seattle, but wasn't sure whether he had the right compensation strategy and recruiting approach for his instructors to maximize revenue. The yoga community is filled with many different personality types and he spent a lot of time courting the most popular, experienced, and sometimes difficult/flaky instructors thinking it would boost attendance and revenue.

He sent over a few years of class attendance data and asked me to figure out whether the instructors were making a difference in class attendance. I structured this analysis as shown in the diagram below:

![Yoga Instructor ANOVA](https://github.com/RicardoFrankBarrera/Data-Science-Portfolio/blob/main/docs/assets/img/Yoga%20Studio%20QQ-plot.png?raw=true)

Statistical testing can be very valuable for businesses of all sizes and provides a great compass for determining investigation approach and evaluating potential strategies quickly and cheaply. It is important to setup the experiment well to provide the correct data, use the appropriate test given data characteristics, and draw the right conclusions given the data and test. However, the test value is heavily reliant upon setup and data.

In this case, I had to work with the data available and infer whatever I could because he couldn't afford to wait a year to collect more data for an experiment. He was about to make some important financial decisions and needed guidance as soon as possible. So, I stuck to answering the most important question: "Are his instructors influencing class attendance?"

If there was no statistically significant variance between instructor class attendance, he could change his hiring strategy to pay less experienced and more eager yoga instructors a lower rate without negatively impacting his attendance and revenue. **Note: I cannot say whether attendance and revenue would go up or down in the next year--I can only say whether changing instructors would expect to yield a change in attendance and revenue.**

The test used to compare groups depends on the data's characteristics. I ran a few tests on the data to see it's characteristics:

* Quantile-quantile (QQ) plot to test for normal distribution
* Bartlett's test for homogeneity of variance
* Fligner-Killeen's test for homogeneity of variance (to double-check Bartlett's test since it's more sensitive)

For the first analysis, I am grouping all of the data by teachers. When I ran graphed the QQ plot, I determined the the data was not normally distributed, as the data strayed far from the 45-degree line shown below. 

![Yoga QQ Plot](https://github.com/RicardoFrankBarrera/Data-Science-Portfolio/blob/main/docs/assets/img/Yoga%20%Studio%QQ-Plot.png?raw=true)

I could try to transform the data to make it normal, but the One-way ANOVA test is fairly robust and can handle the normality assumption being violated, so I decided to proceed with it so long as the homogeneity of variance assumption was true.

I ran Bartlett's test and concluded that class attendance definitely violated the homogeneity of variance requirement, so I couldn't use ANOVA. That result, however, told me I needed to look at the problem differently.

I thought class time might be a major contributor to the class attendance mean and variance, so I decided to analyze teachers' class attendance within the same class time (e.g., Vinyasa Yoga @ 530PM). If I reran the variance tests within those groups, I might get a different result and possibly be able to use ANOVA to compare means between teachers.

I repeated Bartlett and Fligner-Killeen for each class time grouping using only the top 5 instructors by count of classes taught for that group, as we need adequate samples for the tests to be meaningful. From the several groups, I found that all but one should be fine for the ANOVA test (don't know why the 12PM class was so different regarding variance).

After running ANOVA on the classes which met the variance criteria, I found that there was no statistically significant difference in the mean attendance between teachers in all but one (7PM had one teacher with 20% fewer attendees on average).

This result was good news for the owner who could stress less about hunting for great instructors and paying them extra to stay because the instructors seem to be fungible. It is still important to carry forward with caution because the data may have been materially incomplete / biased, I may have been wrong in proceeding with ANOVA though the normal distribution assumption didn't fit, and so on. Armed with this information, he changed his hiring and compensation structure. The change reduced his business expenses by 10% which can be rather significant in a low-margin business with high overhead.

[Back](./)
