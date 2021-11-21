---
title: Kaggle - Random Acts of Pizza
layout: default
filename: kaggle-roap.md
--- 

# @Kaggle: Random Acts of Pizza Competition

For those who aren't familiar with Kaggle, it is a Data Science platform which pairs problems with data scientists in a competitive format to see who can create the best model. This specific competition had already concluded but was fun to do anyway because it was unusual and required one to exercise quite a few concepts together well to get solid performance.

The premise for this competition was to predict whether a request for free pizza would be granted; the subreddit, Random Acts of Pizza, consists of people asking for free pizza and some people fulfilling the requests if they wish. The dataset had many different feature types (e.g., text, timestamps, categories, etc.) and so modeling would require a good bit of thought and finesse.

## Data Science 101

I'll provide a quick Data Science 101 primer for those unfamiliar with the concepts:

* Data must be transformed into numbers for models (e.g., text must be turned into numbers for the models to compute)
* Data can have additional value with minor representational changes (e.g., augment a date value with whether it is a weekday, weekend, etc.)
* Data dimensionality and numerical scaling greatly influences how well models can train and perform (e.g., representing "Hello" and "hello" using the same numerical representation loses some information but reduces dimensionality and may help the model train and perform better)
* Choosing the evaluation metric is important; for instance, accuracy alone isn't great with rare events like diagnosing cancer because a model will just always say "No cancer" and have a high score but be worthless
* When categorizing (e.g., predicting yes or no), the data set must be balanced so the model has adequate samples of each class to train and learn from
* Different models excel in different tasks (e.g., Convolutional Neural Networks are great for image analysis)
* Models can be combined together and fed into other models; think of it as a king and his advisors, and the king learns through experience which advisors' opinions are or less valuable during specific situations
* The most valuable parts of a dataset are not immediately obvious, so we must explore all of them and see which improve performance and which don't add sufficient value worth the additional model complexity
* Datasets must be split into three different sections for different purposes: train, test, and cross-validate
	* Train: used to fit the model to the data
	* Cross-validate: used to tune the model's hyperparameters
	* Test: used to evaluate model performance on data it hasn't used for training and tuning

Most novice data scientists will approach a problem like this and try to shoehorn the data into a single powerful model, tune it, and call it a day. Intuition and laziness often pushes us toward fancier and more powerful tools. Seasoned practitioners, however, know that an ensemble of models, each tailored to specific parts of the data/problem, with properly cleaned and processed data, is the better approach.

## Modeling Process and Insights

The high-level process for creating this model was:

1. Ingest and analyze the data to answer some important questions (e.g., are the classes balanced?)
2. Upsample the data to balance out the samples such that each class had 50/50 representation
3. Split the data into training (60%), cross-validation (20%), and test (20%) sets
4. For text-features (e.g., the request text), tokenize and identify the most important vocabulary using CountVectorizer, lemmatization, the pre-processor, N-grams, and a blend of L1 and L2 norming to prune vocabulary
5. Test out different models one feature at a time and identify the best model-type per feature
6. Optimize the individual model hyper-parameters (e.g. 'C' meaning regularization for logistic regression) for all models using accuracy and F-1 scores
7. Combine the individual models outputs into a single ensemble model and optimize the ensemble model by testing out various models and optimizing hyperparameters

Quite a bit goes into the model to get it to perform well, but the process is fairly straightforward. We methodically break out the problem into smaller sub-problems, model and optimize each of the sub-problems, and combine them together with an optimized ensemble model. The trick is to set up the framework correctly, apply the correct data pre-processing and dimensionality reduction, and avoid over-complicating a model. In many cases, less is more.

Some high-level insights from this model:

* A larger vocabulary set has diminishing returns (see below)
* Decision Trees performed poorly for categorical and text features
* Decision Trees outperformed for numerical features
* Timestamp is very valuable and significantly boosted performance
* The ensemble model also led to a significant performance boost
* K-Nearest Neighbors and Logistic Regression outperformed on text and categorical features

![Accuracy with more vocab](https://github.com/RicardoFrankBarrera/Data-Science-Portfolio/blob/main/docs/assets/img/RAOP%20-%20Vocab%20Diminishing%20Returns.png)

## Closing Thoughts

The model performed decently well overall (93% accuracy) and would've scored in the top 10 to 15 models in the competition based upon the Leaderboard scores. This is an interesting outcome for a few reasons:

1. The model is made of simple techniques that can still be further optimized (e.g., Decision Tree depth)
2. Much more powerful and sophisticated models can be used (e.g., Random Forest, AdaBoost, etc.)
3. Further data curation and processing can be done (e.g., using higher-order N-grams)
4. Further training and validation optimization can be done (e.g., K-folds cross-validation)

The principals to take from this are:

* Good process and technique can carry simple methods very far
* Getting pretty darn good results is very achievable and approachable
* Sub-optimal models can still be quite useful


[Back](./)
