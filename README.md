# SQL Projects

# World Energy Consumption ☀️

This project involved advanced SQL data engineering and analytical skills through a complete workflow for cleaning, transforming, and analyzing a global energy consumption dataset.

## Project Overview

This SQL script automated backup creation, data quality checks, column reduction, and EDA to uncover global trends in energy usage, fossil fuel reliance, and renewable adoption across countries.
- **Tools:** Microsoft's SQL Server Management Studio (SSMS) 
- **Techniques:** Data Backup and validation, NULL value handling, deduplication, aggregation and aomparative Analysis (GDP, Population, Energy), year-over-year trend analysis, ranking
- **My Role:** Designed SQL workflow to prepare raw energy consumption data for business intelligence by performing data cleaning, schema management, and analysis logic.

## Key Contributions
- Ensured data preservation with a full backup table for version control and rollback capability.
- Identified columns with 80–90% null values and safely dropped non-informative attributes to optimize query performance.
- Used pattern matching to eliminate aggregated and regional data (ie. "OECD", "Africa", "Other income") for cleaner country-level analysis.
- Performed EDA: Ranked top 10 energy-consuming countries globally, compared GDP and population against average energy use, analyzed fossil fuel vs. renewable energy trends over time, highlighted top countries with the fastest energy growth and lowest carbon share.
- Verified schema consistency, null distribution, and proper data types.

## Visuals

### Top 10 Energy Consuming Countries in 2022

![Top 10 Energy Consuming Countries in 2022](images/Screenshot%202025-11-04%20105848.png)

### Top 10 Energy Consumption per Capita in 2022

![Top 10 Energy Consumption per Capita in 2022](images/Screenshot%202025-11-04%20105919.png)

### Total Energy Consumption by Year

![Total Energy Consumption by Year](images/Screenshot%202025-11-04%20105944.png)

### Country GDP by Average Primary Consumption

![Country GDP by Average Primary Consumption](images/Screenshot%202025-11-04%20110048.png)

### Average Country Population vs. Energy Consumption

![Average Country Population vs. Energy Consumption](images/Screenshot%202025-11-04%20110115.png)

### Top 10 Countries With Highest Energy Growth

![Top 10 Countries With Highest Energy Growth](images/Screenshot%202025-11-04%20110143.png)

### Top 10 Countries With Lowest Carbon Emissions in 2022

![Top 10 Countries With Lowest Carbon Emissions in 2022](images/Screenshot%202025-11-04%20110219.png)

### Total Global Energy Consumption by Year

![Total Global Energy Consumption by Year](images/Screenshot%202025-11-04%20110248.png)

### Energy Source Comparison

![Energy Source Comparison](images/Screenshot%202025-11-04%20110331.png)

### Final Data Cleaning Preparation

![Final Data Cleaning Preparation](images/Screenshot%202025-11-04%20110447.png)

## Takeaways
- Significant data redundancy and incomplete attributes were optimized, reducing column count from 129 to 104.
- Demonstrated the impact of economic (GDP) and demographic (Population) factors on national energy consumption patterns.
- Identified a clear upward trend in renewable energy adoption, contrasted by sustained reliance on fossil fuels in industrialized nations.

## Next Steps
- Build interactive dashboards to visualize country comparisons and long-term energy trends. (See Power BI Dashboard Project)
- Implement stored procedures for routine data cleaning and ingestion.
- Build a predictive model to forecast future global energy demands and renewable adoption rates.



---



# World Layoffs Data Cleaning in SQL 🌎

This project demonstrated an end-to-end SQL data cleaning process on a global layoffs dataset, with a focus on ensuring data accuracy, consistency, and readiness for analysis.

## Project Overview  
This analysis covered duplicate removal, data standardization, NULL value handling, and structural optimization using advanced SQL techniques.
- **Tools:** MySQL Workbench
- **Techniques:** Window functions (ROW_NUMBER() OVER(PARTITION BY ...)) for duplicate detection, self-joins for NULL value imputation, CTEs for data validation, TRIM(), STR_TO_DATE(), and conditional updates for data standardization
- **My Role:** Developed and executed a complete SQL-based data cleaning workflow, from data import and staging through normalization, validation, and schema optimization.

## Key Contributions
- Used window functions and CTEs to identify duplicate records and implemented a robust deletion strategy to retain unique entries.
- Cleaned company names and standardized industry categories (ie. normalizing “Crypto” variations).
- Trimmed inconsistent whitespace and punctuation in country names.
- Converted date fields from text to a proper SQL DATE type for time-series analysis.
- Identified missing data and used self-joins to populate industries for companies appearing in multiple rows.
- Removed rows with irrecoverable NULLs in key columns like total_laid_off and percentage_laid_off.
- Dropped intermediate columns (row_num) and finalized a clean, analysis-ready dataset (layoffs_staging2).

## Visuals  

### CTE Showing Duplicate Records

![CTE Showing Duplicates](images/Screenshot%202025-11-04%20103050.png)

### Trimmed Company Names

![Trimmed Company Names](images/Screenshot%202025-11-04%20103213.png)

### Date Formatting Normalization

![Date Formatting Normalization](images/Screenshot%202025-11-04%20103359.png)

## Takeaways
- Strengthened understanding of data quality assurance.
- Gained experience using window functions and CTEs for complex data integrity operations.
- Demonstrated the ability to transform raw, inconsistent data into a structured dataset.
- Improved SQL optimization skills for handling large-scale cleaning tasks efficiently.

## Next Steps
- Integrate the cleaned dataset into Power BI or Tableau for visual trend analysis.
- Automate the cleaning pipeline using stored procedures or ETL workflows.



---



# World Layoffs Data Exploratory in SQL 🚫

This project showcased an end-to-end SQL Exploratory Data Analysis (EDA) on global tech industry layoffs, designed to uncover insights about workforce reductions across companies, industries, and countries.

## Project Overview  
The analysis was performed on a cleaned staging dataset (layoffs_staging2) and explored both aggregate and time-based trends using SQL techniques.
- **Tools:** MySQL Workbench
- **Techniques:** Data aggregation and grouping, CTEs and window functions, ranking and rolling totals, time-series analysis, exploratory data profiling (MAX, MIN, COUNT, SUM, GROUP BY)
- **My Role:** Optimized SQL queries and prepared analysis-ready data for visualization tools.

## Key Contributions  
- Explored structure and time coverage using aggregate metrics and date range queries.
- Used CTEs and rolling totals to evaluate monthly and cumulative layoffs over time.
- Implemented DENSE_RANK() to determine top 5 companies by total layoffs each year.
- Aggregated layoffs by industry, stage, and country to identify sectors most impacted.

## Visuals  

### Top Companies by Layoffs

![Top Companies by Layoffs](images/Screenshot%202025-11-04%20093104.png)

### Top Industry by Layoffs

![Top Industries by Layoffs](images/Screenshot%202025-11-04%20093120.png)

### Layoffs by Country

![Layoffs by Country](images/Screenshot%202025-11-04%20093130.png)

### Total and Rolling Layoff Trends by Month

![Layoff Trends by Month](images/Screenshot%202025-11-04%20093152.png)

### Top Companies by Layoffs Over Time

![Rolling Total of Layoffs Over Time](images/Screenshot%202025-11-04%20093210.png)

## Takeaways
- Significant layoff surges aligned with global economic downturns and funding contractions.
- Early-stage startups and late-stage tech giants both showed vulnerability, but for different reasons — funding vs. scale adjustments.
- The U.S. and software sectors accounted for the majority of reported layoffs.
- Rolling and year-over-year trends provided a clear timeline of how layoffs accumulated and evolved.

## Next Steps
- Build interactive dashboards in Power BI or Tableau to visualize trends and company comparisons.
- Apply time-series forecasting using Python or RStudio to predict future layoff trends.
- Combine layoff data with external indicators such as funding rounds, stock performance, or economic data for deeper insights.
