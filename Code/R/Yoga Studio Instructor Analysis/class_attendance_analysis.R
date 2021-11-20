# read in data and get bird's eye view of it
install.packages("plyr")
install.packages("dplyr")
install.packages("ggpubr")
library(ggpubr)
library(plyr)
library(dplyr)
require(graphics)

df <- read.csv('class_attendance.csv')
df$start_time = substr(strptime(df$start_time,'%I:%M %p'),11,16)
df$start_time <- trimws(df$start_time, which = c("left"))
counts_time <- ddply(df, .(df$teacher, df$start_time), nrow)
names(counts_time) <- c("teacher", "start_time", "count")
counts_class <- ddply(df, .(df$teacher, df$class_type), nrow)
names(counts_class) <- c("teacher", "class_type", "count")

# change class names to power or hatha based upon keyword presence
df$class_type[grepl('power', tolower(df$class_type), fixed=TRUE)] = 'power'
df$class_type[grepl('hatha', tolower(df$class_type), fixed=TRUE)] = 'hatha'

# get teacher frequency distribution and take top 20% that represent 80% of classes taught
# teachers present over 100 account for 93.2% of classes -- use teacher_id because teacher_name
# is not guaranteed to be unique
classes_taught <- ddply(df, .(df$teacher_id), nrow)
names(classes_taught) <- c("teacher_id", "count")
perc_teachers_over_100_classes = sum(classes_taught$count[classes_taught$count > 100]) /
                                 sum(classes_taught$count)
                                 
main_teachers = classes_taught$teacher_id[classes_taught$count > 100]

# take a subset and filter for main teachers
testing_df = df[,c("teacher_id","class_type","in_attendance", "start_time")]
testing_df_final = na.omit(testing_df[testing_df$teacher_id %in% main_teachers,])

# TEST 1: Try to ANOVA test all teachers together to see if means differ between teachers

# ASSUMPTION 1: Normally distributed data

# Run a quantile-quantile (QQ) plot to see if the data is normally distributed
ggqqplot(testing_df_final$in_attendance)

# ASSUMPTION 2: Homogeneity of Variance
bartlett.test(testing_df_final$in_attendance, testing_df_final$teacher_id) # p < 2.2e-16
fligner.test(testing_df_final$in_attendance, testing_df_final$teacher_id)  # p < 2.2e-16

# CONCLUSION: Data is definitely not normally distributed, nor does it have homogeneity of variance


# TEST 2: Try to ANOVA test all teachers within a specific class time together

# time to start looking at comparing within similar hours, just over the last two years
df_recent <- df[as.Date(df$date, "%m/%d/%y") > as.Date('08/01/15', "%m/%d/%y"),]
counts_start_time <- ddply(df_recent, .(df_recent$start_time), nrow)
names(counts_start_time) <- c("start_time", "count")

# we'll also filter for just the most common class times
# 75.6% of classes happen at 06:00, 09:00, 10:00, 12:00, 16:00, 17:30, 17:45, 19:00
perc_class_over_250 = sum(counts_start_time$count[counts_start_time$count > 250]) / 
                      sum(counts_start_time$count)
class_over_250 = counts_start_time[counts_start_time$count > 250,]

# we will analyze only at these times, and only top teachers per slot will be compared amongst each other
top_times = counts_start_time$start_time[counts_start_time$count > 250]
df_recent_toptimes = df_recent[df_recent$start_time %in% top_times,]

#get top instructors per time
instructor_time_count = ddply(df_recent_toptimes, 
                              .(df_recent_toptimes$teacher_id, df_recent_toptimes$start_time), 
                              nrow)
names(instructor_time_count) <- c("teacher_id", "start_time", "count")

sort_instructor_time_count = instructor_time_count[order(instructor_time_count$start_time,
                                                         instructor_time_count$count,
                                                         decreasing = TRUE),]

toptimes_topinstruct <- sort_instructor_time_count %>%
                        group_by(start_time) %>%
                        top_n(n = 5, wt = count)
df_recent_toptimes_topinstruct = merge(df_recent, toptimes_topinstruct, by=c("teacher_id", "start_time"))

# create the per-time groupings 
df_6am_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '06:00',]
df_9am_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '09:00',]
df_10am_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '10:00',]
df_12pm_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '12:00',]
df_4pm_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '16:00',]
df_530pm_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '17:30',]
df_545pm_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '17:45',]
df_7pm_test_set = df_recent_toptimes_topinstruct[df_recent_toptimes_topinstruct$start_time == '19:00',]

# look at plots per time and also the stats

# 6AM is ok to ANOVA 
# Bartlett's K-squared = 4.7298, df = 4, p-value = 0.3162
# Fligner-Killeen:med chi-squared = 4.1425, df = 4, p-value = 0.3871
bartlett.test(df_6am_test_set$in_attendance, df_6am_test_set$teacher_id)
fligner.test(df_6am_test_set$in_attendance, df_6am_test_set$teacher_id)

# 9AM is ok to ANOVA 
# Bartlett's K-squared = 3.9672, df = 4, p-value = 0.4105
# Fligner-Killeen:med chi-squared = 4.7337, df = 4, p-value = 0.3157
bartlett.test(df_9am_test_set$in_attendance, df_9am_test_set$teacher_id)
fligner.test(df_9am_test_set$in_attendance, df_9am_test_set$teacher_id)

# 10AM is (might be) OK to ANOVA 
# Bartlett's K-squared = 13.976, df = 4, p-value = 0.007373
# Fligner-Killeen:med chi-squared = 5.5614, df = 4, p-value = 0.2344
bartlett.test(df_10am_test_set$in_attendance, df_10am_test_set$teacher_id)
fligner.test(df_10am_test_set$in_attendance, df_10am_test_set$teacher_id)

# 12PM is not OK to ANOVA 
# Bartlett's K-squared = 38.388, df = 4, p-value = 9.317e-08
# Fligner-Killeen:med chi-squared = 26.519, df = 4, p-value = 2.486e-05
bartlett.test(df_12pm_test_set$in_attendance, df_12pm_test_set$teacher_id)
fligner.test(df_12pm_test_set$in_attendance, df_12pm_test_set$teacher_id)

# 4PM is (might be) OK to ANOVA 
# Bartlett's K-squared = 12.616, df = 4, p-value = 0.01331
# Fligner-Killeen:med chi-squared = 7.3534, df = 4, p-value = 0.1184
bartlett.test(df_4pm_test_set$in_attendance, df_4pm_test_set$teacher_id)
fligner.test(df_4pm_test_set$in_attendance, df_4pm_test_set$teacher_id)

# 530PM is OK to ANOVA 
# Bartlett's K-squared = 6.004, df = 4, p-value = 0.1988
# Fligner-Killeen:med chi-squared = 4.7919, df = 4, p-value = 0.3093
bartlett.test(df_530pm_test_set$in_attendance, df_530pm_test_set$teacher_id)
fligner.test(df_530pm_test_set$in_attendance, df_530pm_test_set$teacher_id)

# 545PM is OK to ANOVA 
# Bartlett's K-squared = 4.7787, df = 5, p-value = 0.4435
# Fligner-Killeen:med chi-squared = 5.98, df = 5, p-value = 0.3082
bartlett.test(df_545pm_test_set$in_attendance, df_545pm_test_set$teacher_id)
fligner.test(df_545pm_test_set$in_attendance, df_545pm_test_set$teacher_id)

# 7PM is OK to ANOVA 
# Bartlett's K-squared = 5.6058, df = 4, p-value = 0.2306
# Fligner-Killeen:med chi-squared = 5.3464, df = 4, p-value = 0.2536
bartlett.test(df_7pm_test_set$in_attendance, df_7pm_test_set$teacher_id)
fligner.test(df_7pm_test_set$in_attendance, df_7pm_test_set$teacher_id)

# compute ANOVA for times that satisfy ANOVA's homogeneit of variance criteria

# 6AM no statistically significant difference between top 5 teachers
# Pr(>F) = 0.64 > 0.05, and qf(...) = 254.0164 > 0.2191
'
Analysis of Variance Table

Response: df_6am_test_set$In.Attendance
Df  Sum Sq Mean Sq F value Pr(>F)
df_6am_test_set$TeacherID   1     6.5  6.4842  0.2191   0.64
Residuals                 428 12666.7 29.5952
'
fit = lm(formula = df_6am_test_set$in_attendance ~ df_6am_test_set$teacher_id)
anova (fit)
qf(0.950, 428, 1)

# 9AM no statistically significant difference between top 5 teachers
# Pr(>F) = 0.431 > 0.05, and qf(...) = 253 > 0.623
'
Analysis of Variance Table

Response: df_9am_test_set$In.Attendance
Df Sum Sq Mean Sq F value Pr(>F)
df_9am_test_set$TeacherID   1   33.3  33.291   0.623  0.431
Residuals                 168 8977.3  53.436               
> qf(0.950, 168, 1)
[1] 253.5557
'
fit = lm(formula = df_9am_test_set$in_attendance ~ df_9am_test_set$teacher_id)
anova (fit)
qf(0.950, 168, 1)

# 530PM no statistically significant difference between top 5 teachers
'
Analysis of Variance Table

Response: df_530pm_test_set$In.Attendance
Df Sum Sq Mean Sq F value Pr(>F)
df_530pm_test_set$TeacherID   1    120  120.43  1.1381 0.2868
Residuals                   346  36615  105.82               
> 
> qf(0.950, 346, 1)
[1] 253.9458
'
fit = lm(formula = df_530pm_test_set$in_attendance ~ df_530pm_test_set$teacher_id)
anova (fit)
qf(0.950, 346, 1)

# 545PM no statistically significant difference between top 5 teachers
'
Analysis of Variance Table

Response: df_545pm_test_set$In.Attendance
Df Sum Sq Mean Sq F value Pr(>F)
df_545pm_test_set$TeacherID   1   22.5  22.528  1.0589  0.305
Residuals                   162 3446.4  21.274               
> 
> qf(0.950, 162, 1)
[1] 253.5277
'
fit = lm(formula = df_545pm_test_set$in_attendance ~ df_545pm_test_set$teacher_id)
anova (fit)
qf(0.950, 162, 1)

# 7PM has statistically significant difference between top 5 teachers
# Anna's average per class is about 20% less than the other 4 (22 versus 26 - 28 for the other 4)
'
Analysis of Variance Table

Response: df_7pm_test_set$In.Attendance
Df  Sum Sq Mean Sq F value   Pr(>F)    
df_7pm_test_set$TeacherID   1   926.4  926.38  23.773 1.87e-06 ***
Residuals                 265 10326.3   38.97                     
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
> 
> qf(0.950, 265, 1)
[1] 253.8332
'
fit = lm(formula = df_7pm_test_set$in_attendance ~ df_7pm_test_set$teacher_id)
anova (fit)
qf(0.950, 265, 1)