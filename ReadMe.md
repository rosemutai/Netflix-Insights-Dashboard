# Netflix Content Insights Dashboard

![Power BI Dashboard](https://github.com/rosemutai/Netflix-Insights-Dashboard/blob/main/images/dashboard.png)

**Tools Used:**
* SQL
* Power BI

**Skills Demonstrated:** 
* Data Cleaning
* Data Modeling
* DAX
* Data Visualization
* Business Insight Generation

## Project Overview
This project analyzes Netflix titles data to uncover trends in content production, genre distribution and international expansion.
The goal was to transform raw data into a **decision-support dashboard** that provides insights into:
* Content growth over time
* Genre performance
* Country-level production trends
* Strategic shifts in Netflix’s content investments

## Business Questions
This analysis was designed to answer key strategic questions:
1. Which countries are leading in content production?
2. What are the most dominant and fastest-growing genres?
3. Is Netflix shifting towards international or local content?
4. What insights can inform future content investment decisions?

## Data Preparation (SQL)
The dataset required significant cleaning and transformation before analysis:
* Split multi-value columns (e.g., cast, category, country) into normalized tables
* Handled missing values in country, director and category fields
* Standardized inconsistent category labels (e.g., “TV Dramas” vs “Dramas”)
* Created structured tables for:
  * Titles
  * Categories
  * Directors
  * Countries
  * Casts
This ensured accurate aggregation and reliable insights.

## Dashboard Features (Power BI)
### Key KPIs
* Total Titles
* Number of Countries
* Movies vs TV Shows Count
* Most Common Rating
* Top Growing Genre

### Trend Analysis
* Yearly growth of Movies and TV Shows
* Identification of rapid expansion starting around 2015

### Genre & Category Insights
* Distribution of content by category
* Identification of dominant genres such as International Movies and Dramas

### Country-Level Analysis
* Top countries producing Netflix content

### Advanced Features
* Dynamic titles that update based on filters
* Year-over-Year growth analysis
* Identification of top growing genres

## Key Insights
### 1. Rapid Content Expansion
Netflix experienced a significant increase in content production after 2015 with total titles increasing within a few years.
**This reflects Netflix’s aggressive global expansion strategy.**

### 2. Dominance of International Content
International Movies emerged as the most dominant category, surpassing traditional Hollywood-focused content.
**This indicates a shift toward global audience targeting.**

### 3. United States Leads — But Diversification is Rising
While the United States remains the top content producer, other countries (e.g., India, UK) are rapidly increasing their contributions.
**Netflix is diversifying its content sources to reduce reliance on a single market.**

### 4. Genre Growth Trends
Certain genres show significantly higher growth rates than others, highlighting evolving audience preferences, TV Thrillers is the fastest growing genre.

## Business Recommendations
Based on the analysis:
* Invest more in **TV Thrillers genres**
* Expand partnerships in emerging markets (e.g., India, UK)
* Continue scaling content production post-2015 trend

## Project Impact
This project demonstrates the ability to:
* Transform raw data into meaningful insights
* Build interactive dashboards for decision-making
* Apply SQL and Power BI in a real-world business context
* Communicate insights clearly to stakeholders

## Conclusion
This analysis highlights Netflix’s transition from a regional content provider to a **global streaming leader**, driven by strategic investments in international content and rapid scaling of its content library.


## Future improvements
* Predictive modeling for content success
* Viewer engagement analysis
* Recommendation system for content strategy
