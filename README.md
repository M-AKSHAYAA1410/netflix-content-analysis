# netflix-content-analysis
Netflix Content Analysis | Python, Pandas, NumPy, Matplotlib, Seaborn &amp; MySQL  Analyzed Netflix Movies and TV Shows catalogue data to explore content-type distribution, genre patterns, release-year trends, country-wise content and ratings using Python-based data analysis, visualization and SQL queries.
# Netflix Content Analysis

## Project Overview
This project explores the Netflix Movies and TV Shows dataset using Python and MySQL to identify content distribution patterns and catalogue trends.

## Objectives
- Compare Movies and TV Shows.
- Identify the most frequently listed genres.
- Analyse content by release year.
- Explore country-wise content distribution.
- Examine content ratings.
- Analyse yearly catalogue additions.

## Tools and Technologies
- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- MySQL
- Google Colab
- MySQL Workbench

## Dataset
The project uses the Netflix Movies and TV Shows dataset, containing 8,807 titles and 12 original columns. The cleaned dataset includes an additional `year_added` column for analysing catalogue additions.

Dataset source: [Netflix Movies and TV Shows — Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)

## Key Findings
- **Content type:** 6,131 Movies (69.62%) and 2,676 TV Shows (30.38%).
- **Top genre:** International Movies, with 2,752 titles.
- **Release year:** 2018 has the highest number of titles in the dataset, with 1,147.
- **Top country:** United States, with 3,690 titles after splitting country names.
- **Top rating:** TV-MA, with 3,207 titles.
- **Catalogue additions:** 2019 has the highest recorded additions, with 2,016 titles.

## Project Files
- `Netflix_Data_Exploration.ipynb` — Python data exploration and visualisations.
- `netflix_analysis.sql` — SQL queries for content analysis.

## Important Note
- This analysis is based on the Netflix dataset snapshot available on Kaggle and may not represent Netflix's current catalogue.
- A title may be associated with multiple countries and genres, so country-wise and genre-wise counts may overlap.
- Missing values were handled during data cleaning.
- The number of titles does not directly indicate viewership, popularity or audience demand.
- Catalogue addition trends are based only on the `date_added` values available in the dataset.
## Author
Akshayaa M
