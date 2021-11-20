# clean up data and get bird's eye view of it
install.packages("plyr")
library(plyr)
df <- read.csv('Class Attendance.csv')
df$start_time = substr(strptime(df$Start.Time,'%I:%M %p'),11,16)
counts_time <- ddply(df, .(df$Teacher, df$start_time), nrow)
names(counts_time) <- c("Teacher", "start_time", "Freq")

counts_class <- ddply(df, .(df$Teacher, df$Class), nrow)

#change class names to power or hatha based upon keyword presence
df$class_type[grepl('power', tolower(df$Class), fixed=TRUE)] = 'power'
df$class_type[grepl('hatha', tolower(df$Class), fixed=TRUE)] = 'hatha'

#get teacher frequency distribution and take top 20% that represent 80% of classes taught
#teachers present over 100 account for 94% of classes
classes_taught <- ddply(df, .(df$TeacherID), nrow)
sum(classes_taught$V1)
sum(classes_taught$V1[classes_taught$V1 > 100])
main_teachers = classes_taught$`df$TeacherID`[classes_taught$V1 > 100]

#subset and clean (look only at most common teachers)
testing_df = df[,c("TeacherID","class_type","In.Attendance", "start_time")]
testing_df_final = na.omit(testing_df[testing_df$TeacherID %in% main_teachers,])

require(graphics)
plot(TeacherID ~ In.Attendance, data=testing_df_final)
bartlett.test(testing_df_final$In.Attendance, testing_df_final$TeacherID)

# Results from the Bartlett test indicate variances are definitely different between teachers
# Bartlett's K-squared = 2665, df = 32, p-value < 2.2e-16

# time to start looking at comparing within similar hours, just over the last two years

df_recent <- df[as.Date(df$Date, "%m/%d/%y") > as.Date('08/01/15', "%m/%d/%y"),]
df_recent$start_time = substr(strptime(df_recent$Start.Time,'%I:%M %p'),11,16)
counts_start_time <- ddply(df_recent, .(df_recent$start_time), nrow)

# sum(counts_start_time$V1[counts_start_time$V1 > 250]) = 3583
# 75.6% of classes happen at 12:00, 06:00, 17:30, 16:00, 10:00, 19:00, 17:45, 09:00
# we will analyze only at these times, and only top teachers per slot will be compared amongst each other

top_times = counts_start_time$`df_recent$start_time`[counts_start_time$V1 > 250]
df_recent_toptimes = df_recent[df_recent$start_time %in% top_times,]

#get top instructors per time
instructor_time_count = ddply(df_recent_toptimes, .(df$TeacherID, df$start_time), nrow)

install.packages("dplyr")
library(dplyr)
toptimes_topinstruct <- instructor_time_count %>%
  group_by(`df_recent_toptimes$start_time`) %>%
  top_n(n = 5, wt = V1)
names(toptimes_topinstruct) <- c('TeacherID', 'start_time', 'count')
df_recent_logs_toptimes_topinstruct = merge(df_recent, toptimes_topinstruct, by=c("TeacherID", "start_time"))

# create the per-time groupings 
# there is a space in the strings :(
df_6am_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 06:00',]
df_9am_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 09:00',]
df_10am_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 10:00',]
df_12pm_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 12:00',]
df_4pm_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 16:00',]
df_530pm_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 17:30',]
df_545pm_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 17:45',]
df_7pm_test_set = df_recent_logs_toptimes_topinstruct[df_recent_logs_toptimes_topinstruct$start_time == ' 19:00',]


# look at plots per time and also the stats

# 6AM is ok to ANOVA 
# Bartlett's K-squared = 4.7298, df = 4, p-value = 0.3162
# Fligner-Killeen:med chi-squared = 4.1425, df = 4, p-value = 0.3871
plot(TeacherID ~ In.Attendance, data=df_6am_test_set)
bartlett.test(df_6am_test_set$In.Attendance, df_6am_test_set$TeacherID)
fligner.test(df_6am_test_set$In.Attendance, df_6am_test_set$TeacherID)

# 9AM is ok to ANOVA 
# Bartlett's K-squared = 3.9672, df = 4, p-value = 0.4105
# Fligner-Killeen:med chi-squared = 4.7337, df = 4, p-value = 0.3157
bartlett.test(df_9am_test_set$In.Attendance, df_9am_test_set$TeacherID)
fligner.test(df_9am_test_set$In.Attendance, df_9am_test_set$TeacherID)

# 10AM is (might be) OK to ANOVA 
# Bartlett's K-squared = 13.976, df = 4, p-value = 0.007373
# Fligner-Killeen:med chi-squared = 5.5614, df = 4, p-value = 0.2344
bartlett.test(df_10am_test_set$In.Attendance, df_10am_test_set$TeacherID)
fligner.test(df_10am_test_set$In.Attendance, df_10am_test_set$TeacherID)

# 12PM is not OK to ANOVA 
# Bartlett's K-squared = 38.388, df = 4, p-value = 9.317e-08
# Fligner-Killeen:med chi-squared = 26.519, df = 4, p-value = 2.486e-05
bartlett.test(df_12pm_test_set$In.Attendance, df_12pm_test_set$TeacherID)
fligner.test(df_12pm_test_set$In.Attendance, df_12pm_test_set$TeacherID)

# 4PM is (might be) OK to ANOVA 
# Bartlett's K-squared = 12.616, df = 4, p-value = 0.01331
# Fligner-Killeen:med chi-squared = 7.3534, df = 4, p-value = 0.1184
bartlett.test(df_4pm_test_set$In.Attendance, df_4pm_test_set$TeacherID)
fligner.test(df_4pm_test_set$In.Attendance, df_4pm_test_set$TeacherID)

# 530PM is OK to ANOVA 
# Bartlett's K-squared = 6.004, df = 4, p-value = 0.1988
# Fligner-Killeen:med chi-squared = 4.7919, df = 4, p-value = 0.3093
bartlett.test(df_530pm_test_set$In.Attendance, df_530pm_test_set$TeacherID)
fligner.test(df_530pm_test_set$In.Attendance, df_530pm_test_set$TeacherID)

# 545PM is OK to ANOVA 
# Bartlett's K-squared = 4.7787, df = 5, p-value = 0.4435
# Fligner-Killeen:med chi-squared = 5.98, df = 5, p-value = 0.3082
bartlett.test(df_545pm_test_set$In.Attendance, df_545pm_test_set$TeacherID)
fligner.test(df_545pm_test_set$In.Attendance, df_545pm_test_set$TeacherID)

# 7PM is OK to ANOVA 
# Bartlett's K-squared = 5.6058, df = 4, p-value = 0.2306
# Fligner-Killeen:med chi-squared = 5.3464, df = 4, p-value = 0.2536
bartlett.test(df_7pm_test_set$In.Attendance, df_7pm_test_set$TeacherID)
fligner.test(df_7pm_test_set$In.Attendance, df_7pm_test_set$TeacherID)

# we can do ANOVA testing, but I really think the bigger issue is utilization

df_recent$utilization = df_recent$In.Attendance / df_recent$Class.Size
hist(na.omit(df_recent$utilization), main='Current utililization distribution', xlab = 'utilization')
mean(na.omit(df_recent$utilization)) #26.2%
median(na.omit(df_recent$utilization)) #22.5%

df_old <- df[as.Date(df$Date, "%m/%d/%y") <= as.Date('08/01/15', "%m/%d/%y"),]
df_old$utilization = df_old$In.Attendance / df_old$Class.Size
hist(na.omit(df_old$utilization[df_old$utilization <= 1]), main='Pre-2015 utilization distribution', xlab = 'utilization')
mean(na.omit(df_old$utilization[df_old$utilization <= 1])) #27.3%
median(na.omit(df_old$utilization[df_old$utilization <= 1])) #24.2%

df_2013 <- df[as.Date(df$Date, "%m/%d/%y") < as.Date('01/01/14', "%m/%d/%y") & as.Date(df$Date, "%m/%d/%y") >= as.Date('01/01/13', "%m/%d/%y"),]
df_2013$utilization = df_2013$In.Attendance / df_2013$Class.Size
hist(na.omit(df_2013$utilization[df_2013$utilization <= 1]), main='2013 utilization distribution', xlab = 'utilization')
mean(na.omit(df_2013$utilization)) #32.7%
median(na.omit(df_2013$utilization)) #28.3%


mean(na.omit(df_2013$In.Attendance)) #32.3
mean(na.omit(df_2013$Class.Size)) #106.0

mean(na.omit(df_recent$In.Attendance)) #23.3
mean(na.omit(df_recent$Class.Size)) #100.7

# compute ANOVA for ANOVA appropriate times

# 6AM no statistically significant difference between top 5 teachers
# Pr(>F) = 0.64 > 0.05, and qf(...) = 254.0164 > 0.2191
'
Analysis of Variance Table

Response: df_6am_test_set$In.Attendance
Df  Sum Sq Mean Sq F value Pr(>F)
df_6am_test_set$TeacherID   1     6.5  6.4842  0.2191   0.64
Residuals                 428 12666.7 29.5952
'
fit = lm(formula = df_6am_test_set$In.Attendance ~ df_6am_test_set$TeacherID)
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
fit = lm(formula = df_9am_test_set$In.Attendance ~ df_9am_test_set$TeacherID)
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
fit = lm(formula = df_530pm_test_set$In.Attendance ~ df_530pm_test_set$TeacherID)
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
fit = lm(formula = df_545pm_test_set$In.Attendance ~ df_545pm_test_set$TeacherID)
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
fit = lm(formula = df_7pm_test_set$In.Attendance ~ df_7pm_test_set$TeacherID)
anova (fit)
qf(0.950, 265, 1)








