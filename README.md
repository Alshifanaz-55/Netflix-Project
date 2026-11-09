# Netflix Movies and TV Shows Data Analysis using SQL

An end-to-end data analysis project using **SQL Server** to clean, process, and analyze a Netflix titles dataset. This project uncovers valuable insights regarding content distribution, ratings, genres, actors, directors, and trends over the years.

---

## 🛠️ Project Workflow

### 1. Data Cleaning & Preparation

Before diving into analysis, the dataset undergoes rigorous data hygiene checks:

* **Null Check:** Scans all columns (`show_id`, `type`, `title`, `director`, `cast`, `country`, `date_added`, `release_year`, `rating`, `duration`, `listed_in`, `description`) for missing values.
* **Handling Nulls & Empty Strings:** Cleans up rows with missing or empty critical metadata.
* **Duplicate Detection:** Uses `GROUP BY` and `HAVING COUNT(*) > 1` to identify and handle duplicate records.

### 2. Exploratory Data Analysis (15 Business Problems Solved)

The project tackles 15 distinct analytical questions ranging from simple counts to advanced window functions, string splitting, and conditional logic:

1. **Content Breakdown:** Count the number of Movies vs. TV Shows.
2. **Ratings Analysis:** Find the most common rating for movies and TV shows using CTEs and `RANK()`.
3. **Yearly Filter:** List all movies released in a specific year (e.g., 2020).
4. **Top Countries:** Identify the top 5 countries with the most content on Netflix.
5. **Longest Movie:** Find the movie with the longest duration using `LEN()`.
6. **Recent Additions:** Filter content added within a specific date range.
7. **Director Focus:** Find all titles directed by a specific director (e.g., *Rajiv Chilaka*).
8. **Long-running TV Shows:** List TV shows with more than 5 seasons.
9. **Genre Distribution:** Count content items across each genre (`listed_in`).
10. **Country-Specific Trends:** Find top release years and average content volume for a specific country (e.g., India).
11. **Documentary Filter:** List all movies categorized as documentaries.
12. **Content Without Directors:** Identify records missing a director's name.
13. **Actor Filmography:** Track an actor's appearances (e.g., *Salman Khan*) over a timeframe.
14. **Top Indian Actors:** Find the top 10 actors with the highest number of movies produced in India using `STRING_SPLIT`.
15. **Content Categorization:** Classify content descriptions into **'Bad'** (containing *kill* or *violence*) vs. **'Good'** using `CASE` statements.

---

## 🚀 Getting Started

### Prerequisites

* **SQL Server** (SQL Server Management Studio - SSMS)
* A SQL database instance to run the scripts.

### Execution Steps

1. Create and use your database:
```sql
CREATE DATABASE Netflix;
USE netflix;

```


2. Import your Netflix dataset into a table named `netflix_titles`.
3. Run the data cleaning scripts to handle nulls and duplicates.
4. Execute the analytical queries section by section to extract insights.

---

## Key Conclusions & Insights

**Movies vs. Shows:** Movies make up most of the library, but TV shows keep people hooked longer. Netflix needs a good mix of both.

**Targeted Regional Analysis:** Queries tracking production trends by country (such as India) show clear patterns of steady, high-volume releases over the years.

**Star Power Works:** Working with famous actors and top directors drives steady, reliable viewership and lowers the risk for new content.

**Content Tagging:** Checking descriptions for heavy words helps improve parental controls and makes it easier to recommend the right shows to the right people
