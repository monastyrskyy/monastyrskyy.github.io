---
title: "Phishing Websites Capstone Project"
date: 2020-2-8
excerpt: "This is the first Capstone Project of my 6-month Springboard Data Science Career Track Bootcamp. In this project I analyze a dataset of website features in order to predict whether the website is phishing or legitimate."
mathjax: "true"
tags: [bootcamp, python, machine learning]
#classes: wide # frontmatter that should make the page wider.
toc: true
toc_label: "Table of Contents"

defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      comments: true
      share: true
      related: true
---

<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>

## Problem Statement (Mock)
With the ever-expanding reach of digital technology, online security savviness of the average internet user must expand, too. For this reason, a web browser company has asked its data science team to predict whether a website is “phishing” for information from vulnerable users. The company aims to use the findings from the team’s report to display a redirect message to its users indicating that they are clicking on a link that may potentially steal their information.<br/>

## Data
### Data overview
Data:<a href="https://archive.ics.uci.edu/ml/machine-learning-databases/00327/ " target="blank">UCI Machine Learning (ML) Archive</a><br/>

Each of the datasets number rows contains an observation of one website as well as its phishing status, determined by an expert. Some 30 features of the dataset include “Redirect”, “Favicon”, and “URL_length”, each of which will be further explained in the report. The dataset is provided by the web browser company, and all variables collected were predetermined to be of at least some interest in deciding whether a website is a phishing website or not.<br/>

### Loading the data
I loaded the data as a Pandas dataframe called ‘data’ into my Python environment from a ‘.csv’ file. I had several flat file options in addition to ‘.csv’ such as ‘.arff’ and ‘.xslx’, but ‘.csv’ proved to be the most convenient. The data consisted of 31 column names in the first row, and values in the following 11055 rows. The data did not contain any additional information such as comments, extra sheets, definitions, etc., which is why I did not specify any additional arguments when loading the data.<br/>

### Resetting the index to start at 0.
The original raw data had an ‘index’ column that started with the integer 1. The reason I didn’t load the ‘index’ column available in the data as a Pandas index is because I wanted my index column to start at 0 to match the Python convention. I did this through a series of column transformations.<br/>

### Renaming the columns to be more legible
The raw data had column names with repeating words (e.g. ‘URLURL_Length’ and ‘having_IPhaving_IP_Address’), misspelled words (e.g. ‘Shortining_Service’), and not consistently capitalized words (e.g. ‘having_At_Symbol’). I renamed the columns to be more legible and more easily understandable, by making each column name lowercase, separating each word with an underscore, and changing some names to better match the meaning of the values (e.g. ‘Domain_registeration_length’ to ‘domain_registeration_period’).<br/>

### Data dictionary
Due to the nature of the data provided by the original source: M. Mohammad, Thabtah, and McCluskey, the values available in the data were not clear. All features were optimized for machine learning through a conversion to 2 or 3 categorical values such as ‘-1,1’ or ‘-1,0,1’. Fortunately, a column definition document was provided by the original owners of the data and is available in the GitHub project folder. Unfortunately, the document doesn’t clearly specify which human-understandable values map onto which values in the dataset. This is where I had to make informed decisions to map the values.<br/>

My methodology consisted of a combination of prior knowledge, relying on the data document, and looking at the ‘result’ variable to match the values available in the data to the definitions in the data document. I then put this information into a nested dictionary for easy graphing, information extraction, and analysis in the future. The other option was to make a copy of the data and replace every value with a human-understandable definition, but for space complexity reasons, I chose to go with a hash table instead.<br/>

### Missing values & outliers
I first checked each column for null values using the Pandas ‘.isnull()’ method. This returned no missing values. I then ran a ‘set’ function over every column of the data frame to check for non-traditional or misspelled missing values such as ‘N/A’, ‘NUL’, ‘na’, ‘missing’, etc. The results of this function confirmed the results above, meaning no unexpected entries existed in any of the columns.<br/>

Traditional methods for checking for outliers such as boxplots, histograms, and scatterplots were not applicable with the raw data, because every variable was categorical. So, using the set method discussed above, I also check for outliers, which resulted in no visible outliers. In the next steps of this project, where I take a look at the data visually, outliers that were not found with the ‘set’ method, might show up then.<br/>


## Exploratory Data Analysis - Overview
To get a good idea of what the data look like, I made a composite stacked bar graph showing the label variable distribution for each feature. Below is an example of one feature that I explain in detail in a later paragraph.<br/>

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download1.png" alt="Picture"></div><br/>

On the left is a stacked bar graph of the total counts of phishing vs legitimate websites within each of the two categories of the feature ‘url_contains_ip_address’, namely ‘T’ and ‘F’. This bar shows how the counts of ‘T’ and ‘F’ compare to each other, as well as how the distribution of phishing vs legitimate websites looks for each category.<br/>

On the right is a stacked bar that shows the proportion of legitimate websites for each of the categories of the feature shown. By changing the x-axis from counts to percentage I hope to make it easy to see the difference in proportions of phishing websites for each category ‘T’ and ‘F’. I also add a reference line representing what proportion phishing websites make up of the original data in order to show not only how the categories compare to each other but also to the sample average.<br/>

I repeated this process for every feature in the dataset, resulting in 30 plots available in the code of this project. After generating these plots I looked through them to see which features stray the furthest away from the sample average. These will likely be the features that my models will use in the future to predict the label, which gives me direction for some statistical inference.<br/>

Below I listed several other graphs where the bars tend to stray away from the overall sample proportion because these variables might have a lot of decision power in the prediction stage. While these visualizations served to get me familiar with the data, in a later stage I will apply more rigorous methods that will allow me to make stronger claims about which columns are important.<br/>

```Python
pal = ['#eb4c46', '#cccccc'] #choice of colors

# overall sample proportion of phishing websites
prop_phish = pd.DataFrame((data.groupby('result').size())/(data.groupby('result').size().sum())).loc[-1, 0]

# for loop that prints the viz for each feature
for column in data.columns:
    if column == 'result':
        pass
    else:
        # Figure specs
        fig = plt.figure(figsize=(14, 3), dpi=140)
        fig.suptitle(column, fontsize=16, y=1.05)

        # Divide the figure into a 1x2 grid, and give me the first section
        ax1 = fig.add_subplot(121)

        # Divide the figure into a 1x2 grid, and give me the second section
        ax2 = fig.add_subplot(122)

        # Left groupby and plot
        g_count = data.groupby([column, 'result']).size().unstack('result') # count of each category
        g_count.plot.barh(stacked = True, ax = ax1, color = pal).invert_xaxis() # barplot
        ax1.yaxis.tick_right()
        ax1.set_ylabel('')
        ax1.set_yticklabels(data_dict[column].values())
        ax1.axvline(0, color='#5868a8', linewidth=1.5, linestyle = '-.', label = 'Horizontal') # adding only for the legend (not visible line)
        ax1.legend(labels=['% Phishing in Entire Sample', 'Phishing', 'Legitimate'])
        ax1.set_title('Observed Counts')


        # Right groupby and plot
        g_count2 = data.groupby([column, 'result']).size().unstack(column)
        p = g_count2.divide(g_count2.sum())
        plot2 = p.transpose().plot.barh(stacked = True, ax = ax2, color = pal)
        ax2.get_legend().remove()
        ax2.axvline(prop_phish, color='#5868a8', linewidth=1.5, linestyle = '-.')
        ticks = np.round(ax2.get_xticks()*100)
        ax2.set_xticklabels(['{:}%'.format(j) for j in [str(i) for i in ticks]])
        ax2.set_ylabel('')
        ax2.set_yticklabels('')
        ax2.set_title('Percent of Total')

        fig.tight_layout()
```

<br><br/>

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download2.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download3.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download4.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download5.png" alt="Picture"></div>



## Statistical Inference
The barplot visualization shows that some features stray further from the sample proportion of phishing websites than others. To develop some hypotheses about what features will be influential in model selection, I first filtered down to the ‘interesting’ features with the following method. For each category of each feature, I ran a 10,000 size bootstrap sample of the ‘result’ label variable. I then took this information to calculate a 99.9% confidence interval for the proportion that phishing websites made up of that group. If the overall proportion of phishing websites in the whole sample was outside of the 99.9% CI for at least two of the categories of a feature, I labeled that feature as ‘interesting’. The number of phishing websites that have these ‘interesting’ features will either be significantly higher or lower than the sample average, at 99.9% confidence. This might then suggest that these features will have a lot of influence when building models and may have high predictive power in whether a website is phishing or legitimate. Below is a list of the ‘interesting’ columns.<br/>

```python
# Defining necessary functions to see which groups are interesting
def one_minus_mean(data):
    result = 1 - np.mean(data)
    return result


# courtesy of https://campus.datacamp.com/courses/statistical-thinking-in-python-part-2/bootstrap-confidence-intervals?ex=6
def bootstrap_replicate_1d(data, func):
    return func(np.random.choice(data, size=len(data)))

def draw_bs_reps(data, func, size=1):
    """Draw bootstrap replicates."""

    # Initialize array of replicates: bs_replicates
    bs_replicates = np.empty(size)

    # Generate replicates
    for i in range(size):
        bs_replicates[i] = bootstrap_replicate_1d(data, func)

    return bs_replicates

# changing this to be able to take mean of the bootstrap samples.
data.result[data.result == -1] = 0


# big checking function
# bootstrap replicates
# function automatically selects columns where the pop. prop. of phishing is outside the CI

high_interesting_columns = []
low_interesting_columns = []

for i in data.columns[:30]:    # excluding the result variable
    for j in set(data[i]):     # iterating over possible cateogies
        loop_data = data.result[data[i] == j]    # getting result variable for each category of each feature
        bs_replicates = draw_bs_reps(data=loop_data, func=one_minus_mean, size=10000)
        ci = np.percentile(bs_replicates, [.05, 99.95])
        if ((prop_phish < ci[0])): #interested in the high proportions
            high_interesting_columns.append(i)
        elif ((prop_phish > ci[1])): #low interesting columns
            low_interesting_columns.append(i)

    if high_interesting_columns != []:    # check for error when list is empty
        if sum(np.array(high_interesting_columns) == i) == 1:    # removing any columns where only 1 feature was out of CI
            high_interesting_columns.remove(i)
    if low_interesting_columns != []:    # check for error when list is empty
        if sum(np.array(low_interesting_columns) == i) == 1:    # removing any columns where only 1 feature was out of CI
            low_interesting_columns.remove(i)

high_interesting_columns = list(set(high_interesting_columns))    # removing duplicate entries
low_interesting_columns = list(set(low_interesting_columns))

print('Interesting columns with CI above sample proportion:', high_interesting_columns)
print('Interesting columns with CI below sample proportion:', low_interesting_columns)
```
<br><br/>

Interesting columns with CI above sample proportion:
['ssl_final_state', 'web_traffic', 'url_contains_sub_domain']
Interesting columns with CI below sample proportion:
['links_pointing_to_page', 'url_of_anchor', 'sfh', 'links_in_tags']<br/>

Merely looking at a list of feature names doesn’t tell me too much, so the next step would be to visualize the features somehow.<br/>

## Exploratory Data Analysis - Closer Look
To visualize the data within the ‘interesting’ columns, I want to display the proportion of phishing websites within each combination of categories for each combination of features. Below is a crosstab example of what I mean, as well as the relevant code.<br/>

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download6.png" alt="Picture"></div><br/>

```Python
# Creating a hash table of every combination of interesting columns
# Each key in hash table contains heatmap table of combinations of interesting columns

# custom aggregation function
def prop(series):
    return round(sum(series)/len(series), 2)

#scalable solution
def heatmap_dict(heatmap_dict, interesting_columns):
    heatmap_dict = {}

    for i in range(len(interesting_columns)):
        for j in range(i+1, len(interesting_columns)):
            working_df = data[[interesting_columns[i], interesting_columns[j], 'result']].\
                         groupby([interesting_columns[i], interesting_columns[j]]).agg(prop).unstack(interesting_columns[j])

            working_df.columns = working_df.columns.droplevel() # remove 'result' from columns multindex

            heatmap_dict[interesting_columns[i], interesting_columns[j]] = working_df

    return heatmap_dict

# Running the above function on both 'high' and 'low' interesting columns
low_heatmap_dict = {}
low_heatmap_dict = heatmap_dict(low_heatmap_dict, low_interesting_columns)
high_heatmap_dict = {}
high_heatmap_dict = heatmap_dict(high_heatmap_dict, high_interesting_columns)
```

In this crosstab, each combination of each category is plotted and the number it contains inside is the proportion of phishing websites of that group. Notice that this crosstab only compares two features: ‘sfh’ to ‘links_pointing_to_page’, whereas in my full analysis I want to compare each combination of features, and visually display the proportions of phishing websites, as shown below. The color switches from shades of blue to shades of red, depending on whether the proportion of phishing websites for each specific combination in the visualization is above or below the sample proportion of phishing websites. The darker the color, the bigger the absolute difference between the combination proportion and the sample proportion.<br/>

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download7.png" alt="Picture"></div><br/>

```Python
# Scalable plotting function of the above plots

def prop_phish_heatmap(heatmap_dict, interesting_columns):
    for i in range(len(interesting_columns)-1):    #number of rows of entire heatmap

        fig, axes = plt.subplots(nrows=1, ncols=len(interesting_columns)-1, figsize=(4,2), dpi = 180)    # num of columns with particular size
        plt.subplots_adjust(wspace=0, hspace=0)    # space between subplots
        cbar_ax = fig.add_axes([.91, .15, .01, .7])    # location of color bar

        for j, (k, ax) in zip(range(i+1, len(interesting_columns)), enumerate(axes)):

            im = sns.heatmap(heatmap_dict[interesting_columns[i], interesting_columns[j]], ax = axes[k+i], #puts blanks in beginning
                        square=True, annot = True, cmap='coolwarm', center=prop_phish,
                        yticklabels = list(data_dict[interesting_columns[i]].values()),    #legible labels
                        xticklabels = list(data_dict[interesting_columns[j]].values()),
                        cbar=k == 0, cbar_ax=None if k else cbar_ax, vmin = 0, vmax = 0.75) #colorbar details
            ax.xaxis.set_label_position('top')

            if ax in axes[1:9]:
                axes[k+i].set_ylabel('')
                axes[k+i].set_yticklabels('')
                axes[k+i].tick_params(axis='y', length=0)   
                # only keeps the y label for the first plot in each row

        for l in range(0,i):
                axes[l].axis('off')
                # I got it to work.
                # removes all labels from blank plots

#Plotting
prop_phish_heatmap(high_heatmap_dict, high_interesting_columns)
prop_phish_heatmap(low_heatmap_dict, low_interesting_columns)    
```

It’s interesting to note some patterns that emerge. For example, despite the number of links_pointing_to_page, the url_of_anchor has a clear pattern showing the websites with a small url_of_anchor portion tend to not be fishing websites. Another example is just how important sfh seems to be when the website contains an ‘about:blank’ section. From other heatmaps available in the Python Notebook, there are also some unexpected surprises in terms of trends, but most confirm what the bar graphs showed.<br/>

To show the scalability of this visualization method, I graphed all the non-interesting columns against each other to look for patterns that might be surprising. It’s interesting to note that there are several combinations that are made up of only legitimate websites.<br/>

Despite the versatility of this method, the machine learning portion of this report will be a far better measure of important columns along with the results of the model.<br/>

<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download8.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download9.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download10.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download11.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download12.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download13.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download14.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download15.png" alt="Picture"></div>
<div style="text-align:center"><img src="{{ site.url }}{{ site.baseurl }}/images/6.phishing_capstone/download16.png" alt="Picture"></div>
