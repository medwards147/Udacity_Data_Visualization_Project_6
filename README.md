##Data Visualization: Prosper Loan Data
Author: Max Edwards
Files:
- `index_rev1.html`
-` index_rev2.html`
- `index_final.html`
- `index_rev1.jpg`
- `index_rev2.jpg`
- `index_final.jpg`
- `prosper_clean.csv`
- `prosper_data-dictionary.txt`
- `clean_prosper.R`
- `explore_prosper.R`

### Project Summary
This data visualization provides [Prosper.com loan data](https://www.google.com/url?q=https://s3.amazonaws.com/udacity-hosted-downloads/ud651/prosperLoanData.csv&sa=D&usg=AFQjCNGy13Kf5et82IoAUpLX68qW61M8DA) estimated returns by Prosper Credit Rating by month between 2011 and 2014. The programming language R was used to clean and explore the raw data file. A cleaned version of this file was used to generate the visualization using the d3.js library.

### Visualization Design and Feedback
I approached the development this visualization from the perspective of a potential investor by thinking about what one would be interested in understanding prior investing in a prosper loan.  I believe the first thing an investor would look for is past performance. However, this data did not include actual past performance so I decided to plot estimated returns on the notion that they are a good indicator of past actual performance. By doing this, I am making the assumption Prosper’s algorithm or methodology to calculate their interest rates (the main variable used to derive estimated return) incorporates past performance. For the sake of this project, I believe this is a safe assumption.

#### Explore the Data
Prior to developing the visualization, I loaded the data into R to perform exploratory analysis. The dataset consisted of xxxxx rows and xxxxx  columns. I was able to quickly eliminate a lot of the columns as most of the data would not be available to a prospective investor prior to making an investment. I narrowed down the data down to the following variables:
- `ProsperRating(Alpha)`
- `EstimatedReturn`
- `EstimatedLoss`
- `LoanOriginationDate`
I decided a line chart would be most appropriate to display time-series data and decided to distinguish Prosper’s Rating for the loan by the line color. Below is an example of the notional chart I created with R ggplot2 package that I will implement in D3.js.
![R_plot](githublink_to_picture_file)
After exploration, I decided to clean the data by making the following adjustments:
- Remove any data prior to 2011. Prosper adjusted their method for estimated return calculations starting in 2011. I was unable to normalize 2009 to 2011 as I don't know exactly what they changed. Therefore the chart will show 2011 through March 2014. 

#### Create Visualization with D3.js
Leveraging the plot I created in R, I was able to create the first iteration of my plot with d3.js shown below. The code for this plot is provided in `index_rev1.html`. 
![Revision_1_plot](https://github.com/medwards147/Udacity_Data_Visualization_Project_6/blob/master/plots/rev1_timeseries_screenshot.png)

#### Visualization Feedback
I interviewed three people to collect un-biased feedback in order to improve upon my visualization.  First, I had to explain about Prosper.com and peer to peer lending in general. Then, I asked them with questions. The following section provides each question with a summary of each response for two people (labeled "i" and "ii" after each question). I received feedback from a third person on in a follow-on version after I updated my chart in response to the initial feedback.

- What do you notice in the visualization?
    1. All rating trends are showing decreasing estimated returns
    2. It looks like Skittles "Taste the Rainbow". 
Note: my wife's feedback is a little more useful after her answer (#2).

- What questions do you have about the data?
    1. Why wouldn’t I invest in “HR” Prosper Rating every time? 
    2.  What do the different ratings mean? Why wouldn't I invest in the blue or orange every time?

- What relationships do you notice?
    1. All of the returns show a decreasing trend
    2. All trends are very similar
- What do you think is the main takeaway from this visualization?
    1. Prosper has 7 different ratings you can choose from
    2. More loans issued overtime with lower estimated returns by month

- Is there something you don’t understand in the graphic?
	1. As I said before, the graphic is useful to understand the returns for each Prosper Rating over time. I just don't know why I wouldn't invest in	Rating HR (blue line) every time. Also, I noticed I could hover over the points to display a tooltip but found that out by mistake. Maybe indicate that is an option. 
	2. I understood everything. I'd suggest indicating what each Rating actually means. 


#### Next Iteration Visualization with D3.js – Incorporating Feedback
I quickly realized that my graphic doesn't really help a potential investor after reading the feedback I received. The main issue is that each rating only shows average returns, which of course are higher for the higher risk ratings. That is because given a large enough sample size, estimated average returns should be higher for the higher risk loans by definition (Note: actual returns may be different over a given period). Given the feedback and this realization, I decided to change my approach by creating a graphic that does a better job at showing the variation. The following picture provides my new plot with a Prosper Rating ordinal scale instead of a time series scale. Estimated returns are now shown for each individual loan (represented by the dashes) and summary statitics (5th percentile, 95th percentile, and mean) are shown by the larger circles. This plot (live version) also allows you to view each year inidividually by clicking the appropriately labeled 'radio' button.


### References
1.	http://alignedleft.com/tutorials/d3
2.	http://stackoverflow.com
