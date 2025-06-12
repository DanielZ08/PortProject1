This Repository contains files that have been used for my portfolio projects. Feel free to check them out, and please reach out if you have any questions and/or inquiries.


**Covid 19 - SQL Data Exploration Project Overview:**

This project involved analyzing a comprehensive dataset of global COVID-19 data from 2020 to 2022. The objective was to uncover insights related to infection rates, mortality trends, and vaccination progress across different countries and continents. The analysis was performed using raw data from Excel files imported into SQL Server.

**Goals:**
- To Understand the spread and impact of COVID-19 across different regions.
- Identify patterns in infection, death, and vaccination rates.
- Apply advanced SQL techniques to clean, transform, and analyze data.
- Prepare data for potential visualization in BI tools like Tableau or Power BI.

**Key Steps and Techniques
Data Preparation & Cleaning:**
- Filtered out non-country records by excluding null continent values.
- Standardized data types (e.g., casting death counts as integers) for accurate analysis.

**Exploratory Data Analysis:**
- Analyzed the correlation between total cases and deaths to determine fatality rates.
- Measured infection rates as a percentage of the population to gauge virus spread.

**Comparative Analysis:**
- Ranked countries by infection and death rates.
- Evaluated continents based on aggregated death counts.

**Time-Series Insights:**
- Used grouped daily totals to track the global progression of new cases and deaths.
- Calculated global death percentages over time.

**Vaccination Analysis:**
- Joined COVID deaths and vaccination datasets by date and location.
- Used window functions to calculate a rolling total of vaccinations.
- Estimated the percentage of population vaccinated over time.

**Advanced SQL Use:**
- Common Table Expressions (CTEs): Structured vaccination data for intermediate calculations.
- Temporary Tables: Stored intermediate results to enable flexible queries and comparisons.
- Views: Created a reusable view to simplify reporting and dashboard integration.

**Outcome**
- Delivered a clean, organized SQL workflow to support COVID-19 visualizations and dashboards.
- Gained actionable insights into the impact and response to the pandemic.
- Strengthened proficiency in SQL for real-world data analysis scenarios.

**What I Learned**
- How to use SQL window functions for time-based cumulative analysis.
- The value of structuring queries for scalability using CTEs and views.
- The importance of data preprocessing for accurate public health reporting.
