# SQL_Projects

# Global Layoffs Data Exploratory in SQL

This project showcased an end-to-end SQL Exploratory Data Analysis (EDA) on global tech industry layoffs, designed to uncover insights about workforce reductions across companies, industries, and countries.

## Project Overview  
The analysis was performed on a cleaned staging dataset (layoffs_staging2) and explored both aggregate and time-based trends using SQL techniques.
- **Tools:** MySQL Workbench
- **Techniques:** Data aggregation and grouping, CTEs (Common Table Expressions) and window functions, ranking and rolling totals, time-series analysis, exploratory data profiling (MAX, MIN, COUNT, SUM, GROUP BY)
- **My Role:** Optimized SQL queries and prepared analysis-ready data for visualization tools.

## Key Contributions  
- Explored structure and time coverage using aggregate metrics and date range queries.
- Used CTEs and rolling totals to evaluate monthly and cumulative layoffs over time.
- Implemented DENSE_RANK() to determine top 5 companies by total layoffs each year.
- Aggregated layoffs by industry, stage, and country to identify sectors most impacted.

## Visuals  
![Layoff Trends by Month](images/Screenshot%202025-11-04%20093104.png)
*Monthly Layoff Totals Across the Dataset*

![Top Companies by Layoffs](images/Screenshot%202025-11-04%20093120.png)
*Top Companies Ranked by Workforce Reductions*

![Layoffs by Industry](images/Screenshot%202025-11-04%20093130.png)
*Industry Comparison Highlighting Tech Sector Impact*

![Layoffs by Country](images/Screenshot%202025-11-04%20093152.png)
*Geographic Distribution of Layoffs*

![Rolling Total of Layoffs Over Time](images/Screenshot%202025-11-04%20093210.png)
*Cumulative Layoff Progression and Recovery Trends*

## Takeaways
- Significant layoff surges aligned with global economic downturns and funding contractions.
- Early-stage startups and late-stage tech giants both showed vulnerability, but for different reasons — funding vs. scale adjustments.
- The U.S. and software sectors accounted for the majority of reported layoffs.
- Rolling and year-over-year trends provided a clear timeline of how layoffs accumulated and evolved.

## Next Steps
- Build interactive dashboards in Power BI or Tableau to visualize trends and company comparisons.
- Apply time-series forecasting using Python or RStudio to predict future layoff trends.
- Combine layoff data with external indicators such as funding rounds, stock performance, or economic data for deeper insights.
